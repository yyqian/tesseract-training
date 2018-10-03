FROM centos:7
RUN yum update -y && yum install epel-release -y && yum update -y && yum install -y tesseract gcc gcc-c++ && yum clean all
