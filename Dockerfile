FROM maven:3.3.9-jdk-8-onbuild AS petclinicbuild
WORKDIR /usr/petclinic
COPY pom.xml .
COPY settings.xml /usr/share/maven/ref/
ADD src /usr/petclinic/src
RUN mvn -B -s /usr/share/maven/ref/settings.xml package -DskipTests

FROM tomcat:7-jre8
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY --from=0 /usr/petclinic/target/petclinic.war /usr/local/tomcat/webapps/petclinic.war
EXPOSE 8080