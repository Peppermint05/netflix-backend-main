FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY .env /app/src/main/resources/.env
COPY ./pom.xml /app
COPY src ./src
RUN mvn -f /app/pom.xml clean package -DskipTests
RUN ls -la /app/target


FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]