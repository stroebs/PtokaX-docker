# PtokaX-docker

PtokaX DC++ hub built as a docker container. See http://www.ptokax.org.

This version is compiled without any database support (SQLite, MySQL or Postgres).

## Running

```bash
docker run -p 411:411 rsubr/ptokax
```

## Notes
1. Config dir is mounted in `/cfg`, bind mount it externally to customize settings.
2. This container is based on Ubuntu Jammy and PtokaX runs as the `www-data` user.
