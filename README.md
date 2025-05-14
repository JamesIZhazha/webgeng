# Personal Library Management System

## Project Overview
This project is a personal library management system based on Node.js + Express + EJS. It supports user registration, login, profile management, book collection, book search, and admin backend management.

## Database Initialization and Operations
1. **Database Structure**:
   - The database script is located in the `database_schema.sql` file.
   - It includes three main tables: Users (user table), Books (book table), UserBooks (user book collection table), and an admin identifier field.
2. **Execute Database Script**:
   - Use a MySQL client or visualization tool to execute the `database_schema.sql` file:
     ```sql
     source /path/to/database_schema.sql;
     ```
   - Ensure the database is created and switched to the target database.

## Code Database Configuration
1. **Database Configuration File**:
   - The database connection configuration is in the `db.js` file.
   - Modify the following content to match your database environment:
     ```js
     // ... existing code ...
     const pool = mysql.createPool({
       host: 'localhost', // Database host
       user: 'your_mysql_user', // Database username
       password: 'your_mysql_password', // Database password
       database: 'your_database_name', // Database name
       // ... other configurations ...
     });
     // ... existing code ...
     ```

## Project Startup and Running
1. **Start the Project**:
   - npm start
2. **Access Address**:
   - Default at http://localhost:3000/

## Main Features

### Login

#### User Login

Username: 111@qq.com

Password: 111

#### Admin Login

Username: admin@qq.com

Password: admin

### User Features:
- User registration, login, logout  
  - Related code: `routes/users.js` (registration, login, logout endpoints), `views/login.ejs`, `views/register.ejs` (frontend pages), `views/profile.ejs` (profile page)
- View and edit personal profile (username, avatar, password)  
  - Related code: `routes/users.js` (profile retrieval and update endpoints), `views/profile.ejs` (profile edit page)
- Book search (by title, author, supports sorting)  
  - Related code: `routes/users.js` (search-related endpoints), `views/dashboard.ejs` (search and display page)
- Collect books, add tags, notes, ratings, reading status  
  - Related code: `routes/users.js` (collection, tags, notes, ratings, status endpoints), `views/dashboard.ejs` (collection and operation interface)
- View and manage personal collections  
  - Related code: `routes/users.js` (retrieve personal collection endpoint), `views/dashboard.ejs` (collection display)

### Admin Features:
- Admin login, logout  
  - Related code: `routes/admin.js` (admin login, logout endpoints), `views/admin_login.ejs` (login page)
- User management (view, edit, delete users, set admin permissions)  
  - Related code: `routes/admin.js` (user management endpoints), `views/admin_users.ejs` (user management page), `views/admin_edit_user.ejs` (edit user page)