# Add container port to deployment

kubectl edit deployment nodeport-deployment

spec:
  template:
    spec:
      containers:
        - name: <container-name> # Keep the existing container name
          ports:                 # Add this four lines from here
            - name: http
              containerPort: 80
              protocol: TCP

create yaml file from the command line or K8s document

kubectl expose deployment nodeport-deployment \
  --name=nodeport-service \
  --type=NodePort \
  --port=80 \
  --target-port=80 \
  --protocol=TCP \
  --dry-run=client -o yaml > nodeport-service.yaml
  
vim nodeport-service.yaml 
nodePort: 30080 #add  this two lines after dryrun 
name: http

kubectl get deploy nodeport-deployment -n relative -o wide

# Create NodePort service on 30080
cat <<'EOF' > svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: nodeport-service
  namespace: relative
spec:
  type: NodePort
  selector:
    app: nodeport-deployment
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
    nodePort: 30080
EOF
kubectl apply -f svc.yaml
kubectl get svc nodeport-service -n relative -o wide
# Test: curl http://<nodeIP>:30080
