FROM jasonrivers/nagios:latest

LABEL MAINTAINER="huxiba@gmail.com" 		\
      description="Nagios with python3.6,oracle-instanceclient11.2,cx_Oracle" \
      version="1.0"

ENV NAGIOS_TIMEZONE        Asia/Shanghai
ENV LD_LIBRARY_PATH 	   /opt/oracle/instantclient_11_2

RUN apt-get update && apt-get install -y    \
	unzip					\
	software-properties-common              \
        python-software-properties &&       \
    apt-get clean && rm -Rf /var/lib/apt/lists/*
RUN add-apt-repository -y ppa:jonathonf/python-3.6 &&   \
    apt-get update && apt-get install -y                \
        python3.6                                       \
	libaio1                                          && \
    apt-get clean && rm -Rf /var/lib/apt/lists/*


ADD instantclient-*-11.2.0.4.0.zip /tmp/
RUN cd /tmp/ && \
    unzip instantclient-basic-linux.x64-11.2.0.4.0.zip -d /opt/oracle && \
    unzip instantclient-sqlplus-linux.x64-11.2.0.4.0.zip -d /opt/oracle && \
    rm -f instantclient-*-11.2.0.4.0.zip	&& \
    cd /opt/oracle/instantclient_11_2		&& \
    ln -s libclntsh.so.11.1 libclntsh.so	&& \
    ln -s libocci.so.11.1 libocci.so
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.6 get-pip.py                      && \
    rm get-pip.py
RUN export LD_LIBRARY_PATH=/opt/oracle/instantclient_11_2;pip3.6 install cx_Oracle