## Jenkins Terraform Ansible CI/CD Pipeline

This repository implements a comprehensive CI/CD pipeline that automates infrastructure provisioning and application deployment on AWS. It utilizes Jenkins for orchestration, Terraform for infrastructure as code (IaC), and Ansible for configuration management.

**Key Features:**

- **Infrastructure as Code (IaC):** Terraform manages infrastructure creation and configuration, promoting consistency and repeatability across environments.
- **Configuration Management:** Ansible provisions and configures EC2 instances, automating the setup process.
- **CI/CD Orchestration:** Jenkins orchestrates the entire pipeline, triggering infrastructure and application deployments upon code changes.
- **Modular Design:** Infrastructure components are grouped into modules, enhancing reusability and maintainability.
- **Multi-Environment Support:** Separate workspaces and tfvars files cater to development (dev) and production (prod) environments.
- **Security Considerations:** The architecture provides a foundation for implementing security best practices like security groups and IAM roles.
- **ALB for Load Balancing:** An Application Load Balancer (ALB) distributes traffic efficiently to your Node.js application.

**Architecture**

The CI/CD pipeline comprises several components:

* **Jenkins Master (Public Subnet):**
    - Runs Jenkins, the orchestration tool.
    - Configured with Ansible roles and playbooks for initial setup.
    - Open ports:
        - 22 (SSH) for secure access
        - 8080 (Jenkins UI) to view and manage pipelines
        - 50000 (Jenkins slave communication) to connect to the slave node
* **Jenkins Slave (Public Subnet):**
    - Executes the infrastructure provisioning pipeline using Terraform.
    - Provisioned with OpenJDK, Docker, and Terraform using Ansible.
    - Open port 22 (SSH) for access to the slave node
* **Infrastructure Pipeline:**
    - Relies on the `https://github.com/minasaeedbasta/jenkins-terraform-ansible-ci-cd.git` repository.
    - Includes a Jenkinsfile defining pipeline execution steps.
    - Contains a `Terraform` folder housing infrastructure definition files:
        - VPC with 6 subnets (3 public + 3 private) for network segmentation
        - 2 EC2 instances:
            - Bastion host (public subnet) for secure access to private resources
            - Application EC2 instance (private subnet) running your Node.js application (port 3000)
        - SSH key pairs for bastion and private EC2 access
        - RDS database for persistent data storage
        - Redis cache database for improved application performance
        - S3 bucket as Terraform state backend with DynamoDB locking for state management and consistency
        - Network resources (security groups, route tables, etc.) grouped in a module for organization
        - Two workspaces (`dev` and `prod`) for development and production environments
        - `dev` and `prod` tfvars files containing environment-specific variables (e.g., database credentials)
        - Application Load Balancer (ALB) to distribute traffic to the EC2 instance running the Node.js application on port 3000
* **Node.js Application Deployment (Separate Pipeline):**
    - A separate Jenkins pipeline, residing in `https://github.com/minasaeedbasta/jenkins_nodejs_example.git`, deploys your Node.js application.
    - This pipeline interacts with the RDS and Redis databases provisioned by the infrastructure pipeline.

**Benefits:**

- **Automation:** Automates infrastructure creation, configuration, and application deployment, streamlining development and deployment workflows.
- **Consistency:** Ensures consistent infrastructure and application configurations across environments.
- **Efficiency:** Reduces manual effort and minimizes human error.
- **Scalability:** The modular design facilitates scaling infrastructure and deployments as your needs evolve.
- **Repeatability:** Infrastructure can be easily recreated or redeployed using Terraform code.
- **Improved Developer Experience:** Developers can focus on code development without worrying about infrastructure setup.

**Prerequisites**

- An AWS account with appropriate permissions for EC2, S3, RDS, Redis, IAM, and VPC
- Ansible installed and configured on the Jenkins master
- SSH key pairs generated for bastion and private EC2 access

**Deployment Instructions**

1. **Clone this repository:**

   ```bash
   git clone https://github.com/minasaeedbasta/jenkins-terraform-ansible-ci-cd.git
   ```

2. **Set Up Jenkins:**

   - Install Jenkins following the official guide for your operating system [https://www.jenkins.io/doc/book/installing/](https://www.jenkins.io/doc/book/installing/).
   - Configure credentials in Jenkins for accessing AWS resources (e.g., IAM role, secret key) and for SSH access to the Jenkins slave node. Refer to the Jenkins documentation for credential management [https://www.jenkins.io/doc/book/using/using-credentials/](https://www.jenkins.io/doc/book/using/using-credentials/).
   - Create two separate Jenkins pipelines within the Jenkins UI:
       - **Infrastructure Pipeline:** This pipeline will execute the Terraform code to provision infrastructure on AWS. Configure it to use the Jenkinsfile located in the root of this repository.
       - **Node.js Application Deployment Pipeline:** This pipeline will deploy your Node.js application. Configure it to use the Jenkinsfile located in `https://github.com/minasaeedbasta/jenkins_nodejs_example.git`.

3. **Configure Terraform Variables (dev and prod):**

   - Edit the `dev.tfvars` and `prod.tfvars` files within the `Terraform` folder.
   - Replace placeholder values with your specific AWS credentials, database connection details, and any other environment-specific configurations.

4. **Run the Infrastructure Pipeline:**

   - Trigger the infrastructure pipeline in Jenkins. This will initiate the Terraform code execution, provisioning the AWS infrastructure defined in the Terraform files. Once successful, you will have a fully functional infrastructure with bastion host, application EC2, RDS database, Redis cache, and ALB.

5. **Deploy Your Node.js Application:**

   - Trigger the Node.js application deployment pipeline in Jenkins. This pipeline will interact with the provisioned infrastructure to deploy your application onto the application EC2 instance.

**Additional Notes**

- **Security Best Practices:**
    - Implement security groups to restrict inbound and outbound traffic for all EC2 instances.
    - Use IAM roles for managed access to AWS resources instead of hardcoding credentials.
- **Further Customization:**
    - Tailor the infrastructure code (Terraform files) and pipelines (Jenkinsfiles) to fit your specific application requirements.
    - Consider integrating additional tools for security scanning, performance testing, or continuous integration.
- **Regular Testing and Updates:**
    - Regularly test and update your CI/CD pipeline to ensure its effectiveness and adapt to changes in your infrastructure or application.

By following these steps, you can leverage this CI/CD pipeline with Jenkins, Terraform, and Ansible to automate your infrastructure provisioning and application deployment on AWS, streamlining your development and deployment processes.