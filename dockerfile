# Stage 1: Build Stage
FROM maven:3.8.4-openjdk-11-slim AS build-stage

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml ./

RUN mvn dependency:go-offline 

# Copy source code and package the application
COPY src ./src

RUN mvn package 

# Stage 2: Runtime Stage
FROM tomcat:8.5.78-jdk11-openjdk-slim

# Copy the WAR file from the build stage
COPY --from=build-stage /app/target/*.war /usr/local/tomcat/webapps/

# Expose port 8080 for the application
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

