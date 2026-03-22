CIDR=`grep -Po '(?<=--cluster-cidr=)[\d./]+' /etc/kubernetes/manifests/kube-controller-manager.yaml`

if [[ -z "$CIDR" ]];then
  echo Error: Can\'t find CIDR in /etc/kubernetes/manifests/kube-apiserver.yaml 
  exit 1
fi


kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.31.4/manifests/tigera-operator.yaml

cnt=0
while [[ $cnt -lt 10 ]];do
if [[ `kubectl -n tigera-operator get deployments | awk 'NR==2{print $2}'` == "1/1" ]];then
curl -s https://raw.githubusercontent.com/projectcalico/calico/v3.31.4/manifests/custom-resources.yaml | sed "s#^\s*cidr:.*#        cidr: $CIDR#" | kubectl apply -f -
echo calico install success.
exit
fi

cnt=$(( $cnt + 1 ))
echo waiting operator be Ready...
sleep 30
done

echo Error: operator install failed.
