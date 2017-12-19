FROM centos:centos7
MAINTAINER monkeydaichan

RUN yum -y install kernel-devel kernel-headers gcc-c++ patch libyaml-devel libffi-devel autoconf automake make libtool bison tk-devel zip wget tar gcc zlib zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git gdbm-devel python-devel unzip 

#install PhantomJS
RUN yum -y install epel-release
RUN rpm -ivh http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
RUN yum -y install phantomjs

#install japanese
RUN wget -S -O "NotoSansCJKjp-hinted.zip" "https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip"

RUN mkdir /usr/share/fonts/noto
RUN unzip NotoSansCJKjp-hinted.zip
RUN cp -p *.otf /usr/share/fonts/noto/
RUN chmod 644 /usr/share/fonts/noto/*.otf
RUN chown root:root /usr/share/fonts/noto/*.otf

#pyenv install
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH

RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    eval "$(pyenv init -)"

#pip install 
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python

#python3.6.3 install & set default version
RUN pyenv install 3.6.3 && \
    pyenv global 3.6.3
