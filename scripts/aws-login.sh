#!/bin/sh

aws configure export-credentials --profile bedrock --region eu-central-1 > ./temp.json

export AWS_ACCESS_KEY_ID=$(cat ./temp.json | jq -r '.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat ./temp.json | jq -r '.SecretAccessKey')
export AWS_SESSION_TOKEN=$(cat ./temp.json | jq -r '.SessionToken')

rm ./temp.json
