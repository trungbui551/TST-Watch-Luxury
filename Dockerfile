# Stage 1: Build the application using Maven with Eclipse Temurin
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and download dependencies to cache them
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build war
COPY src ./src
RUN mvn clean package -DskipTests -B

# Stage 2: Create runtime container with Eclipse Temurin JRE
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built war file from stage 1
COPY --from=build /app/target/tstWatchLuxury.war app.war

# Port that application will expose
EXPOSE 8080

# Run the Spring Boot executable war
ENTRYPOINT ["java", "-jar", "app.war"]
