OUTPUT_PLAN_FILENAME=plan.tfplan

TERRAFORM_IMAGE=hashicorp/terraform:latest
TERRAFORM_CMD=docker run -it 						\
		  -v ${PWD}:/terraform 						\
		  -w "/terraform" 							\
		  ${TERRAFORM_IMAGE}
TERRAFORM_CMD=terraform

.PHONY: all
all: init plan apply

.PHONY: init
init:
	${TERRAFORM_CMD} init

.PHONY: clean
clean:
	rm terraform*
	rm -rf .terraform*
	rm plan.tfplan

.PHONY: validate
validate:
	${TERRAFORM_CMD} validate

.PHONY: plan
plan:
	${TERRAFORM_CMD} plan -out=${OUTPUT_PLAN_FILENAME}

.PHONY: apply
apply: plan
	${TERRAFORM_CMD} apply ${OUTPUT_PLAN_FILENAME}

.PHONY: destroy
destroy:
	${TERRAFORM_CMD} destroy -auto-approve
