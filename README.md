# terraform-aws-provider

> In this repo you can find terraform practices with the provider AWS.

> The practice are only based in aws provider

> you can help me to study all things, in the new version of terraform.


## Table of Contents 

> We've already built several demos.

- [demo-packer](#demo-packer)
- [demo-docker](#demo-docker)
- [demo-terraform](#demo-terraform)
- [demo-terraform-backends](#demo-terraform-backends)
- [demo-terraform-modules](#demo-terraform-modules)
- [demo-terraform-vpc](#demo-terraform-vpc)
- [License](#license)

## demo-packer

- We create a basic AMI in aws based in ubuntu server 18 lts.
- Also we are provisioning that server image with a docker installation.

## demo-docker

- Is a basic nginx app, within an html basic app.
- You can find the image deployed <a href="https://hub.docker.com/repository/docker/cperez354/hello-terraform" target="_blank">HERE</a>
- The ideo is run this image inside the preview AMI.


## demo-terraform

- We create a security group.
- We create a simple ec2 instance.

## demo-terraform-backends

- We create a s3 bucked to save an encrypted state file.
- Also we create a remote backend on s3.

## demo-terraform-modules

- We separate the ec2 and security group from the rest of the infraestructure, using modules.

## demo-terraform-vpc

- We create a vpc from scratch.
- We create internet gateways.
- we create a public route table.
- we create a private route table.
- We create public subnets.
- We create private subnets.
- We associate the public subnets to the public route table.
- We associate the private subnets to the private route table.
- In the end we created a security group.


## License
- MIT(Help me to improve this.)