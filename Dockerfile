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
RUN apt install -y libcurl4-openssl-dev libssl-dev g++ postgresql-server-dev-17
WORKDIR /http-psql
RUN curl -L https://github.com/pramsey/pgsql-http/archive/refs/tags/v1.6.3.zip -o http.zip
RUN unzip http.zip
WORKDIR /http-psql/pgsql-http-1.6.3
RUN make
RUN make install