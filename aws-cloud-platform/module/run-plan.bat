set TF_LOG_PATH=./out/plan.log
set TF_LOG=DEBUG
terraform plan -var-file="./../vars.tfvars" -state="./out/servers.tfstate"