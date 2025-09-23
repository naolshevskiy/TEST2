# Traefik demo
## docker-compose-1.yml - обычный запуск
watch -n 1 curl -L -H Host:<HOST_IP> http://<HOST_IP>:<HOST_PORT>
## docker-compose-2.yml - sticky
for i in $(seq 3); do docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' traefik-whoami-$i; done
## docker-compose-3.yml - healthcheck
## docker-compose-4.yml - tls





