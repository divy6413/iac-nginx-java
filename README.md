# iac-nginx-java

Network Architecture:

<img width="605" alt="image" src="https://user-images.githubusercontent.com/35598660/211060996-569599bb-5553-452e-9953-c7a70ae3e9b0.png">


Terraform architecture:

<img width="391" alt="image" src="https://user-images.githubusercontent.com/35598660/211061055-78c87ef0-ec38-4c8e-8a89-c8ee203d5d85.png">


Ansible Architecture:

<img width="606" alt="image" src="https://user-images.githubusercontent.com/35598660/211061096-ea1110b8-3877-4b55-8322-453f913973da.png">


**Points to Consider:**
-> When adding new microservice, tfvars file can be update accordingly(manual not required- can be done via code with inputs from Jenkins parameters) and terraform can be applied. 
-> From ansible more tools can be installed later(currently apart from app tools, monitoring and logging are installed).

**Future Scope:**
->Terraform main.tf can be even more partitioned into different files. Ex- SG, ASG, EC2 etc
->ALB,NLB and Cache can also be done using terraform.
->Terraform state can be maintained on AWS S3 as backend and for maintaining lock- DynamoDB table can be used.
->For CI/CD- a jenkins job can be used which can use same ansible and packer code for building new AMI-new instance template and update using cloud APIs.
