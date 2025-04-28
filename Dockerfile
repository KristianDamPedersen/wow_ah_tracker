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
