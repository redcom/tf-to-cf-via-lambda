# tf-to-cf-via-lambda


## Before all
I would not recommand exposing the terraform state directly due to security reasons and due to the
fact that there are cases where the state of the infrastructure is behind of what is actually running.
Eg: autoscaling groups, spot instances etc. I would recommand creating lambda functions where the AWS service needed can be query using aws-api clients directly.


## Intro
I used terragrunt to spin up a small infrastructure using a VPC, ALB and a Lambda
I used modules where possible to reduce development time


- tf-modules folder contain reusable modules
- dmc-solution folder contain terraform configuration code for solving the problem and deploy the modules created in the above folder

## Lambda
The lambda has access only to the bucket it needs and least privilage principle is used give read only access to the infrastructure
The lambda has been written in nodejs and deployed using terraform with custom role.
The lambda is exposed using function url, but for production I would recomand exposing it using an API gateway to have more control on security
The lamnda should not output sensitive data and can be locked down even more for protecting sensitive data

## Testing using curl

Lambda is protected using: AWS_IAM authentication

Example test using POST method and "filters" parameter to return only specified values
```
curl --location --request POST 'https://hasqswc4w32fnx463646zf6pxa0vtxhg.lambda-url.eu-central-1.on.aws/' \
--header 'Content-Type: application/json' \
--header 'X-Amz-Content-Sha256: beaead3198f7da1e70d03ab969765e0821b24fc913697e929e726aeaebf0eba3' \
--header 'X-Amz-Security-Token: FwoGZXIvYXdzEF8aDDERaaynpvsJIm1ZkCKxAQ/xwMUSui898SwIik6GGJrAhMYfAP77TopKCreBOW8l0e6L/sBN3zoXZxACTi+UDwAMQTcCjkDx6hhFETTHeXkibSNmOqNejlDKLCCGmnnZ+r8tEafpHPeR+nNtqpawBeXc62M0FWnrXoD+fpBJMRnbRKvSDZl3jCz/PUjZm50LTtTM9fLXBYw5hhDgF2j0yNLIo0fVkSdU4bMiaQs+djxNPnnB9//o2xi7/8sQTZzCDSicr+eXBjItyhRYjgta5ZVlFgcT8p2qXYRDc1UQj0w5sel+10d4gTNVuV4KxPzq6iF1HtDM' \
--header 'X-Amz-Date: 20220815T054645Z' \
--header 'Authorization: AWS4-HMAC-SHA256 Credential=ASIA42UBYLPFA23SCYUD/20220815/eu-central-1/lambda/aws4_request, SignedHeaders=host;x-amz-content-sha256;x-amz-date;x-amz-security-token, Signature=42fc66cebd61439a3a0470a98b8a605aa71d3f0d491b55283aae4b7048a49b76' \
--data-raw '{
    "filters": [
        "alb.lb_arn", "alb.lb_dns_name"
    ]
}'
```

Example test using GET method which will return all the outputs combined based on resources created by terraform
```
curl --location --request GET 'https://hasqswc4w32fnx463646zf6pxa0vtxhg.lambda-url.eu-central-1.on.aws/' \
--header 'Content-Type: application/json' \
--header 'X-Amz-Security-Token: FwoGZXIvYXdzEF8aDDERaaynpvsJIm1ZkCKxAQ/xwMUSui898SwIik6GGJrAhMYfAP77TopKCreBOW8l0e6L/sBN3zoXZxACTi+UDwAMQTcCjkDx6hhFETTHeXkibSNmOqNejlDKLCCGmnnZ+r8tEafpHPeR+nNtqpawBeXc62M0FWnrXoD+fpBJMRnbRKvSDZl3jCz/PUjZm50LTtTM9fLXBYw5hhDgF2j0yNLIo0fVkSdU4bMiaQs+djxNPnnB9//o2xi7/8sQTZzCDSicr+eXBjItyhRYjgta5ZVlFgcT8p2qXYRDc1UQj0w5sel+10d4gTNVuV4KxPzq6iF1HtDM' \
--header 'X-Amz-Date: 20220815T055131Z' \
--header 'Authorization: AWS4-HMAC-SHA256 Credential=ASIA42UBYLPFA23SCYUD/20220815/eu-central-1/lambda/aws4_request, SignedHeaders=host;x-amz-date;x-amz-security-token, Signature=17857c41282debbc15c03ba40a40ec326f68987bb6fcbbb71272a542b263f67a'
```
