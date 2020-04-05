# README

## Getting started

Fork the project, bundle install the gems.

You will need a `config/secrets.yml` file with a Slack WebHook
```yml
shared:
  webhook: "YOUR-WEB-HOOK"
```
Similarly, if you wish to use the LineBot component, you will need to set up you will need to set up your own line dev account. The following is the source I used to setting up this projects LINE bot (Japanese): https://qiita.com/noriya1217/items/00d6461e9f54900377a3

Once set up, you will need to add your own Line credentials in the secrets.yml

```yml
shared:
  webhook: "YOUR-WEB-HOOK"
  line:
    channel_secret: "YOUR-CHANNEL-SECRET"
    channel_token: "YOUR-CHANNEL-TOKEN"
```

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
