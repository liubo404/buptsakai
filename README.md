#first comment
Build a docker image for deploying sakai from src version.

Notice:
-1. download the java maven tomcat before run the docker build command
-2. change folder names in Dockerfile if you change them after download.
-3. config maven settings.xml to use your repository if you have one.


# download JDK
```bash
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz
tar xzvf jdk-7u79-linux-x64.tar.gz
```

# download maven
```bash
wget http://mirror.bit.edu.cn/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
tar xzvf apache-maven-3.3.3-bin.tar.gz
```

#download tomcat
```bash
wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.64/bin/apache-tomcat-7.0.64.tar.gz
tar xzvf apache-tomcat-7.0.64.tar.gz

```

#download sakai source code and unzip it named sakai-bupt folder


# build the docker image
```bash
docker build -t bysakai:0.0.1 .
```
just wait it to complete...lucky~
