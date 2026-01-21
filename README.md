# 🚀 AWSMonolith - Internal Business Management System

A production-ready monolithic web application for managing projects, inventory, and internal contacts (CRM). Built with Flask, SQLAlchemy, and deployed on AWS infrastructure.

## 📋 Features

- **Project Management** - Create, track, and manage projects with budgets and timelines
- **Inventory Tracking** - Manage inventory items with SKU, quantities, and pricing
- **Contact Management (CRM)** - Store and organize internal contacts by department and company
- **RESTful API** - Complete REST API with 20 endpoints for all operations
- **Responsive UI** - Modern, clean interface with HTML5, CSS3, and Vanilla JavaScript
- **Database Integration** - SQLAlchemy ORM with MySQL/SQLite support
- **Production Ready** - Gunicorn + Nginx + systemd for deployment on AWS

## 🏗️ Architecture

- **Frontend**: Single-page application (SPA) with responsive design
- **Backend**: Flask monolithic application with 20 RESTful endpoints
- **Database**: SQLAlchemy ORM (MySQL in production, SQLite for development)
- **Server**: Gunicorn WSGI + Nginx reverse proxy
- **Cloud**: AWS (EC2, ALB, RDS, S3, CloudFront, VPC)
- **Monitoring**: CloudWatch logs and metrics

## 📁 Project Structure

```
AWSMonolith/
├── app/                          # Flask application
│   ├── __init__.py              # Flask factory
│   ├── config.py                # Configuration (dev/prod/test)
│   ├── models.py                # SQLAlchemy models (Project, Inventory, Contact)
│   ├── routes.py                # 20 RESTful API endpoints
│   ├── run.py                   # Application entry point
│   ├── requirements.txt         # Python dependencies
│   ├── deploy.sh                # Production deployment script
│   ├── static/
│   │   ├── css/style.css        # Professional styling
│   │   └── js/app.js            # Frontend logic
│   └── templates/
│       └── index.html           # Single-page application
├── terraform/                    # Infrastructure as Code
│   ├── main.tf                  # AWS resources (20+ resources)
│   ├── variables.tf             # Configuration variables
│   ├── terraform.tfvars         # Variable values
│   └── user_data.sh             # EC2 initialization
├── Architecture document/        # Design documentation
└── README.md                     # This file
```

## 🏃 Getting Started

### Prerequisites

- Python 3.8+
- pip package manager
- Git

### Installation & Local Setup

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

### Docker Setup (Optional)

```powershell
docker build -t awsmonolith .
docker run -p 5000:5000 awsmonolith
```

## 📊 Database Models

### Project
- id, name, description, status, owner, budget, start_date, end_date, timestamps

### InventoryItem
- id, name, sku, quantity, unit_price, category, location, reorder_level, timestamps

### Contact
- id, first_name, last_name, email, phone, department, job_title, company, status, timestamps

## 🔗 API Endpoints

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

## ☁️ Deployment to AWS

### Infrastructure Setup (Week 2)

```powershell
cd terraform
terraform init
terraform plan
terraform apply
```

### Application Deployment (Week 3)

```bash
# SSH into EC2 instance, then:
cd /opt/monolith
bash deploy.sh
```

**Access the application:**
```
http://aws-monolith-alb-1638019826.us-east-1.elb.amazonaws.com
```

## 🛠️ Tech Stack

| Component | Technology |
|-----------|-----------|
| Backend | Flask 3.0.0 |
| ORM | SQLAlchemy 3.1.1 |
| Database | MySQL 8.0 / SQLite |
| Server | Gunicorn 21.2.0 + Nginx |
| Frontend | HTML5, CSS3, Vanilla JavaScript |
| Cloud | AWS (EC2, ALB, RDS, S3, CloudFront) |
| IaC | Terraform 1.7.0 |

## 📝 Environment Variables

```powershell
# Development
$env:FLASK_ENV = 'development'
$env:DATABASE_URL = 'sqlite:///test.db'

# Production (AWS)
$env:FLASK_ENV = 'production'
$env:DATABASE_URL = 'mysql+pymysql://user:pass@rds-endpoint:3306/db'
$env:SECRET_KEY = '<your-secret-key>'
```

## 📚 Documentation

- **Architecture**: See `Architecture document/Architecture document.txt`
- **Deployment Guide**: See `WEEK3_DEPLOYMENT.md`
- **Project Status**: See `PROJECT_SUMMARY.md`

## 🔒 Security Features

- CORS enabled for API access
- SQLAlchemy ORM prevents SQL injection
- Environment-based configuration
- IAM roles with least-privilege policies
- VPC isolation for database
- HTTPS ready (ACM certificates)

## 📊 Monitoring & Logging

- CloudWatch logs collection
- Application error tracking
- Performance metrics
- Auto-scaling based on demand

## 🚀 Performance Optimizations

- Multi-worker Gunicorn server
- Nginx reverse proxy caching
- CloudFront CDN for static assets
- Database connection pooling
- Auto Scaling Group (2-4 instances)

## 📞 Support & Maintenance

For issues or questions:
1. Check the architecture documentation
2. Review deployment logs in CloudWatch
3. Verify database connectivity
4. Check EC2 instance health

## 📄 License

Internal business application - supernova INC

## 🎯 Status

✅ **Week 1**: Architecture designed
✅ **Week 2**: Infrastructure deployed on AWS
✅ **Week 3**: Application developed and tested
⏳ **Week 4**: Monitoring and CI/CD (in progress)

