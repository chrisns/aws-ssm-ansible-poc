#!/bin/bash
set -e

# get the systems manager cli plugin
# https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

terraform init
terraform apply -auto-approve . 

INSTANCE_ID=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=ssmdemo,Name=instance-state-name,Values=running' --output text --query 'Reservations[*].Instances[*].InstanceId')
INSTANCE_IP=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=ssmdemo,Name=instance-state-name,Values=running' --output text --query 'Reservations[].Instances[].[PublicIpAddress][0]')

sleep 10 # give it time to init the box -- could be sswapped for a checker

# # install ansible on machine
COMMAND_ID=$(aws ssm send-command --instance-ids $INSTANCE_ID --document-name "AWS-RunShellScript" --parameters "commands=sudo amazon-linux-extras install -y ansible2" --output text --query "Command.CommandId")

# wait for command to finish
until aws ssm get-command-invocation --command-id ${COMMAND_ID} --instance-id ${INSTANCE_ID} | grep Success; do
    echo -n . && sleep 0.1
done

# # copy a playbook
aws s3 cp playbook.yml s3://ssmdemo/playbook.yml

# # run a playbook
COMMAND_ID=$(aws ssm send-command --document-name "AWS-RunAnsiblePlaybook" --targets "Key=instanceids,Values=$INSTANCE_ID" --parameters '{"playbookurl":["s3://ssmdemo/playbook.yml"],"extravars":["SSM=True"],"check":["False"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output text --query "Command.CommandId")

until aws ssm get-command-invocation --command-id ${COMMAND_ID} --instance-id ${INSTANCE_ID} | grep Success; do
    echo -n . && sleep 0.1
done

until curl $INSTANCE_IP ; do
    echo -n . && sleep 0.1
done
curl -v $INSTANCE_IP

open https://eu-west-2.console.aws.amazon.com/cloudwatch/home?region=eu-west-2#logEventViewer:group=ssmdemo
open https://s3.console.aws.amazon.com/s3/buckets/ssmdemo/
aws ssm start-session --target $INSTANCE_ID


terraform destroy --force

