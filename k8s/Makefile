APPLICATION_NAMESPACE=poc-aws-msk
SERVICE_ACCOUNT_TOPIC_OWNER=topic-owner
SERVICE_ACCOUNT_READ=topic-read
SERVICE_ACCOUNT_WRITE=topic-write
TEST_TOPIC_NAME=test-topic

BOOTSTRAP_SERVER				:= $(shell jq -r '.outputs.bootstrap_brokers_sasl_iam.value' ../iac/use-cases/base/msk/cluster/terraform.tfstate)

EKS_CLUSTER_NAME 				:= $(shell jq -r '.outputs.id.value' ../iac/use-cases/base/eks/cluster/terraform.tfstate)

EKS_TOPIC_OWNER_ROLE_ARN		:= $(shell jq -r '.outputs.arn.value' ../iac/use-cases/irsa/iam/roles/topic-owner/terraform.tfstate)
EKS_WRITE_ROLE_ARN				:= $(shell jq -r '.outputs.arn.value' ../iac/use-cases/irsa/iam/roles/topic-write/terraform.tfstate)
EKS_READ_ROLE_ARN				:= $(shell jq -r '.outputs.arn.value' ../iac/use-cases/irsa/iam/roles/topic-read/terraform.tfstate)

setup-kubconfig:
	aws eks update-kubeconfig --region us-east-1 --name ${EKS_CLUSTER_NAME} --profile main_account

get-pods:
	kubectl get pods --namespace ${APPLICATION_NAMESPACE}

create-namespace:
	kubectl create namespace ${APPLICATION_NAMESPACE}

delete-namespace:
	kubectl delete namespace ${APPLICATION_NAMESPACE}

create-service-accounts:
	APPLICATION_NAMESPACE=${APPLICATION_NAMESPACE}							\
	SERVICE_ACCOUNT_TOPIC_OWNER=${SERVICE_ACCOUNT_TOPIC_OWNER}				\
	SERVICE_ACCOUNT_READ=${SERVICE_ACCOUNT_READ}							\
	SERVICE_ACCOUNT_WRITE=${SERVICE_ACCOUNT_WRITE}							\
	EKS_TOPIC_OWNER_ROLE_ARN=${EKS_TOPIC_OWNER_ROLE_ARN}					\
	EKS_READ_ROLE_ARN=${EKS_READ_ROLE_ARN}									\
	EKS_WRITE_ROLE_ARN=${EKS_WRITE_ROLE_ARN}								\
		envsubst < ./deployments/service-account.yml | kubectl apply -f -

get-service-accounts:
	kubectl get sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_TOPIC_OWNER} -o yaml
	kubectl get sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_READ} -o yaml
	kubectl get sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_WRITE} -o yaml

delete-service-accounts:
	kubectl delete sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_TOPIC_OWNER}
	kubectl delete sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_READ}
	kubectl delete sa --namespace ${APPLICATION_NAMESPACE} ${SERVICE_ACCOUNT_WRITE}

create-client-properties-configmap:
	APPLICATION_NAMESPACE=${APPLICATION_NAMESPACE}							\
		envsubst < ./deployments/client-properties.yml | kubectl apply -f -

deploy-kafka-clients: create-client-properties-configmap
	TEST_TOPIC_NAME=${TEST_TOPIC_NAME}										\
	APPLICATION_NAMESPACE=${APPLICATION_NAMESPACE}							\
	SERVICE_ACCOUNT_TOPIC_OWNER=${SERVICE_ACCOUNT_TOPIC_OWNER}				\
	SERVICE_ACCOUNT_READ=${SERVICE_ACCOUNT_READ} 							\
	SERVICE_ACCOUNT_WRITE=${SERVICE_ACCOUNT_WRITE}							\
	BOOTSTRAP_SERVER=${BOOTSTRAP_SERVER}									\
		envsubst < ./deployments/kafka-clients.yml | kubectl apply -f -

delete-kafka-clients:
	kubectl delete pod --namespace ${APPLICATION_NAMESPACE} kafka-producer kafka-consumer kafka-topic-owner

check-kafka-clients-identities:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-topic-owner -- env
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-producer -- env
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-consumer -- env

cp-confluent-dependency-to-pods:
	kubectl cp ${CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH} ${APPLICATION_NAMESPACE}/kafka-producer:/opt/kafka/libs/
	kubectl cp ${CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH} ${APPLICATION_NAMESPACE}/kafka-consumer:/opt/kafka/libs/
	kubectl cp ${CONFLUENT_OAUTH_EXTENSIONS_LIB_PATH} ${APPLICATION_NAMESPACE}/kafka-topic-owner:/opt/kafka/libs/

run-kafka-producer:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-producer -- bash

run-kafka-consumer:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-consumer -- bash

run-kafka-topic-owner:
	kubectl exec --namespace ${APPLICATION_NAMESPACE} -it kafka-topic-owner -- bash

clean: delete-kafka-clients delete-service-accounts delete-namespace
