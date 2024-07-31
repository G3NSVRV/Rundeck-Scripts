ARG IMAGE
FROM ${IMAGE}

CMD ["java","-Dcom.sun.management.jmxremote","-Dcom.sun.management.jmxremote.port=9010","-Dcom.sun.management.jmxremote.local.only=false","-Dcom.sun.management.jmxremote.authenticate=false","-Dcom.sun.management.jmxremote.ssl=false","-Djava.rmi.server.hostname=$(hostname)","-jar","pd-runner.jar"]