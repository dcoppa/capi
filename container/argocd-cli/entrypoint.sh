#!/bin/bash
if [ -z "${CLUSTER_NAME}" ]; then
  echo "ERROR: environment variable \"CLUSTER_NAME\" is not defined."
  exit 1
fi
/bin/sleep 1
until kubectl -n ${CLUSTER_NAME} get secrets ${CLUSTER_NAME}-kubeconfig ; do /bin/sleep 1 ; done
/usr/bin/argocd login --core
/usr/bin/argocd cluster rm ${CLUSTER_NAME} --yes
/usr/bin/kubectl get secrets --all-namespaces -l cluster.x-k8s.io/cluster-name=${CLUSTER_NAME} -o yaml | /usr/bin/awk -F value: '{print $2}' | /bin/base64 -d > /tmp/${CLUSTER_NAME}_kubeconfig
/usr/bin/argocd cluster add ${CLUSTER_NAME}_${CLUSTER_NAME}-control-plane-capi-admin@${CLUSTER_NAME}_${CLUSTER_NAME}-control-plane --kubeconfig /tmp/${CLUSTER_NAME}_kubeconfig --name ${CLUSTER_NAME} --yes
