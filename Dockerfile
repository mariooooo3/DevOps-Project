# Stage 1: Build
FROM gradle:7.6-jdk11 AS builder
WORKDIR /app
COPY DevOps-Project .
RUN chmod +x ./gradlew && ./gradlew build --no-daemon -x test

# Stage 2: Run
FROM eclipse-temurin:8-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
