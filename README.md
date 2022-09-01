# Application code
Python source code directory: ./src

# Infrasturcture
Terraform source directory: ./infrastructure

This project is configured to work with LocalAWS, Terraform and LocalTF.
These tools simulate working with AWS locally by wrapping aroung the regular `aws` and `terraform` commands.

In this environment instead of running a command with `aws` you should use `awslocal`  

**Example**  
```aws --profile [profile] --region [region] apigateway get-rest-apis```  
becomes  
```awslocal apigateway get-rest-apis```

Instead of runnign a command with `terraform` you should use `tflocal`  

**Example**  
```terraform init```  
becomes  
```tflocal init```

# Run the code
Run in terminal the commnd:
```./start.sh```
Then you can use the url from the output.

## Get main page
To enter the main page:
```http://<API endpoint URL>/hello```

## Get file from s3
If you whant to get the file.text contant that in s3 bucket and locait at infrastructure:
```curl -X GET http://<API endpoint URL>/get-my-file```
If you whant change the contant of the file just remaber at the end to run:
```cd ./infrastructure```
```tflocal apply```

## Greet
If you whant to greet just run:
```curl -X POST -d 'name=costom_name' http://<API endpoint URL>/greet```