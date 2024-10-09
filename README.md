Wordpress Installation on AWS using Terraform
Pre-requisite:
1.	AWS Account
2.	Terraform Installed
3.	AWS CLI Installed
4.	Key Pair for launching EC2 Instance
5.	AWS Access Key (configure the access key & secret key using aws configure command)
Work Directory Structure:
 
Steps:
1.	Define Variables in vars.tf (e.g. aws region,db name, etc)
2.	Create VPC in vpc.tf
3.	Create Subnets in subnet.tf (it will consist of public & private subnets)
4.	Create Internet Gateway in internet-gateway.tf (for allowing traffic from internet to public subnet)
5.	Create Route Tables & Associations in routing-table.tf
6.	Cerate Security Group in security_group.tf (for allowing all traffic from internet, allowing http protocol and allowing ssh protocol)
7.	Create EC2 Instance in main.tf (create this instance using public subnet so it can be accessed by public)
8.	Create script to run wordpress also in main.tf (for the ssh connection it will be using the key-pair that has been generated earlier)
9.	Configure Security Group for RDS in main.tf (for controlling inbound and outbound traffic to the RDS instance)
10.	Create subnet group for RDS in main.tf (Specify the subnets in subnet_ids,in this case we are using private subnet for RDS)
11.	Create RDS Instance in main.tf (don’t forget to add the value of db_subnet_group_name from the step 10 & vpc_security_group_ids from the step 9)
12.	Create script to change the wp.config value for the database in main.tf (it will change the config value of database name, username, password, and host)

Execute Terraform:
1.	Make sure the directory is right
2.	terraform init
3.	terraform apply -auto-approve
