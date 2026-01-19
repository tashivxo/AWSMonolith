#!/usr/bin/env python
import os
from __init__ import create_app, db

# Create Flask app
app = create_app(os.environ.get('FLASK_ENV', 'development'))

if __name__ == '__main__':
    # Initialize database
    with app.app_context():
        db.create_all()
    
    # Run development server
    app.run(
        host='0.0.0.0',
        port=int(os.environ.get('PORT', 5000)),
        debug=os.environ.get('FLASK_ENV') == 'development'
    )
