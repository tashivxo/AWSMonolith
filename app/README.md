# AWS Monolith Application

Production-ready monolithic web application for internal business management (Projects, Inventory, CRM).

## Features

- **Project Management**: Create, read, update, delete projects with budgets and timelines
- **Inventory Tracking**: Manage inventory items with SKU, quantity, pricing, and location
- **Contact Management (CRM)**: Store and manage internal contacts with department and company information
- **RESTful API**: Complete REST API for all operations
- **Modern UI**: Clean, responsive HTML/CSS/JavaScript interface
- **Database**: MySQL backend with SQLAlchemy ORM

## Tech Stack

- **Backend**: Flask (Python)
- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Database**: MySQL 8.0
- **Server**: Gunicorn + Nginx
- **Monitoring**: CloudWatch Logs & Metrics

## Project Structure

```
app/
├── __init__.py           # Flask application factory
├── config.py             # Configuration management
├── models.py             # SQLAlchemy database models
├── routes.py             # API and web routes
├── run.py                # Application entry point
├── requirements.txt      # Python dependencies
├── deploy.sh             # Deployment script
├── static/
│   ├── css/style.css     # Application styling
│   └── js/app.js         # Frontend JavaScript
└── templates/
    └── index.html        # Main HTML template
```

## Database Models

### Project
- id, name, description, status, start_date, end_date, owner, budget, timestamps

### InventoryItem
- id, name, sku, description, quantity, unit_price, category, location, reorder_level, timestamps

### Contact
- id, first_name, last_name, email, phone, department, job_title, company, notes, status, timestamps

## API Endpoints

### Projects
- `GET /api/projects` - List all projects
- `GET /api/projects/<id>` - Get project details
- `POST /api/projects` - Create new project
- `PUT /api/projects/<id>` - Update project
- `DELETE /api/projects/<id>` - Delete project

### Inventory
- `GET /api/inventory` - List all items
- `GET /api/inventory/<id>` - Get item details
- `POST /api/inventory` - Create new item
- `PUT /api/inventory/<id>` - Update item
- `DELETE /api/inventory/<id>` - Delete item

### Contacts
- `GET /api/contacts` - List all contacts
- `GET /api/contacts/<id>` - Get contact details
- `POST /api/contacts` - Create new contact
- `PUT /api/contacts/<id>` - Update contact
- `DELETE /api/contacts/<id>` - Delete contact

### Health
- `GET /api/health` - Health check endpoint

## Installation & Setup

### Local Development

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set environment variables
export FLASK_ENV=development
export DATABASE_URL=mysql+pymysql://user:password@localhost/monolithdb

# Run application
python run.py
```

The application will be available at `http://localhost:5000`

### Production Deployment

The `deploy.sh` script handles:
1. System package installation
2. Python environment setup
3. Application code deployment
4. Database initialization
5. Systemd service configuration
6. Nginx reverse proxy setup
7. CloudWatch logging configuration

Run via EC2 user data or CodeDeploy

## Environment Variables

- `FLASK_ENV`: development, testing, or production
- `DATABASE_URL`: MySQL connection string
- `SECRET_KEY`: Flask session encryption key
- `PORT`: Application port (default: 5000)

## Security Features

- HTTPS-ready (use with CloudFront + ACM)
- CORS enabled for cross-origin requests
- SQL injection protection (SQLAlchemy ORM)
- Session cookie security (HTTPOnly, Secure flags)
- Input validation on all API endpoints

## Monitoring

Application logs are sent to CloudWatch:
- Application logs: `/aws/ec2/monolith`
- System logs: CloudWatch Logs Agent
- Metrics: Custom CloudWatch metrics (CPU, Memory, Request rates)

## Testing

```bash
# Run unit tests
pytest tests/

# Check code coverage
pytest --cov=app tests/
```

## Deployment Architecture

```
User → CloudFront (Static) → ALB → EC2 (Nginx + Gunicorn + Flask) → RDS (MySQL)
                                    ↓
                              S3 (Static Assets)
```

## Notes

- Free Tier optimized (t3.micro EC2, db.t3.micro RDS)
- Horizontal scaling via Auto Scaling Group
- Session management works with multiple instances
- Database connection pooling for performance
- Static asset caching via CloudFront

## Troubleshooting

**Application won't start:**
```bash
systemctl status monolith
journalctl -u monolith -n 50
```

**Database connection issues:**
- Verify RDS endpoint in .env
- Check security group allows port 3306
- Verify credentials match RDS master user

**Nginx errors:**
```bash
nginx -t
systemctl restart nginx
```

See deployment logs:
```bash
tail -f /var/log/monolith-deployment.log
```

## Future Enhancements

- User authentication & authorization
- Advanced search and filtering
- File uploads for projects/inventory
- Email notifications
- Bulk import/export (CSV)
- Advanced analytics dashboards
- Mobile app support
- WebSocket real-time updates
