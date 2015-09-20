FROM debian
MAINTAINER libu


# create dirs
RUN mkdir /tools
RUN mkdir -p /workspace/mvnrepos
ENV TOOL /tools
ENV WS /workspace


# update system
RUN rm -rf /etc/apt/sources.list
ADD ./sources.list /etc/apt/sources.list
RUN apt-get update -y


# install tools
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y emacs
RUN apt-get install -y git
RUN apt-get install -y subversion
RUN apt-get install -y libapache2-svn


# add java maven tomcat
ENV MAVEN  apache-maven-3.3.3
ENV JDK   jdk1.7.0_79
ENV TOMCAT apache-tomcat-7.0.64
ENV JAVA_HOME     $TOOL/$JDK
ENV MAVEN_HOME    $TOOL/$MAVEN
ENV CATALINA_HOME $TOOL/$TOMCAT

ADD ./$JDK    $JAVA_HOME
ADD ./$MAVEN  $MAVEN_HOME
ADD ./$TOMCAT $CATALINA_HOME

ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$CATALINA_HOME:$PATH


# set env
RUN echo "export JAVA_HOME=$JAVA_HOME">>~/.bashrc
RUN echo "export MAVEN_HOME=$MAVEN_HOME">>~/.bashrc
RUN echo "export CATALINA_HOME=$CATALINA_HOME">>~/.bashrc
RUN echo "export PATH=$PATH">>~/.bashrc

# test java maven version
RUN java -version
RUN mvn -version


# add sakai src folder
ADD ./sakai-bupt $WS/sakai-bupt


# compile src and deploy to tomcat
WORKDIR $WS/sakai-bupt
RUN mvn clean install sakai:deploy -Dmaven.test.skip=true -Dmaven.tomcat.home=$CATALINA_HOME -Dsakai.home=$CATALINA_HOME/sakai

EXPOSE 8080
CMD $CATALINA_HOME/bin/catalina.sh run
