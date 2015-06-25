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
1. http://stackoverflow.com/questions/24390329/cant-pull-docker-image-no-route-to-host
1. https://github.com/chadoe/docker-cleanup-volumes – remove unused images
