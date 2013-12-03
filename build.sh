#!/bin/sh

mvn clean install 
cp target/hello-java-mysql-1.0.war ~/workspace/tools/apache-tomcat-7.0.35/webapps
