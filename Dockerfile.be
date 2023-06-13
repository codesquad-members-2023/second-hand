FROM openjdk:11-slim

ARG JAR_FILE=build/libs/*.jar

COPY ${JAR_FILE} secondhand-be.jar

ENTRYPOINT ["java","-jar","/secondhand-be.jar"]
