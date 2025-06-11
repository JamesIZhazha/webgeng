# 个人图书管理系统

## 项目简介
本项目是一个基于 Node.js + Express + EJS 的个人图书管理系统，支持用户注册、登录、个人资料管理、图书收藏、书籍搜索、管理员后台管理等功能。

## 数据库初始化与操作
1. **数据库结构**：
   - 数据库脚本位于 `database_schema.sql` 文件。
   - 包含三张主要表：Users（用户表）、Books（图书表）、UserBooks（用户图书收藏表），以及管理员标识字段。
2. **执行数据库脚本**：
   - 使用 MySQL 客户端或可视化工具执行 `database_schema.sql` 文件：
     ```sql
     source /path/to/database_schema.sql;
     ```
   - 确保已创建数据库并切换到目标数据库。

## 代码数据库配置修改
右键新建数据库，根据图片创建后 再右键选择运行SQL文件即可。
![alt text](image.png)

1. **数据库配置文件**：
   - 数据库连接配置在 `db.js` 文件中。
   - 修改如下内容以适配你的数据库环境：
     ```js
     // ... existing code ...
     const pool = mysql.createPool({
       host: 'localhost', // 数据库主机
       user: 'your_mysql_user', // 数据库用户名
       password: 'your_mysql_password', // 数据库密码
       database: 'your_database_name', // 数据库名
       // ... 其他配置 ...
     });
     // ... existing code ...
     ```

## 项目启动与运行
1. **启动项目**：
   - npm start
2. **访问地址**：
   - 默认在 http://localhost:3000/  

## 主要功能说明

### 登录

#### 用户登录

用户名：111@qq.com

密码：111

#### 管理员登录

用户名：admin@qq.com

密码：admin

### 用户端功能：
- 用户注册、登录、登出  
  - 相关代码：`routes/users.js`（注册、登录、登出接口），`views/login.ejs`、`views/register.ejs`（前端页面），`views/profile.ejs`（个人信息页）
- 个人资料查看与修改（用户名、头像、密码）  
  - 相关代码：`routes/users.js`（资料获取与修改接口），`views/profile.ejs`（资料编辑页面）
- 图书搜索（按书名、作者，支持排序）  
  - 相关代码：`routes/users.js`（搜索相关接口），`views/dashboard.ejs`（搜索与展示页面）
- 收藏图书、添加标签、笔记、评分、阅读状态  
  - 相关代码：`routes/users.js`（收藏、标签、笔记、评分、状态接口），`views/dashboard.ejs`（收藏与操作界面）
- 查看和管理个人收藏  
  - 相关代码：`routes/users.js`（获取个人收藏接口），`views/dashboard.ejs`（收藏展示）
### 管理员端功能：
- 管理员登录、登出  
  - 相关代码：`routes/admin.js`（管理员登录、登出接口），`views/admin_login.ejs`（登录页面）
- 用户管理（查看、编辑、删除用户，设置管理员权限）  
  - 相关代码：`routes/admin.js`（用户管理接口），`views/admin_users.ejs`（用户管理页面），`views/admin_edit_user.ejs`（编辑用户页面）