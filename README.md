# AWSMonolith - Internal Business Management System

A production-ready monolithic web application for managing projects, inventory, and internal contacts (CRM). Built with Flask, SQLAlchemy, and deployed on AWS infrastructure.

## Features

- **Project Management** - Create, track, and manage projects with budgets and timelines
- **Inventory Tracking** - Manage inventory items with SKU, quantities, and pricing
- **Contact Management (CRM)** - Store and organize internal contacts by department and company
- **RESTful API** - Complete REST API with 20 endpoints for all operations
- **Responsive UI** - Modern, clean interface with HTML5, CSS3, and Vanilla JavaScript
- **Database Integration** - SQLAlchemy ORM with MySQL/SQLite support
- **Production Ready** - Gunicorn + Nginx + systemd for deployment on AWS

## 🚀 Quick Start

### Run Locally (Development)

```powershell
cd "C:\Users\tashi\repos\Tashiv Work\Internal Management\AWSMonolith\app"
.\venv\Scripts\Activate.ps1
$env:FLASK_ENV = 'development'
$env:DATABASE_URL = 'sqlite:///test.db'
python run.py
```

Open browser: **http://localhost:5000**

### Run on AWS (Production)

```bash
cd /opt/monolith
bash deploy.sh
```

Access via ALB: **http://aws-monolith-alb-1638019826.us-east-1.elb.amazonaws.com**

---

## 🏗️ Architecture

- **Frontend**: Single-page application (SPA) with responsive design
- **Backend**: Flask monolithic application with 20 RESTful endpoints
- **Database**: SQLAlchemy ORM (MySQL in production, SQLite for development)
- **Server**: Gunicorn WSGI + Nginx reverse proxy
- **Cloud**: AWS (EC2, ALB, RDS, S3, CloudFront, VPC)
- **Monitoring**: CloudWatch logs and metrics

## 📦 Installation & Local Setup

#### 1. Clone and Navigate

```powershell
cd "C:\Users\tashi\repos\Tashiv Work\Internal Management\AWSMonolith\app"
```

#### 2. Create Virtual Environment

```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

#### 3. Install Dependencies

```powershell
pip install -r requirements.txt
```

#### 4. Run Development Server

```powershell
$env:FLASK_ENV = 'development'
$env:DATABASE_URL = 'sqlite:///test.db'
python run.py
```

#### 5. Open in Browser

```
http://localhost:5000
```








   ## List of API ENDPOints for reference


### Projects
- `GET /api/projects` - List all projects
- `POST /api/projects` - Create project
- `GET /api/projects/<id>` - Get project details
- `PUT /api/projects/<id>` - Update project
- `DELETE /api/projects/<id>` - Delete project

### Inventory
- `GET /api/inventory` - List all items
- `POST /api/inventory` - Create item
- `GET /api/inventory/<id>` - Get item details
- `PUT /api/inventory/<id>` - Update item
- `DELETE /api/inventory/<id>` - Delete item

### Contacts
- `GET /api/contacts` - List all contacts
- `POST /api/contacts` - Create contact
- `GET /api/contacts/<id>` - Get contact details
- `PUT /api/contacts/<id>` - Update contact
- `DELETE /api/contacts/<id>` - Delete contact

### Health
- `GET /api/health` - Health check endpoint





**Access the application:**
```
http://aws-monolith-alb-1638019826.us-east-1.elb.amazonaws.com
```

## Tech Stack

| Component | Technology |
|-----------|-----------|

| Backend - Flask 3.0.0 |
| ORM - SQLAlchemy 3.1.1 |
| Database - MySQL 8.0 / SQLite |
| Server - Gunicorn 21.2.0 + Nginx |
| Frontend - HTML5, CSS3, Vanilla JavaScript |
| Cloud - AWS (EC2, ALB, RDS, S3, CloudFront) |
| IaC - Terraform 1.7.0 |




