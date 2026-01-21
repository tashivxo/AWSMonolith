# Week 4: Monitoring, Optimization & CI/CD

## Phase 1: CI/CD Pipeline (GitHub Actions) ✅

### Setup Steps

1. **Configure GitHub Secrets**
   ```
   Settings → Secrets and variables → Actions → New repository secret
   ```
   
   Add these secrets:
   - `AWS_ACCESS_KEY_ID` - Your AWS access key
   - `AWS_SECRET_ACCESS_KEY` - Your AWS secret key
   - `DOCKER_USERNAME` - Docker Hub username
   - `DOCKER_PASSWORD` - Docker Hub password/token
   - `EC2_PRIVATE_KEY` - Private key for EC2 SSH
   - `SLACK_WEBHOOK` - (Optional) Slack webhook for notifications

2. **GitHub Actions Workflow**
   - File: `.github/workflows/ci-cd.yml`
   - Triggers on: Push to main, Pull requests
   - Jobs:
     - **Test**: Run unit tests with pytest
     - **Lint**: Code quality checks (Black, Flake8, Pylint)
     - **Build**: Docker image build and push
     - **Deploy**: Automatic deployment to EC2 ASG

3. **Workflow Execution**
   - Automatic on every push to main branch
   - Tests must pass before deployment
   - Docker image created and pushed to Docker Hub
   - EC2 instances updated automatically
   - Health check verification post-deployment
   - Slack notification on success/failure

---

## Phase 2: Monitoring & CloudWatch ⏳

### CloudWatch Logs Setup

1. **Application Logs**
   ```bash
   # On EC2, configure CloudWatch Logs agent
   # View logs in AWS Console
   ```
   
   Logs captured:
   - Flask application logs
   - Nginx access/error logs
   - Gunicorn worker logs
   - Database query logs

2. **Create Log Groups**
   ```bash
   # Run in AWS Console or CLI
   aws logs create-log-group --log-group-name /aws/ec2/monolith/application
   aws logs create-log-group --log-group-name /aws/ec2/monolith/nginx
   aws logs create-log-group --log-group-name /aws/rds/monolith/database
   ```

### CloudWatch Metrics Setup

1. **Application Metrics**
   - Request count (per endpoint)
   - Response time (p50, p95, p99)
   - Error rate (4xx, 5xx)
   - Database connection pool usage

2. **Infrastructure Metrics**
   - EC2 CPU utilization
   - Memory usage
   - Disk I/O
   - Network throughput

3. **RDS Metrics**
   - Database connections
   - Query performance
   - Storage usage
   - Replication lag

### CloudWatch Dashboards

Create custom dashboard with:
```bash
# Dashboard name: AWSMonolith-Dashboard
# Widgets:
1. Application health status
2. Request throughput (requests/min)
3. Error rate (% of requests)
4. Average response time
5. EC2 instance CPU/Memory
6. RDS database connections
7. ALB target health
8. S3 bandwidth
```

### CloudWatch Alarms

Set up alarms for:
```
1. High CPU (>80%) → SNS notification
2. High error rate (>5%) → Auto-scale up
3. Low disk space (<10%) → SNS alert
4. Database connection issues → Lambda remediation
5. ALB unhealthy targets → Auto-recover
```

---

## Phase 3: Cost Optimization ⏳

### 1. AWS Cost Monitor
```bash
# Enable AWS Budgets
aws budgets create-budget \
  --account-id 123456789 \
  --budget "{Name:MonolithMonthly,BudgetLimit:{Amount:50,Unit:USD},TimeUnit:MONTHLY}"
```

### 2. Cost Explorer
- View breakdown by service (EC2, RDS, S3, ALB)
- Set monthly budget alert at $50
- Review reserved instances options

### 3. Optimization Actions
- [ ] Right-size EC2 instances (use Cost Optimizer)
- [ ] Consider Savings Plans for compute
- [ ] Archive old S3 objects to Glacier
- [ ] Enable S3 Intelligent-Tiering
- [ ] Review and optimize RDS backup retention

---

## Phase 4: HTTPS with ACM ⏳

### 1. Request SSL Certificate

```bash
aws acm request-certificate \
  --domain-name aws-monolith-alb-1638019826.us-east-1.elb.amazonaws.com \
  --domain-name *.example.com \
  --validation-method DNS
```

### 2. Validate Certificate

- Route 53: Add CNAME records for validation
- Wait for AWS to verify (usually 5-15 minutes)

### 3. Update ALB

```bash
# Add HTTPS listener on port 443
aws elbv2 create-listener \
  --load-balancer-arn arn:aws:elasticloadbalancing:... \
  --protocol HTTPS \
  --port 443 \
  --certificates CertificateArn=arn:aws:acm:...
```

