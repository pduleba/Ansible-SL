set TF_LOG_PATH=./out/destroy.log
set TF_LOG=DEBUG
terraform destroy -var-file="./../vars.tfvars" -state="./out/servers.tfstate"