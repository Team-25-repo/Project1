# Project1

Automating Jenkins Deployment with Advanced Terraform Techniques
 
TASKS
FOUNDATIONAL
•	Your team would like to start using Jenkins as their CI/CD tool to create pipelines for DevOps projects. They need you to create the Jenkins server using Terraform so that it can be used in other environments and so that changes to the environment are better tracked.
•	For the Foundational project you are allowed to have all your code in a single main.tf file (known as a monolith) with hardcoded data.
•	Include the link to your repo in your documentation.
•	Deploy 1 EC2 Instances in your Default VPC.
Bootstrap the EC2 instance with a script that will install and start Jenkins.
•	Create and assign a Security Group to the Jenkins EC2 that allows traffic on port 22 from your ip and allows traffic from port 8080.
•	Create a S3 bucket for your Jenkins Artifacts that is not open to the public.
•	Verify that you can reach your Jenkins install via port 8080 in your browser. Be sure to include a screenshot of the Jenkins login screen in your documentation.
•	Push your code to GitHub and include the link in your write up.
ADVANCED
•	Add a variables.tf file and make sure nothing is hardcoded in your main.tf
•	Create separate file for your providers.tf if you have not already.
COMPLEX
•	Create an IAM Role that allows S3 read/write access for the Jenkins Server and assign that role to your Jenkins Server EC2 instance.
•	You can confirm this by sshing into your instance and without using your credentials test some S3 AWS CLI commands.
FOUNDATIONAL
For the Foundational project you are allowed to have all your code in a single main.tf file (known as a monolith) with hardcoded data.
Include the link to your repo in your documentation.
We will first create a main.tf file, and then modify it once we have our EC2 running to build the project from there.
Our assigned task allows us to have all of our code in a single ‘main.tf’ file (known as a monolith) with hardcoded data.
With more complex files, it is common to split the code into multiple files and use modules for better organization and reusability. However we will keep everything in one file for simplicity.
The term monolith describes a single, large file that contains all the code, as opposed to a modular approach where it is separated into smaller more manageable pieces
The “hardcoded data” aspect of our instructions means we can directly include values in our ‘main.tf’ file instead of using variables or other means of parameterization. In more advanced setups, we would use variables or other techniques to make the configuration more dynamic and reusable.
•	While it’s generally good practice to use variables for values that might change, we will stick with the monolith
Install Terraform
First we must install Terraform, if we do not already have it installed. You can follow the directions on the Terraform documentation page depending on your OS.
For this project we will be using AWS Cloud9 with an Amazon Linux OS, which comes pre installed with Terraform.
