#!/bin/sh

# Script to seal a single sealed secret value, for convenience for pasting into a helm values file
set -eu

usage() {
  echo "Usage: $(basename "$0") < -n namespace> < -s secret-name> < -k key> < -v value> [ -c context-name]"
  echo "< -n namespace> is the k8s namespace intended for the secret"
  echo "< -s secret-name> is the k8s secret name the controller will create"
  echo "< -k key> is the k8s secret key name"
  echo "< -v value> is the secret value being encrypted"
  echo "[-c context-name] will default to current-context unless provided"
  exit 1
}

NAMESPACE="${NAMESPACE:-}"
SECRET_NAME="${NAME:-}"
KEY="${KEY:-}"
VALUE="${VALUE:-}"
CLUSTER_CONTEXT="${CLUSTER_CONTEXT:-}"

while getopts 'n:s:k:v:c:' opt; do
  case "$opt" in
    n) NAMESPACE="$OPTARG";;
    s) SECRET_NAME="$OPTARG";;
    k) KEY="$OPTARG";;
    v) VALUE="$OPTARG";;
    c) CLUSTER_CONTEXT="$OPTARG";;
    *) usage
       exit 1 ;;
  esac
done

if [ -z "$CLUSTER_CONTEXT" ]; then
    echo "Cluster context not set, using currently set context $(kubectl config current-context)"
    echo "If you're creating a secret for a different cluster rerun the script and pass the context name for the cluster"
    echo ""
    CLUSTER_CONTEXT=$(kubectl config current-context)
else 
    echo "Context name set - creating secret $SECRET_NAME against $CLUSTER_CONTEXT"
    kubectl config use-context "$CLUSTER_CONTEXT"
fi

if [ -z "$VALUE" ]; then
  usage
fi

secretManifest=$(echo -n "${VALUE}" | kubectl create secret generic "${SECRET_NAME}" --dry-run=client --namespace "${NAMESPACE}"  --from-literal="${KEY}"="${VALUE}" -o json 2>&1)
sealedManifest=`echo $secretManifest | kubeseal --namespace "${NAMESPACE}" --controller-namespace sealed-secrets --controller-name sealed-secrets  2>&1`
sealedValue=`echo $sealedManifest | jq --arg 'key' "${KEY}" '.spec.encryptedData[$key]' -r`

echo "${KEY}: '${sealedValue}'"
