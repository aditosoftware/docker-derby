FROM openjdk:8-jre-alpine
MAINTAINER Andreas Zitzelsberger "az@az82.de"

ENV DERBY_HOME=/derby
ENV DERBY_LIB=${DERBY_HOME}/lib
ENV CLASSPATH=${DERBY_LIB}/derby.jar:${DERBY_LIB}/derbynet.jar:${DERBY_LIB}/derbytools.jar:${DERBY_LIB}/derbyoptionaltools.jar:${DERBY_LIB}/derbyclient.jar

RUN \
    apk add --update openssl && \
    wget https://dist.apache.org/repos/dist/release/db/derby/db-derby-10.14.1.0/db-derby-10.14.1.0-bin.tar.gz && \
    tar xzf /db-derby-10.14.1.0-bin.tar.gz && \
    mv /db-derby-10.14.1.0-bin /derby && \
    rm -Rf /*.tar.gz ${DERBY_HOME}/demo ${DERBY_HOME}/javadoc ${DERBY_HOME}/docs ${DERBY_HOME}/test ${DERBY_HOME}/*.html ${DERBY_HOME}/KEYS && \
    apk del openssl

WORKDIR /dbs
VOLUME ["/dbs"]
EXPOSE 1527

HEALTHCHECK CMD nc -z localhost 1527 || exit 1

CMD ["java", "-Dderby.stream.error.field=java.lang.System.out", "org.apache.derby.drda.NetworkServerControl", "start", "-h", "0.0.0.0"]
