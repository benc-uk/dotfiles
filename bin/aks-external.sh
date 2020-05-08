echo "### Deleting old service and waiting..."
kubectl delete svc dash-external -n kube-system
sleep 120

lbip="40.127.206.0"
ip=`curl -s ipinfo.io/ip`
echo "### Your public IP has been detected as $ip"

cat > /tmp/dash.yaml <<- EOM
kind: Service
apiVersion: v1
metadata:
  name: dash-external
spec:
  type: LoadBalancer
  ports:
  - protocol: TCP
    port: 80
    targetPort: 9090
  selector:
    k8s-app: kubernetes-dashboard
  loadBalancerIP: $lbip
  loadBalancerSourceRanges:
  - $ip/32
EOM

echo "### Creating new service 'dash-external'"
kubectl apply -f /tmp/dash.yaml -n kube-system

echo "### Get the new IP external IP once it is assigned..."
kubectl get svc dash-external -n kube-system -w
