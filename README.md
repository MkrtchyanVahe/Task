--------------------------------------------------------------------------------------
1.1. Set up an AWS account and configure the AWS CLI with the necessary access keys.
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
Setting up an AWS Account and Configuring AWS CLI

This guide will walk you through the process of setting up an AWS (Amazon Web Services) 
account and configuring the AWS CLI (Command Line Interface) with the necessary access keys.

1. Create an IAM User
    Once you have created your AWS account, log in to the AWS Management Console
    Click on the "Services" menu and select "IAM" (Identity and Access Management)
    Click on "Users" in the left-hand menu and then click on the "Add User" button
    Enter a name for the user and select the "Programmatic access" checkbox
    Click on "Next: Permissions"
    Select "Attach existing policies directly"
    Search for and select the "AdministratorAccess" policy
    Click on "Next: Tags" (you can skip this step if you don't want to add any tags)
    Click on "Next: Review"
    Review the information and click on "Create User"
    Make note of the Access Key ID and Secret Access Key that are displayed on the next screen

2. Export AWS Access Keys
   Open a terminal or command prompt and export your AWS access keys as environment
   variables using the export command. Replace ACCESS_KEY_ID and SECRET_ACCESS_KEY 
   with the actual access keys you obtained in step 1.

     export AWS_ACCESS_KEY_ID=ACCESS_KEY_ID
     export AWS_SECRET_ACCESS_KEY=SECRET_ACCESS_KEY


Conclusion
In this guide, you learned how to configure AWS CLI using environment variables with the export command.
With these steps completed, you can now use the AWS CLI to interact with your AWS resources from the command line.


--------------------------------------------------------------------------------------------------------------
1.2. Create a VPC with a private and public subnet.
1.3. Launch an EC2 instance in the public subnet with an SSH key pair for access.
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
The above Terraform code creates a VPC with a public and a private subnet in the us-east-1 region of AWS.
The public subnet is associated with a routing table that directs traffic to an internet gateway, while 
the private subnet does not have direct internet access.

Here is a brief explanation of the resources used in the code:

-  aws_vpc: This resource creates a VPC with the specified CIDR block.

-  aws_internet_gateway: This resource creates an internet gateway and attaches it to the VPC.

-  aws_subnet: This resource creates a public and a private subnet in the VPC with the specified CIDR blocks. 
       The map_public_ip_on_launch attribute is set to true for the public subnet, which allows instances launched 
       in the subnet to have public IP addresses.

-  aws_route_table: This resource creates a routing table for the VPC.

-  aws_route: This resource creates a route in the routing table that directs traffic with a destination CIDR block 
       of 0.0.0.0/0 to the internet gateway.

-  aws_route_table_association: This resource associates the public subnet with the routing table.

-  aws_security_group: This resource creates a security group that allows inbound traffic on port 22 (SSH).

-  aws_key_pair: This resource creates an SSH key pair that can be used to access the EC2 instance.

-  aws_instance: This resource launches an EC2 instance in the public subnet with the specified AMI and instance type. 
       The instance is associated with the security group and key pair created earlier.


------------------------------------------------------------------------------------------------------------------------
1.4. Set up a security group allowing inbound traffic on ports 80 (HTTP), 443 (HTTPS), and 22 (SSH) from your IP address.
1.5. Create an Elastic Load Balancer (ELB) with a listener for port 80.
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
The above Terraform code creates an AWS security group that allows inbound traffic on ports 80 (HTTP), 443 (HTTPS), 
and 22 (SSH) from a specified CIDR block, which in this case is the CIDR block of the public subnet. The name_prefix 
parameter is used to assign a unique name to the security group.

Here is a brief explanation of the resources used in the code:

-  aws_security_group: This resource creates a security group with the specified ingress rules allowing inbound 
       traffic on ports 80, 443, and 22. The cidr_blocks parameter specifies the CIDR block for which the ingress 
       rule applies.

-  aws_elb: This resource creates an Elastic Load Balancer with a listener for port 80. The name parameter specifies 
       the name of the ELB, and the availability_zones parameter specifies the availability zones in which the ELB 
       is created. The listener block specifies the listener configuration for the ELB. The security_groups parameter 
       specifies the security group that the ELB uses.


----------------------------------------------------------------------------------------------------------------------
2.1. Create a new DynamoDB table with a primary key (partition key and sort key) and a global secondary index (GSI).
2.2. Write a script in Python or Bash to insert sample data into the table.
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
  The billing_mode of the table is set to PAY_PER_REQUEST, which means that you only pay for the read and write requests 
  that you make to the table.

  In addition to creating the DynamoDB table, this infrastructure also runs a Python script called data.py using the 
  local-exec provisioner. The null_resource block ensures that the script is executed only after the DynamoDB table is 
  created, as specified in the depends_on list.


----------------------------------------------------------------------------------------------------------------------
2.3. Write a script to query the table and return results based on the GSI.
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
  Run the script using the command //   python3 query.py   // in the terminal.
  The script will print out all items in the table that match the query.


--------------------------------------------------------------------------------------------------------------------
3.1. Configure AWS CloudWatch to monitor the EC2 instance and the DynamoDB table.
3.4. Create CloudWatch alarms for high CPU utilization on the EC2 instance and high read/write capacity on the DynamoDB table.
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
  This Terraform configuration creates three CloudWatch alarms to monitor the performance of an EC2 instance and 
  a DynamoDB table. The alarms will send a notification to an SNS topic when certain thresholds are reached.

-  aws_cloudwatch_metric_alarm.ec2_cpu_utilization
       This resource creates a CloudWatch alarm that monitors the CPU utilization of an EC2 instance. 
       The alarm will trigger if the average CPU utilization over a 2-minute period exceeds 80%.

-  aws_cloudwatch_metric_alarm.dynamodb_high_reads
       This resource creates a CloudWatch alarm that monitors the read capacity of a DynamoDB table.  
       The alarm will trigger if the sum of consumed read capacity units over a 2-minute period exceeds 1000 units.

-  aws_cloudwatch_metric_alarm.dynamodb_high_writes
       This resource creates a CloudWatch alarm that monitors the write capacity of a DynamoDB table. The alarm will 
       trigger if the sum of consumed write capacity units over a 2-minute period exceeds 1000 units.


--------------------------------------------------------------------------------------------------------------------
3.2. Create an S3 bucket for storing logs.
3.3. Configure logging for the ELB, EC2 instance, and the DynamoDB table to store logs in the S3 bucket.
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
  To store logs for the ELB, EC2 instance, and DynamoDB table, you need to create an S3 bucket. You can create an S3 
  bucket using the aws_s3_bucket resource in your Terraform code.

  Once the S3 bucket is created, you can configure logging for the ELB, EC2 instance, and DynamoDB table to store 
  logs in the S3 bucket.


--------------------------------------------------------------------------------------------------------------------
4.1. Set up an Amazon EKS cluster and connect it to the VPC.
--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------- 
  This is a Terraform configuration file for creating an Amazon EKS (Elastic Kubernetes Service) node group with an 
  IAM (Identity and Access Management) role.

  The configuration file uses the following AWS resources:

-  aws_iam_role: This resource creates an IAM role with the name eks-node-group-nodes. The role has an assume role  
       policy that allows EC2 instances to assume the role.

-  aws_iam_role_policy_attachment: This resource attaches IAM policies to the IAM role created by the aws_iam_role 
       resource. Three policies are attached to the role: AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, and 
       AmazonEC2ContainerRegistryReadOnly. The first two policies are required for EKS worker nodes to function 
       properly, while the third policy allows the worker nodes to pull container images from Amazon ECR 
       (Elastic Container Registry).

-  aws_iam_role_policy_attachment (Optional): This resource attaches the AmazonSSMManagedInstanceCore policy to 
       the IAM role created by the aws_iam_role resource. This policy is only required if you want to SSH into the 
       EKS nodes.

-  aws_eks_node_group: This resource creates an EKS node group with the name private-nodes. The node group uses 
       the IAM role created by the aws_iam_role resource and is launched in the VPC subnet specified by the 
       subnet_ids argument. The node group uses t2.micro instances and has a desired size of 2. The depends_on 
       argument ensures that the IAM policies are attached to the role before the node group is created.

---------------------------------------------------------------------------------------------------------------
4.3. Deploy a sample application (e.g., node) to the cluster using a Kubernetes Deployment and Service.
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
  This is a YAML configuration file for Kubernetes that defines two services and a deployment for an Nginx container.

  The first section defines a deployment named "nginx" with one replica. It also specifies that the container will 
  use the Nginx 1.14.2 image and expose port 80.

  The second section defines a service named "internal-nginx-service" that targets the Nginx deployment and exposes 
  it internally with an AWS Network Load Balancer. It also enables cross-zone load balancing and allows all IP 
  addresses to access it.

  The third section defines a service named "external-nginx-service" that targets the same Nginx deployment and exposes  
  it externally with an AWS Network Load Balancer. It also enables cross-zone load balancing, but only allows traffic  
  from within the VPC.






























