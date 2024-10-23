clean:
	find / -type d  -name ".terraform" -exec rm -rf {} \;

virginia:
	terraform workspace select virginia && \
	terraform init && \
	terraform apply -var-file envs/virginia.tfvars -auto-approve