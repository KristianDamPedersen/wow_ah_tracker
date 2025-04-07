FROM postgres:17

RUN apt-get -y update
RUN apt-get -y install make git
RUN git clone https://github.com/theory/pgtap.git

WORKDIR /pgtap
RUN make
RUN make install
