# PostgreSQL + Backup/Restore

An auto-restoring Postgres server running on Akash, with backups taken on a configurable schedule. Backups are stored on decentralised storage using Filebase.

Ultimately this is a two container setup, one PostgreSQL server and one scheduler container to restore the database on boot, and run a cronjob to back it up.

See [ovrclk/akash-postgres-restore](https://github.com/ovrclk/akash-postgres-restore) for more information.
