

# Use an official Maven image as a parent image
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Download and cache Maven dependencies
RUN mvn dependency:go-offline

# Copy the application source code to the container
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Create a new container for the application
FROM tomcat:9-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file from the build container to the new container
COPY --from=build /app/target/*.war ./

# Run Tomcat
EXPOSE 8089
CMD ["catalina.sh", "run"]