#!/bin/bash
echo "shared_preload_libraries = 'timescaledb'" >> "$PGDATA/postgresql.conf"
