FROM postgres:17

#  Install PgTap (unit tests)
RUN apt-get -y update
RUN apt-get -y install make git
RUN git clone https://github.com/theory/pgtap.git

WORKDIR /pgtap
RUN make
RUN make install

# Install PostgREST (REST API layer)
RUN apt-get -y install libpq-dev curl
RUN curl -L https://github.com/PostgREST/postgrest/releases/download/v12.2.11/postgrest-v12.2.11-linux-static-x86-64.tar.xz -o postgrest.tar.xz
RUN tar xJf postgrest.tar.xz

# Install curl http, postgres dev needed for postgres.h in the build process of the extension
RUN apt install -y libcurl4-openssl-dev libssl-dev g++ postgresql-server-dev-17 unzip
WORKDIR /http-psql
RUN curl -L https://github.com/pramsey/pgsql-http/archive/refs/tags/v1.6.3.zip -o http.zip
RUN unzip http.zip
WORKDIR /http-psql/pgsql-http-1.6.3
RUN make
RUN make install

#install supabase vault
WORKDIR /supabaseVault
RUN apt install -y libsodium-dev libsodium23
RUN curl -L https://github.com/supabase/vault/archive/refs/tags/v0.3.1.zip -o supabasevault.zip
RUN unzip ./supabasevault.zip 
RUN ls .
WORKDIR ./vault-0.3.1
RUN make
RUN make install
RUN mkdir /scripts
RUN echo '#!/bin/sh\ncat /run/secrets/vault_encryption_key' > /scripts/get_key.sh
RUN chmod +x /scripts/get_key.sh

# Install TimescaleDB
RUN apt install -y gnupg postgresql-common apt-transport-https lsb-release wget
RUN /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
RUN apt install postgresql-server-dev-17
RUN echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/timescaledb.list
RUN wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg
RUN apt update -y
RUN apt install -y timescaledb-2-postgresql-17 postgresql-client-17

# Add entrypoint init script
COPY init-timescaledb.sh /docker-entry-initdb.d/init-timescaledb.sh
RUN chmod +x /docker-entry-initdb.d/init-timescaledb.sh
