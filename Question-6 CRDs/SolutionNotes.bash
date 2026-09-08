# List cert-manager CRDs and save
kubectl get crd -l app.kubernetes.io/instance=cert-manager -o yaml > /root/resources.yaml

# Save spec subject explain output
kubectl explain certificate.spec.subject > /root/subject.yaml
