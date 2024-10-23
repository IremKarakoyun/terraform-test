clean:
	find / -type d  -name ".terraform" -exec rm -rf {} \;

virginia:
	terraform workspace new virginia || \
	terraform workspace select virginia && \
	terraform init && \
	terraform apply -var-file envs/virginia.tfvars -auto-approve

ohio:
	terraform workspace new virginia || \
	terraform workspace select ohio && \
	terraform init && \
	terraform apply -var-file envs/ohio.tfvars -auto-approve

oregon:
	terraform workspace new virginia || \
	terraform workspace select oregon && \
	terraform init && \
	terraform apply -var-file envs/oregon.tfvars -auto-approve