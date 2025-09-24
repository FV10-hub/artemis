FROM eclipse-temurin:11-centos7
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG ARTEMIS_USERNAME
ARG ARTEMIS_PASSWORD

###----------###
### INSTALAR ###
###----------###

WORKDIR /opt

# Docker va a descomprimir automáticamente al agregar el archivo .tar.gz
ADD apache-artemis-*-bin.tar.gz .

# Renombrar para que no afecte el cambio de versión
RUN mv apache-artemis-*/ apache-artemis/

# Agregar librerías
ADD lib/* apache-artemis/lib/


###-------------###
### INICIALIZAR ###
###-------------###

WORKDIR /opt/apache-artemis/bin/

# Inicializar Artemis
RUN ./artemis create --user $ARTEMIS_USERNAME --password $ARTEMIS_PASSWORD --silent --require-login spi


###------------###
### CONFIGURAR ###
###------------###

WORKDIR /opt/apache-artemis/bin/spi/

# Sobrescribir archivos de configuración

RUN rm etc/bootstrap.xml
ADD etc/bootstrap.xml etc/

RUN rm etc/broker.xml
ADD etc/broker.xml etc/


EXPOSE \
# Web Server
    8161 \
# JMX Exporter
    9404 \
# Port for CORE, MQTT, AMQP, HORNETQ, STOMP, OPENWIRE
    61616 \
# Port for HORNETQ,STOMP
    5445 \
# Port for AMQP
    5672 \
# Port for MQTT
    1883 \
# Port for STOMP
    61613

ADD entrypoint.sh /opt/
ENTRYPOINT ["/opt/entrypoint.sh"]
