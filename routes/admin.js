var express = require('express');
var router = express.Router();
const db = require('../db');
const bcrypt = require('bcrypt');

// Admin login page
router.get('/login', function(req, res) {
  res.render('admin_login');
});

// Admin login handler (Assume admin account has is_admin field in Users table, 1 means admin)
router.post('/login', async function(req, res) {
  const { email, password } = req.body;
  const [rows] = await db.query('SELECT * FROM Users WHERE email = ? AND is_admin = 1', [email]);
  if (rows.length === 0) return res.render('admin_login', { error: 'Admin does not exist' });
  const admin = rows[0];
  const match = await bcrypt.compare(password, admin.password);
  if (!match) return res.render('admin_login', { error: 'Incorrect password' });
  req.session.admin = { user_id: admin.user_id, user_name: admin.user_name, email: admin.email };
  res.redirect('/admin/users');
});

// Admin logout
router.get('/logout', function(req, res) {
  req.session.admin = null;
  res.redirect('/admin/login');
});

// User list
router.get('/users', async function(req, res) {
  if (!req.session.admin) return res.redirect('/admin/login');
  const [users] = await db.query('SELECT * FROM Users');
  res.render('admin_users', { users });
});

// Add user page
router.get('/add', function(req, res) {
  if (!req.session.admin) return res.redirect('/admin/login');
  res.render('admin_edit_user', { user: null });
});

// Add user handler
router.post('/add', async function(req, res) {
  if (!req.session.admin) return res.redirect('/admin/login');
  const { user_name, email, password, avatar_url } = req.body;
  const [rows] = await db.query('SELECT * FROM Users WHERE email = ?', [email]);
  if (rows.length > 0) return res.render('admin_edit_user', { user: null, error: 'Email already exists' });
  const hash = await bcrypt.hash(password, 10);
  await db.query('INSERT INTO Users (user_name, email, password, avatar_url) VALUES (?, ?, ?, ?)', [user_name, email, hash, avatar_url]);
  res.redirect('/admin/users');
});

// Edit user page
router.get('/edit/:id', async function(req, res) {
  if (!req.session.admin) return res.redirect('/admin/login');
  const [rows] = await db.query('SELECT * FROM Users WHERE user_id = ?', [req.params.id]);
  if (rows.length === 0) return res.redirect('/admin/users');
  res.render('admin_edit_user', { user: rows[0] });
});

// Edit user handler
router.post('/edit/:id', async function(req, res) {
  if (!req.session.admin) return res.redirect('/admin/login');
  const { user_name, avatar_url, password } = req.body;
  let sql, params;
  if (password) {
    const hash = await bcrypt.hash(password, 10);
    sql = 'UPDATE Users SET user_name=?, avatar_url=?, password=? WHERE user_id=?';
    params = [user_name, avatar_url, hash, req.params.id];
  } else {
    sql = 'UPDATE Users SET user_name=?, avatar_url=? WHERE user_id=?';
    params = [user_name, avatar_url, req.params.id];
  }
  await db.query(sql, params);
  res.redirect('/admin/users');
});

// Delete user
router.post('/delete/:id', async function(req, res) {
  if (!req.session.admin) return res.redirect('/admin/login');
  await db.query('DELETE FROM Users WHERE user_id = ?', [req.params.id]);
  res.redirect('/admin/users');
});

module.exports = router;