## Start
Execute `docker-compose up -d --no-recreate <service>` for setting up some particular services
e.g.
`docker-compose up -d --no-recreate pg94 mysql51`
or just
`docker-compose up -d --no-recreate`.

## Remove
`docker-compose stop <service> && docker-compose rm --force <service>`
e.g.
`docker-compose stop pg94 && docker-compose rm --force pg94`

## Update images
`docker-compose pull <service>`
e.g.
`docker-compose pull mysql51 mysql55 mysql56`

## Statefull services
For saving a state of a service you can use the stop command:
`docker-compose stop <service>`
e.g.
`docker-compose stop pg94`

## Useful links
1. https://docs.docker.com/compose/
1. https://github.com/docker/compose
1. https://github.com/sdurrheimer/docker-compose-zsh-completion
1. http://stackoverflow.com/a/32023104/1553664
1. https://github.com/chadoe/docker-cleanup-volumes – remove unused images

# Additional recipes

## PosgtgreSQL 9.3 with SSH
```
read MY_SSH_KEY < ~/.ssh/id_rsa.pub
docker run -ti -d -p 22223:22 -p 54032:5432 --name pg93ssh -e "PG_USERNAME=guest" -e "PG_PASSWORD=guest" -e "SSH_PUBLIC_KEY=$MY_SSH_KEY" nimiq/postgresql93
```

