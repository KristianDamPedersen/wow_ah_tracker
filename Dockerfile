FROM postgres:17

# Install PgTap (Unit testing framework)
RUN apt-get -y update
RUN apt-get -y install make git
RUN git clone https://github.com/theory/pgtap.git

WORKDIR /pgtap
RUN make
RUN make install

# Install pg_prove (CLI tool for running unit tests)
RUN cpan TAP::Parser::SourceHandler::pgTAP

