import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    id("java")
    id("application")
    id("com.github.johnrengelman.shadow") version "8.1.1"
    id("war")
    id("io.freefair.lombok") version "8.6"
}

application {
    mainClass.set(properties["mainClassName"] as String)
}

group = "ru.kpfu.itis.gr201.ponomarev"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework:spring-webmvc:${properties["springVersion"]}")
    implementation("org.springframework:spring-jdbc:${properties["springVersion"]}")
    implementation("org.springframework:spring-orm:${properties["springVersion"]}")
    implementation("org.springframework:spring-context-support:${properties["springVersion"]}")

    implementation("org.springframework.security:spring-security-core:${properties["springSecurityVersion"]}")
    implementation("org.springframework.security:spring-security-web:${properties["springSecurityVersion"]}")
    implementation("org.springframework.security:spring-security-config:${properties["springSecurityVersion"]}")
    implementation("org.springframework.security:spring-security-taglibs:${properties["springSecurityVersion"]}")

    implementation("org.springframework.data:spring-data-jpa:2.7.18")
    implementation("org.postgresql:postgresql:42.7.2")
    implementation("org.hibernate:hibernate-core:${properties["hibernateVersion"]}")
    implementation("org.hibernate:hibernate-entitymanager:${properties["hibernateVersion"]}")
    annotationProcessor("org.hibernate:hibernate-jpamodelgen:${properties["hibernateVersion"]}")

    implementation("org.freemarker:freemarker:2.3.32")

    implementation("com.fasterxml.jackson.core:jackson-core:2.17.0")
    implementation("com.fasterxml.jackson.core:jackson-databind:2.17.0")

    implementation("com.mchange:c3p0:0.9.5.5")

    implementation("javax.servlet:javax.servlet-api:4.0.1")

    implementation("com.cloudinary:cloudinary-core:${properties["cloudinaryVersion"]}")
    implementation("com.cloudinary:cloudinary-http44:${properties["cloudinaryVersion"]}")

    implementation("io.hypersistence:hypersistence-utils-hibernate-55:3.7.3")
}

tasks.withType<ShadowJar> {
    archiveFileName.set("hello.jar")
    mergeServiceFiles()
    manifest {
        attributes(mapOf("Main-Class" to properties["mainClassName"]))
    }
}