### 4. Add HTTP→HTTPS Redirect

```bash
# Update existing HTTP listener to redirect
aws elbv2 modify-listener \
  --listener-arn arn:aws:elasticloadbalancing:... \
  --default-actions Type=redirect,RedirectConfig='{Protocol=HTTPS,Port=443,StatusCode=HTTP_301}'
```

### 5. Test HTTPS
```bash
curl -I https://aws-monolith-alb-1638019826.us-east-1.elb.amazonaws.com
```

---

## Phase 5: Caching Strategy ⏳

### 1. CloudFront Optimization

```bash
# Current CloudFront distribution: d15wps15d7ub1f.cloudfront.net
# Update cache behaviors:

1. Static assets (css, js, images)
   - TTL: 86400 (24 hours)
   - Compress: Yes
   - HTTP/2: Enable

2. API endpoints
   - TTL: 0 (no caching)
   - Pass cookies: Yes
   - Compress: Yes
```

### 2. ElastiCache (Session Storage)

```bash
# Create ElastiCache Redis cluster
aws elasticache create-cache-cluster \
  --cache-cluster-id monolith-cache \
  --engine redis \
  --cache-node-type cache.t3.micro \
  --engine-version 7.0 \
  --num-cache-nodes 1
```

Update Flask to use Redis:
```python
# app/config.py
SESSION_TYPE = 'redis'
SESSION_REDIS = redis.from_url('redis://monolith-cache.xxxxx.ng.0001.use1.cache.amazonaws.com:6379')
```

### 3. Application-Level Caching

```python
# Cache frequently accessed data
@app.cache.cached(timeout=300)
def get_projects():
    return Project.query.all()
```

---

## Checklist

### Week 4 Deliverables

- [ ] **GitHub Actions Setup**
  - [x] CI/CD workflow created (.github/workflows/ci-cd.yml)
  - [ ] Repository secrets configured
  - [ ] First workflow run successful
  - [ ] Docker Hub repository created

- [ ] **CloudWatch Monitoring**
  - [ ] Log groups created
  - [ ] Metrics enabled for EC2/RDS
  - [ ] Dashboard created
  - [ ] Alarms configured

- [ ] **Cost Management**
  - [ ] AWS Budgets configured
  - [ ] Cost Explorer reviewed
  - [ ] Optimization actions identified

- [ ] **HTTPS/Security**
  - [ ] ACM certificate requested
  - [ ] Certificate validated
  - [ ] ALB HTTPS listener configured
  - [ ] HTTP→HTTPS redirect enabled

- [ ] **Caching**
  - [ ] CloudFront cache behaviors optimized
  - [ ] ElastiCache (optional) set up
  - [ ] Application caching implemented

---

## Implementation Priority

1. **High Priority** (This week)
   - GitHub Actions setup & testing
   - CloudWatch basic monitoring
   - HTTPS with ACM

2. **Medium Priority** (Next week)
   - CloudWatch dashboards & alarms
   - Cost monitoring setup
   - ElastiCache integration

3. **Low Priority** (Future optimization)
   - Advanced caching strategies
   - Cost optimization fine-tuning

---

## Quick Start: GitHub Actions

1. **Push code with workflow**
   ```bash
   git add .
   git commit -m "Add GitHub Actions CI/CD pipeline"
   git push origin main
   ```

2. **Configure secrets in GitHub**
   - Go to repo Settings → Secrets
   - Add AWS credentials
   - Add Docker credentials

3. **Monitor workflow**
   - Go to Actions tab
   - Watch pipeline execute
   - Review test results

4. **Deploy on success**
   - Automatic deployment to EC2
   - Health check verification
   - Slack notification

---

## Troubleshooting

### Workflow Fails
- Check GitHub Actions logs
- Verify AWS credentials in secrets
- Review CloudFormation events

### Deployment Issues
- SSH key issues → Check EC2 security group
- Git pull fails → Verify GitHub SSH keys on EC2
- systemctl restart fails → Check service status

### Monitoring Problems
- CloudWatch logs not appearing → Verify IAM permissions
- Metrics not showing → Check EC2 CloudWatch agent
- Alarms not triggering → Review alarm threshold values

---

## Next Steps After Week 4

1. **Week 5+**
   - Advanced monitoring (X-Ray tracing)
   - Auto-scaling policies refinement
   - Database optimization
   - Application performance monitoring (APM)

2. **Security Enhancements**
   - WAF (Web Application Firewall) rules
   - DDoS protection
   - Secrets rotation

3. **Disaster Recovery**
   - Multi-region failover
   - Database replication
   - Backup automation
