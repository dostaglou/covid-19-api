# README

To Start:
Fork the project, bundle install the gems.

For the local PG server:
Start:
pg_ctl -D /usr/local/var/postgres start

Stop:
pg_ctl -D /usr/local/var/postgres stop


You will need a secrets.yml file with a Slack WebHook
shared:
  webhook: YOUR-WEB-HOOK

You will also need to generate a list of the 201 countries so that you can pregen the nation's models to connect data, too.
