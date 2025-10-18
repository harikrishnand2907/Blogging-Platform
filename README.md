# Rails Blogging Platform

This is a **Ruby on Rails Blogging Platform** project that allows users to create, manage, and export blog posts. The application supports user authentication with Devise, PDF generation with Prawn, and uses PostgreSQL as the database.

---

## Prerequisites
1. **Ruby 3.0+** with MSYS2 and MINGW development toolchain
   * Download: [Ruby Installer](https://rubyinstaller.org/downloads/)
2. **PostgreSQL 13+**
   * Download: [PostgreSQL](https://www.enterprisedb.com/postgresql-tutorial-resources-training-1?uuid=867f9c7f-7be7-44ed-b03f-103a0a430d51&campaignId=postgres_rc_18)
3. **Bundler** (for managing dependencies)

---

## Installation Steps

Follow these steps to set up the project:

1. **Update RubyGems system**
   gem update --system

2. **Install Bundler**
   gem install bundler

3. **Install Rails**
   gem install rails

4. **Install required gems**
   gem install devise
   gem install prawn

5. **Install project dependencies**
   bundle install

6. **Configure database**

   * Open `config/database.yml` and update your PostgreSQL credentials accordingly.

7. **Set up the database**
   rails db:drop db:create db:migrate

---

## Running the Application

Start the Rails server using either of the commands below:
rails server or rails _7.1.5.2_ server

Once the server is running, open your browser and navigate to:
http://localhost:3000

---

## Features

* User authentication (sign-up, login, logout) via Devise
* CRUD operations for blog posts
* PDF export of blog posts using Prawn
* CSV import of blog posts  
* PostgreSQL database integration

---

## Author
**Hari Krishnan D**