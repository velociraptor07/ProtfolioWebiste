# 🌐 Portfolio Website Deployment with Terraform & Azure

This project demonstrates **Infrastructure as Code (IaC)** and **CI/CD automation** by deploying a personal portfolio website to **Azure App Service** using **Terraform** and **GitHub Actions**.

---

## 🚀 Project Overview
- Built a simple static portfolio site (`index.html`, `style.css`).
- Provisioned cloud infrastructure with **Terraform**:
  - Azure Resource Group  
  - App Service Plan  
  - Windows Web App (with HTTPS enforced)  
- Configured **remote state management** using an Azure Storage Account container.
- Automated deployments with **GitHub Actions**, so each push to `main` publishes updates to the web app.

The website was successfully deployed and hosted at:  
👉 **https://yash-portfolio-new.azurewebsites.net**

---

## 🛠️ Technologies Used
- **Terraform** (Infrastructure as Code)  
- **Azure Resource Manager** (Resource Groups, App Service, Storage)  
- **Azure App Service** (Web App hosting)  
- **GitHub Actions** (CI/CD pipeline)  

---

## ⚙️ Architecture
1. **Terraform Backend**: Remote state stored securely in an Azure Storage Account.  
2. **Infrastructure Deployment**:  
   - Creates an App Service Plan (`S1` SKU).  
   - Creates a Windows Web App with HTTPS-only enabled.  
3. **CI/CD Workflow**:  
   - GitHub Actions builds and deploys the `Src/` folder automatically to Azure.  

---

## 📂 Repository Structure
├── Src/ # Static portfolio website files (HTML, CSS, images, resume)
├── terraform/ # Terraform IaC configuration
│ ├── main.tf
│ ├── terraform.tfstate (remote in Azure)
│ └── ...
├── .github/workflows/ # GitHub Actions workflow for CI/CD
├── README.md # Project documentation

## 📝 Key Highlights
- **Remote State**: Centralized in Azure Storage, following industry best practices.  
- **Secure Access**: Enforced HTTPS-only on the Web App.  
- **CI/CD**: Fully automated deployment pipeline from GitHub → Azure.  
- **Scalable Design**: Infrastructure defined with Terraform can be reused and scaled easily.  

---

## 🙌 Acknowledgements
This project was developed as part of my learning and professional showcase to demonstrate skills in **Terraform**, **Azure Cloud**, and **DevOps automation**.

---
