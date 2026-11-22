#!/bin/sh
# Railway wrapper for Dreeve: upstream runs two containers (web + daemon) that share volumes, which Railway cannot do,
# so this single service runs the daemon beside the web server. Everything else is upstream's own entrypoint.
set -e
S=/var/www/storage
mkdir -p $S/database $S/files $S/watch $S/backups
# one Railway volume on /var/www/storage: keep the watch and backups folders on it through symlinks
for d in watch backups; do
  if [ ! -L /var/www/$d ]; then rm -rf /var/www/$d; ln -s $S/$d /var/www/$d; fi
done
# upstream wants a bcrypt hash; derive it from the generated ADMIN_PASSWORD at boot
if [ -z "$ADMIN_PASSWORD_HASH" ] && [ -n "$ADMIN_PASSWORD" ]; then
  ADMIN_PASSWORD_HASH=$(php -r 'echo password_hash(getenv("ADMIN_PASSWORD"), PASSWORD_BCRYPT);')
  export ADMIN_PASSWORD_HASH
fi
# daemon (waits for the schema that the web entrypoint migrates), restarted if it ever exits
( while true; do docker-entrypoint.sh bin/console app:daemon:run || true; sleep 10; done ) &
exec docker-entrypoint.sh frankenphp run --config /etc/frankenphp/Caddyfile
