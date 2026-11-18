-- MAMI HOUSE & CO — Database Schema (PostgreSQL / MySQL compatible)
CREATE TABLE IF NOT EXISTS site_config (
  id INTEGER PRIMARY KEY,
  site_name VARCHAR(120) NOT NULL,
  company_full_name VARCHAR(200),
  slogan TEXT,
  primary_color VARCHAR(20),
  accent_color VARCHAR(20),
  bg_color VARCHAR(20),
  github_owner VARCHAR(120),
  github_repo VARCHAR(120),
  github_branch VARCHAR(60) DEFAULT 'main',
  github_path VARCHAR(200) DEFAULT 'data/db.json',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categories (
  id VARCHAR(64) PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  slug VARCHAR(160) UNIQUE NOT NULL,
  description TEXT
);

CREATE TABLE IF NOT EXISTS products (
  id VARCHAR(64) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  category_id VARCHAR(64) REFERENCES categories(id),
  brand VARCHAR(120),
  price INTEGER NOT NULL,
  original_price INTEGER,
  stock INTEGER DEFAULT 0,
  sold_count INTEGER DEFAULT 0,
  rating NUMERIC(3,2) DEFAULT 5.0,
  is_new BOOLEAN DEFAULT FALSE,
  is_best_seller BOOLEAN DEFAULT FALSE,
  short_desc TEXT,
  description TEXT,
  images_json TEXT,
  variants_json TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customers (
  id VARCHAR(64) PRIMARY KEY,
  name VARCHAR(160) NOT NULL,
  phone VARCHAR(30),
  email VARCHAR(160),
  address TEXT,
  total_orders INTEGER DEFAULT 0,
  total_spent INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS orders (
  id VARCHAR(64) PRIMARY KEY,
  customer_id VARCHAR(64) REFERENCES customers(id),
  customer_name VARCHAR(160) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  address TEXT NOT NULL,
  payment_method VARCHAR(60),
  status VARCHAR(60) DEFAULT 'Chờ xác nhận',
  subtotal INTEGER NOT NULL,
  discount INTEGER DEFAULT 0,
  shipping_fee INTEGER DEFAULT 0,
  total INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id VARCHAR(64) REFERENCES orders(id) ON DELETE CASCADE,
  product_id VARCHAR(64) REFERENCES products(id),
  product_name VARCHAR(255) NOT NULL,
  variant VARCHAR(120),
  quantity INTEGER NOT NULL,
  unit_price INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS coupons (
  code VARCHAR(64) PRIMARY KEY,
  type VARCHAR(20) NOT NULL,
  value INTEGER NOT NULL,
  min_order INTEGER DEFAULT 0,
  active BOOLEAN DEFAULT TRUE,
  expires_at DATE
);

CREATE TABLE IF NOT EXISTS blogs (
  id VARCHAR(64) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  category VARCHAR(120),
  excerpt TEXT,
  content TEXT,
  published_at DATE
);
