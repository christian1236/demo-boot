FROM openjdk:11-jre

COPY target/*.jar myapp.jar

ENTRYPOINT ["java", "-jar", "myapp.jar"]