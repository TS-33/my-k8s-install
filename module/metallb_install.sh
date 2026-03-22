NODE_NUM=`kubectl get nodes --no-headers | wc -l`
kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl apply -f - -n kube-system


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.15.3/config/manifests/metallb-native.yaml

cnt=0
while [[ $cnt -lt 10 ]];do
if [[ `kubectl -n metallb-system get daemonsets.apps | awk 'NR==2{print $4}'` == $NODE_NUM ]];then

read -r -e -p "请输入空闲的IP地址范围(192.168.36.90-192.168.36.95)：" IP
if [[ -z $IP ]];then
IP="192.168.36.90-192.168.36.95"
fi
echo IP=$IP
cat <<EOF | kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - $IP
EOF


cat <<EOF | kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: example
  namespace: metallb-system

EOF

echo metallb install success.
break

fi

echo waiting metallb operator Ready...
sleep 30
done

echo Error: metallb operator state error
