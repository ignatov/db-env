## Start
```
docker-compose up -d --no-recreate <service>
```
e.g.
```
docker-compose up -d --no-recreate pg94 pg93 mysql55 mysql51
```
or just
```
docker-compose up -d --no-recreate
```

## Remove
```
docker-compose stop <service> && docker-compose rm --force <service>
```
e.g.
```
docker-compose stop pg94 && docker-compose rm --force pg94
```

## Statefull services
For saving a state of a service you can use the stop command:
```
docker-compose stop <service>
```
e.g.
```
docker-compose stop pg94
```
