var express = require('express');
var router = express.Router();
const axios = require('axios');
const db = require('../db');
const bcrypt = require('bcrypt');
const { HttpsProxyAgent } = require('https-proxy-agent');

// Login page
router.get('/login', function(req, res) {
  res.render('login');
});

// Login handler
router.post('/login', async function(req, res) {
  const { email, password } = req.body;
  try {
    const [rows] = await db.query('SELECT * FROM Users WHERE email = ?', [email]);
    if (rows.length === 0) {
      return res.render('login', { error: 'User does not exist' });
    }
    const user = rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.render('login', { error: 'Incorrect password' });
    }
    // Login successful, save user info to session
    req.session.user = { user_id: user.user_id, user_name: user.user_name, email: user.email };
    res.redirect('/users/dashboard');
  } catch (err) {
    res.render('login', { error: 'Server error' });
  }
});

// Register page
router.get('/register', function(req, res) {
  res.render('register');
});

// Register handler
router.post('/register', async function(req, res) {
  const { user_name, email, password, avatar_url } = req.body;
  try {
    const [rows] = await db.query('SELECT * FROM Users WHERE email = ?', [email]);
    if (rows.length > 0) {
      return res.render('register', { error: 'Email already registered' });
    }
    const hash = await bcrypt.hash(password, 10);
    await db.query('INSERT INTO Users (user_name, email, password, avatar_url) VALUES (?, ?, ?, ?)', [user_name, email, hash, avatar_url]);
    res.redirect('/users/login');
  } catch (err) {
    res.render('register', { error: 'Server error' });
  }
});

// Logout
router.get('/logout', function(req, res) {
  req.session.destroy(() => {
    res.redirect('/users/login');
  });
});

// Profile page
router.get('/profile', async function(req, res) {
  if (!req.session.user) return res.redirect('/users/login');
  const [rows] = await db.query('SELECT * FROM Users WHERE user_id = ?', [req.session.user.user_id]);
  res.render('profile', { user: rows[0] });
});

// Profile update
router.post('/profile', async function(req, res) {
  if (!req.session.user) return res.redirect('/users/login');
  const { user_name, avatar_url, password } = req.body;
  let sql, params;
  if (password) {
    const hash = await bcrypt.hash(password, 10);
    sql = 'UPDATE Users SET user_name=?, avatar_url=?, password=? WHERE user_id=?';
    params = [user_name, avatar_url, hash, req.session.user.user_id];
  } else {
    sql = 'UPDATE Users SET user_name=?, avatar_url=? WHERE user_id=?';
    params = [user_name, avatar_url, req.session.user.user_id];
  }
  await db.query(sql, params);
  res.redirect('/users/profile');
});

// Dashboard after login
router.get('/dashboard', (req, res) => {
  if (!req.session.user) return res.redirect('/users/login');
  res.render('dashboard', { user: req.session.user });
});

// Search books
router.post('/search_books', async (req, res) => {
  const { keyword, sortBy, searchType } = req.body; // Added searchType
  let q = keyword;
  if (searchType === 'author') {
    q = `inauthor:${keyword}`;
  } else if (searchType === 'title') {
    q = `intitle:${keyword}`;
  }
  const url = `https://www.googleapis.com/books/v1/volumes?q=${encodeURIComponent(q)}`;
  try {
    // const agent = new HttpsProxyAgent('http://127.0.0.1:7890');
    // const result = await axios.get(url, { httpsAgent: agent });
    const result = await axios.get(url);
    let items = result.data.items || [];
    if (sortBy === 'title') {
      items = items.sort((a, b) => {
        const t1 = a.volumeInfo.title || '';
        const t2 = b.volumeInfo.title || '';
        return t1.localeCompare(t2);
      });
    } else if (sortBy === 'publishedDate') {
      items = items.sort((a, b) => {
        const d1 = Date.parse(a.volumeInfo.publishedDate || '1970-01-01');
        const d2 = Date.parse(b.volumeInfo.publishedDate || '1970-01-01');
        return d2 - d1;
      });
    }
    res.json({ items });
  } catch (e) {
    console.error("Search failed",e.message);
    res.json({ items: [] });
  }
});

// Collect book
router.post('/collect_book', async (req, res) => {
  if (!req.session.user) return res.json({ success: false, message: 'Not logged in' });
  const { bookId } = req.body;
  if (!bookId) return res.status(400).json({ success: false, message: 'Missing book ID parameter' });
  // Check if already collected
  const [rows] = await db.query('SELECT 1 FROM UserBooks WHERE user_id=? AND book_id=?', [req.session.user.user_id, bookId]);
  if (rows.length > 0) {
    return res.json({ success: false, message: 'You have already collected this book' });
  }
  // Get book details
  const url = `https://www.googleapis.com/books/v1/volumes/${bookId}`;
  try {
    // const agent = new HttpsProxyAgent('http://127.0.0.1:7890');
    // const result = await axios.get(url, { httpsAgent: agent });
    const result = await axios.get(url);
    if (result.status !== 200 || !result.data.volumeInfo) {
      throw new Error('Invalid book API response');
    }
    const info = result.data.volumeInfo;
    const title = info.title || '';
    const authors = (info.authors || []).join(', ');
    const publisher = info.publisher || '';
    const description = info.description || '';
    const categories = (info.categories || []).join(', ');
    const cover = info.imageLinks?.thumbnail || '';
    const industryId = bookId;
    await db.query(
      'INSERT IGNORE INTO Books (book_id, title, authors, description, cover_image, publisher, categories) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [industryId, title, authors, description, cover, publisher, categories]
    );
    await db.query(
      'INSERT INTO UserBooks (user_id, book_id) VALUES (?, ?)',
      [req.session.user.user_id, industryId]
    );
    res.json({ success: true, message: 'Collection successful' });
  } catch (e) {
    res.json({ success: false, message: 'Collection failed' });
  }
});

// Get my collections
router.get('/mybooks', async (req, res) => {
  if (!req.session.user) return res.json({ books: [] });
  const [rows] = await db.query(
    'SELECT b.book_id, b.title, b.authors, b.cover_image FROM Books b JOIN UserBooks u ON b.book_id=u.book_id WHERE u.user_id=?',
    [req.session.user.user_id]
  );
  res.json({ books: rows });
});

// Remove collection
router.post('/remove_book', async (req, res) => {
  if (!req.session.user) return res.json({ success: false });
  const { bookId } = req.body;
  const [rows] = await db.query('SELECT book_id FROM Books WHERE book_id=?', [bookId]);
  if (rows.length) {
    await db.query('DELETE FROM UserBooks WHERE user_id=? AND book_id=?', [req.session.user.user_id, rows[0].book_id]);
  }
  res.json({ success: true });
});

module.exports = router;
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;
