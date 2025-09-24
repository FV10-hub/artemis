#### Usar el dockerfile solo para configuraciones con JDBC pero si solo 
#### se necesita un artemis de pruebas directo el compose

#### Construir

docker build -t spi-artemis .

#### Ambiente de desarrollo - Postgres

docker run --name artemis -d -p 8161:8161 -p 61616:61616 --env jdbcDriver=org.postgresql.Driver --env jdbcUrl=jdbc:postgresql://192.168.40.71:5432/ms_spi_dev --env jdbcUser=postgres --env jdbcPassword=PASS spi-artemis

#### Ambiente de desarrollo - Oracle

docker run --name artemis -d -p 8161:8161 -p 61616:61616 --env jdbcDriver=oracle.jdbc.OracleDriver --env jdbcUrl=jdbc:oracle:thin:@192.168.40.111:1521/uenodesl1 --env jdbcUser=spi --env jdbcPassword=PASS spi-artemis
