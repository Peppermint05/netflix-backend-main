FROM ubuntu
#install necessary packages
RUN apt-get update && apt-get install -y 
RUN sudo apt install open jdk-17-jre-headless -y
RUN apt install maven -y
#set working directory
WORKDIR /app
#copy source code and pom.xml to the container
COPY src /app/src
COPY pom.xml /app

#build the application using maven
Run mvn -f /app/pom.xml clean package -DskipTests
#copy the built jar file to the container
COPY ./target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]