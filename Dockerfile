FROM debian:latest

MAINTAINER liubo

RUN mkdir /tools
RUN mkdir -p /benwork/mvnrepos
ENV tools /tools


#ADD ./tools/*.gz $tools/

#ADD apache-maven-3.3.3-bin.tar.gz $tools/
#ADD apache-tomcat-7.0.64.tar.gz $tools/
#ADD jdk-7u79-linux-x64.tar.gz $tools/


#######

#RUN tar -xzvf $tools/apache-maven-3.3.3-bin.tar.gz  
#RUN tar -xzvf $tools/apache-tomcat-7.0.64.tar.gz  
#RUN tar -xzvf $tools/jdk-7u79-linux-x64.tar.gz

WORKDIR $tools

ADD ./apache-maven-3.3.3 $tools/apache-maven-3.3.3
ADD ./apache-tomcat-7.0.64 $tools/apache-tomcat-7.0.64
ADD ./jdk1.7.0_79 $tools/jdk1.7.0_79


#RUN rm -rf /tools/apache-maven-3.3.3/conf/settings.xml
#ADD settings.xml /tools/apache-maven-3.3.3/conf/

#RUN mkdir /tools/apache-tomcat-7.0.64/sakai 
#ADD sakai.properties  /tools/apache-tomcat-7.0.64/sakai/




RUN echo "export JAVA_HOME=/tools/jdk1.7.0_79" >>~/.bashrc
RUN echo "export MVN_HOME=/tools/apache-maven-3.3.3" >>~/.bashrc
RUN echo "export CATALINA_HOME=/tools/apache-tomcat-7.0.64" >>~/.bashrc

RUN echo "export PATH=/tools/jdk1.7.0_79/bin:/tools/apache-maven-3.3.3/bin:$PATH" >>~/.bashrc

#RUN source ~/.bashrc

RUN echo "" >/etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://ftp.cn.debian.org/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp.cn.debian.org/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y wget curl  emacs git subversion libapache2-svn

WORKDIR /benwork
RUN svn checkout http://123.57.153.60:88/svn/gkc/develop/CODE/iscas/trunk --username liubo --password liubo18766
RUN cd trunk
RUN mvn clean install sakai:deploy -Dmaven.test.skip=true -Dmaven.tomcat.home=/tools/apache-tomcat-7.0.64 -Dsakai.home=/tools/apache-tomcat-7.0.64/sakai 





EXPOSE 8080 
CMD ["bash","/tools/apache-tomcat-7.0.64/bin/startup.sh"]
 
