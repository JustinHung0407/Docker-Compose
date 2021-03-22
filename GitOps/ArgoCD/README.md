export ARGOCD_SERVER=https://argocd-https-0b24258d.baas.tmpstg.twcc.tw

export ARGOCD_SERVER=https://argo.baas.twcc.tw

export ARGOCD_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJhN2FiNzdmMy0xNzYyLTQ2MmYtYjU2YS1mYzRhZDhkYTVhMDEiLCJpYXQiOjE2MDk4Mzk5NjIsImlzcyI6ImFyZ29jZCIsIm5iZiI6MTYwOTgzOTk2Miwic3ViIjoiYWRtaW4ifQ.rlmaThJ_kbYd8TjjtghDDDBNdf62ali5RlbyF20W5sY"

export ARGOCD_OPTS="--plaintext --insecure"


argocd login argo.baas.twcc.tw --grpc-web


<!-- Updating admin password -->
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$10$i32P1h3kAFDCoHoMbFj7KuqGKOvdtSqA8pu2ote/5.GLUkztjT2nm",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'
