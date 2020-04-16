#! /bin/bash
# exit script when any command ran here returns with non-zero exit code
set -e

COMMIT_SHA1=$CIRCLE_SHA1
SHORT_HASH=$(echo $COMMIT_SHA1 | cut -c -7)

# We must export it so it's available for envsubst
export SHORT_HASH=$SHORT_HASH

# since the only way for envsubst to work on files is using input/output redirection,
#  it's not possible to do in-place substitution, so we need to save the output to another file
#  and overwrite the original with that one.
envsubst <./kube/01-simple-app-deployment.yaml >./kube/01-simple-app-deployment.yaml.out
mv ./kube/01-simple-app-deployment.yaml.out ./kube/01-simple-app-deployment.yaml

CERT_MID=$(echo "$KUBERNETES_CLUSTER_CERTIFICATE" | base64 --decode)
echo "$CERT_MID" | base64 --decode > cert.crt

./kubectl \
  --kubeconfig=/dev/null \
  --server=$KUBERNETES_SERVER \
  --certificate-authority=cert.crt \
  --token=$KUBERNETES_TOKEN \
  apply -f ./kube/