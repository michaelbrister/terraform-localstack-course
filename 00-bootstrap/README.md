## Run localstack container

`docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack`

## Set AWS CLI Credentials

```
aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test
aws configure set region us-east-1
```
