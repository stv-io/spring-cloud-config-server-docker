# FROM gradle:jdk19 as builder
# FROM arm64v8/gradle:7.6-jdk19-focal as builder
FROM amazoncorretto:19.0.1-al2 as builder
RUN yum install -y git unzip
RUN curl -SLO https://services.gradle.org/distributions/gradle-7.6-bin.zip
RUN mkdir /opt/gradle
RUN unzip -d /opt/gradle gradle-7.6-bin.zip
RUN export PATH=$PATH:/opt/gradle/gradle-7.6/bin
RUN git clone -b 4.0.0 https://github.com/hyness/spring-cloud-config-server.git /code
WORKDIR /code
RUN ./gradlew clean build

# FROM openjdk:19-jdk-alpine
# FROM arm64v8/gradle:7.6-jdk19-focal
FROM amazoncorretto:19-alpine3.16-full
COPY --from=builder /code/build/libs/spring-cloud-config-server-4.0.0.jar /app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]