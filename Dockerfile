FROM gradle:6.9-jdk11 AS build

WORKDIR /app

COPY gradle gradle
COPY gradlew settings.gradle build.gradle ./

RUN ./gradlew wrapper --gradle-version 6.9

COPY . .

RUN ./gradlew bootJar -x test

FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8484

CMD ["java", "-jar", "app.jar"]
