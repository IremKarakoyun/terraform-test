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

destroy-virginia:
	terraform workspace new virginia || \
	terraform workspace  select   virginia && \
	terraform   init   && \
	terraform  destroy  -var-file   envs/virginia.tfvars  -auto-approve

destroy-ohio:
	terraform workspace new ohio || \
	terraform workspace  select   ohio && \
	terraform   init   && \
	terraform  destroy  -var-file   envs/ohio.tfvars  -auto-approve

destroy-oregon:
	terraform workspace new oregon || \
	terraform workspace  select   oregon && \
	terraform   init   && \
	terraform  destroy  -var-file   envs/oregon.tfvars  -auto-approve

destroy-all:
	make destroy-virginia && \
	make destroy-ohio && \
	make destroy-oregon && \