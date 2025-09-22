OUTPUT_PLAN_FILENAME=plan.tfplan

RELATIVE_PATH  := $(shell git rev-parse --show-prefix)

TERRAFORM_IMAGE=hashicorp/terraform:latest
TERRAFORM_CMD=docker run -it 							\
		  -e TF_VAR_aws_profile=${TF_VAR_aws_profile}	\
		  -e TF_VAR_aws_account=${TF_VAR_aws_account}	\
		  -e TF_VAR_aws_region=${TF_VAR_aws_region}		\
		  -v "${HOME}/.aws:/root/.aws:ro" 				\
		  -v ${IAC_DIR}:/poc-msk/iac 					\
		  -w "/poc-msk/${RELATIVE_PATH}"				\
		  ${TERRAFORM_IMAGE}

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
