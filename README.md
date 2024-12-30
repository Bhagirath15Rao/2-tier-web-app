Click on button next for easier running 
-[Project Setup Instructions for Teacher ](#project-setup-instructions-for-teacher)
--
## Project Setup Instructions

### Clone the Project Repository
- First, clone the repository of the project.

### Create an S3 Bucket
- Create an S3 bucket with a name of your choice.
- Important: Make sure to enable the ACL (Access Control List) and uncheck the option to 'Block all public access'.

### Configure SSH Keys
- Navigate to the Terraform project directory:
  ```
  cd two-tier-web-application-automation-reflective-kangaroo/Terraform_Final/main
  ```
- Generate SSH keys for the environment (Note: `<ENV>` can be either `prod` or `staging`):
  ```
  ssh-keygen -t rsa -f bastion-reflective_kangaroo-<ENV>
  ssh-keygen -t rsa -f reflective_kangaroo-<ENV>
  ```

### Install Ansible
- Ensure Ansible is installed in the Ansible folder. If not, install it using the following commands:
  - If you are in the environment directory:
    ```
    cd Ansible
    ```
  - If you are in the directory where the SSH keys were generated:
    ```
    cd ../../Ansible
    ```
  - Install Ansible:
    ```
    sudo yum install ansible -y
    ```

### Initialize and Apply Terraform in the Backend Folder
- Navigate to the Terraform backend folder and run Terraform commands to create a DynamoDB for state locking:
  ```
  cd Terraform_Final/backend
  terraform init
  terraform apply -auto-approve
  ```

### Run Terraform in the Main Project
- Navigate to the main Terraform folder and run the following commands:
  ```
  cd ../main
  terraform init
  terraform validate
  ```
- To apply Terraform in the production environment:
  ```
  terraform apply -auto-approve
  ```
- To apply Terraform in the staging environment, use the following command and provide the bucket name created earlier:
  ```
  terraform apply -var="env=staging"
  ```
- This process may take approximately 3-4 minutes to deploy. Once it is completed, it will output the ALB DNS.

### Run Ansible Playbook
- Return to the Ansible folder and run the playbook. Replace `<bucket_name>` with your bucket name and `<env>` with the environment used ('prod' or 'staging'):
  ```
  cd ../../Ansible
  ansible-playbook -i aws_ec2.yaml Playbook.yaml -e "bucket=<bucket_name> " -e "env=<env>"
  ```
- If you encounter errors during the 'create website' task or if it uploads to one instance but not the others, rerun the playbook.

### Accessing the Website
- Open the AWS ALB DNS link in a web browser (use HTTP instead of HTTPS). The site should now be running.

### Cleaning up the deployed infrastructure
- Return to the main folder in the Terraform_Final and destroy all the terraform resources.
  ```
  cd ../Terraform_Final/main
  terraform destroy -auto-approve
  ```
- Navigate to the backend folder of the Terraform_Final and destroy the dynamo db resource, so that all the resources created and deployed for the project would be deleted.
  ```
  cd ../backend
  terraform destroy -auto-approve
  ```

--
## Project Setup Instructions for Teacher 

1. **Clone the Project Repository**
   - Begin by cloning the project repository.

2. **Create an S3 Bucket**
   - Before proceeding, create an S3 bucket. Remember to enable ACL and uncheck 'Block all public access'.

3. **Configure SSH Keys**
   - Navigate to the Terraform project directory and generate SSH keys for the `prod` environment:
     ```bash
     cd two-tier-web-application-automation-reflective-kangaroo/Terraform_Final/main
     ssh-keygen -t rsa -f bastion-reflective_kangaroo-prod
     ssh-keygen -t rsa -f reflective_kangaroo-prod
     ```

4. **Install Ansible**
   - Install Ansible by navigating to the Ansible directory and executing the following commands:
     ```bash
     cd ../../Ansible
     sudo yum install ansible -y
     pip2 install boto3 botocore
     ```

5. **Initialize and Apply Terraform in Backend**
   - Initialize and apply Terraform in the backend by moving to the backend directory:
     ```bash
     cd ../Terraform_Final/backend
     terraform init
     terraform apply -auto-approve
     ```

6. **Run Terraform in Main Project**
   - Navigate to the main Terraform folder and execute Terraform commands:
     ```bash
     cd ../main
     terraform init
     ```
   - It will ask for bucket name while running terraform init, which bucket you create, please put the name and then run:
     ```bash
     terraform apply -auto-approve
     ```
   - Either copy and paste link the brower, or copy it soemwhere to be used later. 

7. **Run Ansible Playbook**
   - Return to the Ansible folder and run the playbook, replacing `<bucket_name>` with your created bucket name:
     ```bash
     cd ../../Ansible
     ansible-playbook -i aws_ec2.yaml Playbook.yaml -e "env=prod" -e "bucket=<bucket_name> "
     ```
   -Please rememeber if the playbook run on instance, or having another please try to run the playbook again without edit any code. (Just use upper allow key, and enter pr above code again)

8. **Accessing the Website**
   - Use the ALB DNS link (copied earlier) in a web browser (HTTP protocol). If you already did, just reload that page.

9. **Cleanup**
   - To clean up, navigate to the main and backend folders of Terraform_Final and destroy the resources:
     ```bash
     cd ../Terraform_Final/main
     terraform destroy -auto-approve
     ```

   - Wait for it to say
     ```bash 
     cd ../backend
     terraform destroy -auto-approve
     ```