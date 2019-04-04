set TF_LOG_PATH=./out/apply.log
set TF_LOG=DEBUG
terraform apply -var-file="./../vars.tfvars" -state="./out/servers.tfstate"