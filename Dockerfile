# FROM gradle:jdk19 as builder
FROM arm64v8/gradle:7.6-jdk19-focal as builder

RUN git clone -b 4.0.0 https://github.com/hyness/spring-cloud-config-server.git /code
WORKDIR /code
RUN ./gradlew clean build

# FROM openjdk:19-jdk-alpine
FROM arm64v8/gradle:7.6-jdk19-focal
COPY --from=builder /code/build/libs/spring-cloud-config-server-4.0.0.jar /app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]