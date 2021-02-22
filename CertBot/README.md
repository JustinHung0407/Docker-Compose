## Certbot
Docs: [https://certbot.eff.org/lets-encrypt/centosrhel7-other]()

<!-- Install Snap -->
`sudo yum install epel-release`
`sudo yum install snapd`
`sudo systemctl enable --now snapd.socket`
`sudo ln -s /var/lib/snapd/snap /snap`

<!-- Snap install certbot-->
`sudo snap install core; sudo snap refresh core`
`sudo snap install --classic certbot`
`sudo ln -s /snap/bin/certbot /usr/bin/certbot`

<!-- Certbot install -->
- Server is not currently running on this machine.
  - `sudo certbot certonly --standalone`
- Keep my web server running.
  - `sudo certbot certonly --webroot`
- Renewing 
  - `sudo certbot renew --dry-run`


<!-- Keyckloak Install -->
`sudo docker run -d -v /etc/letsencrypt/live/openid.omnithings.io/fullchain.pem:/etc/x509/https/tls.crt -v /etc/letsencrypt/live/openid.omnithings.io/privkey.pem:/etc/x509/https/tls.key  -p 443:8443 -p 80:8080  -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=70538068  jboss/keycloak:latest`