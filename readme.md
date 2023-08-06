
Create a new certificate and get the certificate arn and add it in the 
variable file.

```
1  Create vpc.
2. Create 3 private/public subnet counsume az's
3. Create IGW
4. Create Route table and association
5. Create NAT Gateway for private subnets
6. Create Security Group
7. Create ec2 instance
8. Create load balancer
9. Create S3 route and record.
10. Create a ansible.cfg to disable host checking.
11. Create a null resource to execute ansible
12. Create deploy-app.yml ansible to deploy app
```

## Hint to create vpc in AWS
```
1. select the region
2. create vpc
3. enable DNS hostname in the VPC
4. crate Internet Gateway
5. Attach Internet Gateway to VPC
6. Create Public Subnets.
7. Enable auto assign public Ip Settings
8. create public route table
9. add public route to the pubic route table
10. associate the public subnets with the public route table
11. create the private subnets
12. create nat gateway
13. create an EIP and associate it to the nat gateways
14. create private route table
15. Add pubic route to the private route table
16. Associate the Private Subnets with the Private Route table.

```

terraform plan -out ouput.tfplan

terraform show -no-color -json output.tfplan > output.json

terraform apply/destroy  -auto-approve