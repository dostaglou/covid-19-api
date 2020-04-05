# README

## Getting started

Fork the project, bundle install the gems.

You will need a `config/secrets.yml` file with a Slack WebHook
```
shared:
  webhook: YOUR-WEB-HOOK
```

You will also need to generate a list of the 201 countries so that you can pregen the nation's models to connect data, too.

## Database

### Docker
```
docker-compose up
```

### Local postgres
Start:
```
pg_ctl -D /usr/local/var/postgres start
```

Stop:
```
pg_ctl -D /usr/local/var/postgres stop
```