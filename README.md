# AWS SSM + ansible + session manager POC

Simple proof of concept that I can stand up a ec2, deploy ansible to it via systems manager (no ssh!), curl the web page, and then destroy it all again.

The ansible playbook installs apache and sets the `index.html` to just be `helloworld!` then we curl it to prove that its all worked correctly.

Shell output looks something like this:

```
 ./runit.sh                                                          
Initializing modules...
- module.session-manager-settings

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.57"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
data.aws_iam_policy.ssmdemo: Refreshing state...
aws_iam_role.ssmdemo: Creating...
  arn:                   "" => "<computed>"
  assume_role_policy:    "" => "{\n    \"Version\": \"2012-10-17\",\n    \"Statement\": [\n        {\n            \"Action\": \"sts:AssumeRole\",\n            \"Principal\": {\n               \"Service\": \"ec2.amazonaws.com\"\n            },\n            \"Effect\": \"Allow\",\n            \"Sid\": \"\"\n        }\n    ]\n}\n"
  create_date:           "" => "<computed>"
  force_detach_policies: "" => "false"
  max_session_duration:  "" => "3600"
  name:                  "" => "<computed>"
  path:                  "" => "/"
  unique_id:             "" => "<computed>"
aws_cloudwatch_log_group.ssmdemo: Creating...
  arn:               "" => "<computed>"
  name:              "" => "ssmdemo"
  retention_in_days: "" => "0"
module.session-manager-settings.aws_ssm_document.session_manager_prefs: Creating...
  arn:              "" => "<computed>"
  content:          "" => "{\n    \"schemaVersion\": \"1.0\",\n    \"description\": \"Document to hold regional settings for Session Manager\",\n    \"sessionType\": \"Standard_Stream\",\n    \"inputs\": {\n        \"s3BucketName\": \"ssmdemo\",\n        \"s3KeyPrefix\": \"\",\n        \"s3EncryptionEnabled\": false,\n        \"cloudWatchLogGroupName\": \"ssmdemo\",\n        \"cloudWatchEncryptionEnabled\": false\n    }\n}\n"
  created_date:     "" => "<computed>"
  default_version:  "" => "<computed>"
  description:      "" => "<computed>"
  document_format:  "" => "JSON"
  document_type:    "" => "Session"
  hash:             "" => "<computed>"
  hash_type:        "" => "<computed>"
  latest_version:   "" => "<computed>"
  name:             "" => "SSM-SessionManagerRunShell"
  owner:            "" => "<computed>"
  parameter.#:      "" => "<computed>"
  platform_types.#: "" => "<computed>"
  schema_version:   "" => "<computed>"
  status:           "" => "<computed>"
aws_security_group.allow_http: Creating...
  arn:                                   "" => "<computed>"
  description:                           "" => "Allow all inbound http traffic"
  egress.#:                              "" => "1"
  egress.482069346.cidr_blocks.#:        "" => "1"
  egress.482069346.cidr_blocks.0:        "" => "0.0.0.0/0"
  egress.482069346.description:          "" => ""
  egress.482069346.from_port:            "" => "0"
  egress.482069346.ipv6_cidr_blocks.#:   "" => "0"
  egress.482069346.prefix_list_ids.#:    "" => "0"
  egress.482069346.protocol:             "" => "-1"
  egress.482069346.security_groups.#:    "" => "0"
  egress.482069346.self:                 "" => "false"
  egress.482069346.to_port:              "" => "0"
  ingress.#:                             "" => "1"
  ingress.2214680975.cidr_blocks.#:      "" => "1"
  ingress.2214680975.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.2214680975.description:        "" => ""
  ingress.2214680975.from_port:          "" => "80"
  ingress.2214680975.ipv6_cidr_blocks.#: "" => "0"
  ingress.2214680975.prefix_list_ids.#:  "" => "0"
  ingress.2214680975.protocol:           "" => "tcp"
  ingress.2214680975.security_groups.#:  "" => "0"
  ingress.2214680975.self:               "" => "false"
  ingress.2214680975.to_port:            "" => "80"
  name:                                  "" => "allow_http"
  owner_id:                              "" => "<computed>"
  revoke_rules_on_delete:                "" => "false"
  vpc_id:                                "" => "<computed>"
aws_cloudwatch_log_group.ssmdemo: Creation complete after 0s (ID: ssmdemo)
module.session-manager-settings.aws_ssm_document.session_manager_prefs: Creation complete after 0s (ID: SSM-SessionManagerRunShell)
aws_iam_role.ssmdemo: Creation complete after 1s (ID: terraform-20190201021112786000000001)
aws_iam_role_policy_attachment.ssmdemo: Creating...
  policy_arn: "" => "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role:       "" => "terraform-20190201021112786000000001"
aws_iam_instance_profile.ssmdemo: Creating...
  arn:         "" => "<computed>"
  create_date: "" => "<computed>"
  name:        "" => "<computed>"
  path:        "" => "/"
  role:        "" => "terraform-20190201021112786000000001"
  roles.#:     "" => "<computed>"
  unique_id:   "" => "<computed>"
aws_security_group.allow_http: Creation complete after 2s (ID: sg-06ddf7475a6a2b182)
aws_iam_instance_profile.ssmdemo: Creation complete after 2s (ID: terraform-20190201021114098600000002)
aws_instance.linux: Creating...
  ami:                          "" => "ami-0664a710233d7c148"
  arn:                          "" => "<computed>"
  associate_public_ip_address:  "" => "<computed>"
  availability_zone:            "" => "<computed>"
  cpu_core_count:               "" => "<computed>"
  cpu_threads_per_core:         "" => "<computed>"
  ebs_block_device.#:           "" => "<computed>"
  ephemeral_block_device.#:     "" => "<computed>"
  get_password_data:            "" => "false"
  host_id:                      "" => "<computed>"
  iam_instance_profile:         "" => "terraform-20190201021114098600000002"
  instance_state:               "" => "<computed>"
  instance_type:                "" => "t2.micro"
  ipv6_address_count:           "" => "<computed>"
  ipv6_addresses.#:             "" => "<computed>"
  key_name:                     "" => "<computed>"
  network_interface.#:          "" => "<computed>"
  network_interface_id:         "" => "<computed>"
  password_data:                "" => "<computed>"
  placement_group:              "" => "<computed>"
  primary_network_interface_id: "" => "<computed>"
  private_dns:                  "" => "<computed>"
  private_ip:                   "" => "<computed>"
  public_dns:                   "" => "<computed>"
  public_ip:                    "" => "<computed>"
  root_block_device.#:          "" => "<computed>"
  security_groups.#:            "" => "1"
  security_groups.2266647485:   "" => "allow_http"
  source_dest_check:            "" => "true"
  subnet_id:                    "" => "<computed>"
  tags.%:                       "" => "1"
  tags.Name:                    "" => "ssmdemo"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_iam_role_policy_attachment.ssmdemo: Creation complete after 2s (ID: terraform-20190201021112786000000001-20190201021114708200000003)
aws_instance.linux: Still creating... (10s elapsed)
aws_instance.linux: Still creating... (20s elapsed)
aws_instance.linux: Still creating... (30s elapsed)
aws_instance.linux: Creation complete after 32s (ID: i-03e3f34956dcff09f)

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
.........    "Status": "Success", 
    "StatusDetails": "Success", 
upload: ./playbook.yml to s3://ssmdemo/playbook.yml                 
...........    "Status": "Success", 
    "StatusDetails": "Success", 
helloworld!
* Rebuilt URL to: 18.130.245.195/
*   Trying 18.130.245.195...
* TCP_NODELAY set
* Connected to 18.130.245.195 (18.130.245.195) port 80 (#0)
> GET / HTTP/1.1
> Host: 18.130.245.195
> User-Agent: curl/7.54.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Fri, 01 Feb 2019 02:12:31 GMT
< Server: Apache/2.4.37 ()
< Upgrade: h2,h2c
< Connection: Upgrade
< Last-Modified: Fri, 01 Feb 2019 02:12:29 GMT
< ETag: "c-580cbacc94a9d"
< Accept-Ranges: bytes
< Content-Length: 12
< Content-Type: text/html; charset=UTF-8
< 
helloworld!
* Connection #0 to host 18.130.245.195 left intact


Starting session with SessionId: ssm-demo-0b6d3776182ff6346

sh-4.2$ echo hi hi hi
hi hi hi
sh-4.2$ exit


Exiting session with sessionId: ssm-demo-0b6d3776182ff6346.

aws_iam_role.ssmdemo: Refreshing state... (ID: terraform-20190201021112786000000001)
aws_security_group.allow_http: Refreshing state... (ID: sg-06ddf7475a6a2b182)
aws_cloudwatch_log_group.ssmdemo: Refreshing state... (ID: ssmdemo)
aws_ssm_document.session_manager_prefs: Refreshing state... (ID: SSM-SessionManagerRunShell)
data.aws_iam_policy.ssmdemo: Refreshing state...
aws_iam_instance_profile.ssmdemo: Refreshing state... (ID: terraform-20190201021114098600000002)
aws_iam_role_policy_attachment.ssmdemo: Refreshing state... (ID: terraform-20190201021112786000000001-20190201021114708200000003)
aws_instance.linux: Refreshing state... (ID: i-03e3f34956dcff09f)
aws_cloudwatch_log_group.ssmdemo: Destroying... (ID: ssmdemo)
aws_instance.linux: Destroying... (ID: i-03e3f34956dcff09f)
aws_security_group.allow_http: Destroying... (ID: sg-06ddf7475a6a2b182)
module.session-manager-settings.aws_ssm_document.session_manager_prefs: Destroying... (ID: SSM-SessionManagerRunShell)
aws_iam_role_policy_attachment.ssmdemo: Destroying... (ID: terraform-20190201021112786000000001-20190201021114708200000003)
aws_cloudwatch_log_group.ssmdemo: Destruction complete after 1s
module.session-manager-settings.aws_ssm_document.session_manager_prefs: Destruction complete after 1s
aws_iam_role_policy_attachment.ssmdemo: Destruction complete after 1s
aws_security_group.allow_http: Still destroying... (ID: sg-06ddf7475a6a2b182, 10s elapsed)
aws_instance.linux: Still destroying... (ID: i-03e3f34956dcff09f, 10s elapsed)
aws_security_group.allow_http: Still destroying... (ID: sg-06ddf7475a6a2b182, 20s elapsed)
aws_instance.linux: Still destroying... (ID: i-03e3f34956dcff09f, 20s elapsed)
aws_security_group.allow_http: Still destroying... (ID: sg-06ddf7475a6a2b182, 30s elapsed)
aws_instance.linux: Still destroying... (ID: i-03e3f34956dcff09f, 30s elapsed)
aws_security_group.allow_http: Still destroying... (ID: sg-06ddf7475a6a2b182, 40s elapsed)
aws_instance.linux: Still destroying... (ID: i-03e3f34956dcff09f, 40s elapsed)
aws_security_group.allow_http: Still destroying... (ID: sg-06ddf7475a6a2b182, 50s elapsed)
aws_instance.linux: Still destroying... (ID: i-03e3f34956dcff09f, 50s elapsed)
aws_instance.linux: Still destroying... (ID: i-03e3f34956dcff09f, 1m0s elapsed)
aws_security_group.allow_http: Still destroying... (ID: sg-06ddf7475a6a2b182, 1m0s elapsed)
aws_security_group.allow_http: Destruction complete after 1m1s
aws_instance.linux: Destruction complete after 1m1s
aws_iam_instance_profile.ssmdemo: Destroying... (ID: terraform-20190201021114098600000002)
aws_iam_instance_profile.ssmdemo: Destruction complete after 1s
aws_iam_role.ssmdemo: Destroying... (ID: terraform-20190201021112786000000001)
aws_iam_role.ssmdemo: Destruction complete after 1s

Destroy complete! Resources: 7 destroyed.

```