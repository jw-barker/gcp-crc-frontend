# Cloud Resume Challenge

## Overview
This repository contains my implementation of the Cloud Resume Challenge, designed to enhance my cloud skills through hands-on experience. The project involves deploying a static website, integrating it with cloud services, and implementing CI/CD pipelines.

## Tech Stack
- **Frontend**: HTML, CSS, JavaScript
- **Cloud Provider**: Google Cloud Platform
- **Infrastructure as Code (IaC)**: Terraform
- **Backend**: Cloud Run, Firestore
- **CI/CD**: GitHub Actions
- **Monitoring & Logging**: Cloud Logging, Cloud Monitoring
- **Security**: IAM, Cloud Storage permissions

## Features
- Fully serverless architecture
- Automated deployment using CI/CD
- Visitor counter stored in a cloud database
- HTTPS-enabled static site hosting

## Deployment Steps
1. **Frontend**:
   - Write HTML, CSS, and JavaScript for the static website
   - Deploy to GCP Cloud Storage with a public bucket
   - Enable Cloud CDN for performance

2. **Backend**:
   - Implement a serverless function to handle visitor count
   - Store count in Firestore
   - Deploy using Terraform

3. **CI/CD**:
   - Configure GitHub Actions for automated deployments.
   - Set up Terraform workflows for infrastructure automation.

## Progress
- [x] Set up repository
- [x] Deploy static site to Cloud Storage
- [ ] Implement serverless function for visitor counter
- [x] Configure Firestore database
- [x] Automate deployment with CI/CD
- [ ] Add monitoring and logging

## Lessons Learned
- Hands-on experience with GCP and Terraform
- Implementing secure and scalable cloud infrastructure
- Automating deployments using GitHub Actions

## Future Enhancements
- Add API Gateway for better security and scalability
- Implement caching to reduce database calls
- Improve UI and responsiveness