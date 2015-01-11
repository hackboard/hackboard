FROM ubuntu:trusty
MAINTAINER a60814billy@gmail.com

RUN apt-get update

RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common

RUN apt-get upgrade -y
RUN apt-get install -y bash-completion
# install git
RUN apt-get install -y git
# install vim
RUN apt-get install -y vim
# install unzip
RUN apt-get install -y unzip
# setting custom vim config
RUN git clone https://github.com/a60814billy/raccoon-vim-config.git
RUN cd raccoon-vim-config && git submodule init && git submodule update
ADD ./File/vim-l9.zip /vim-l9.zip
RUN unzip vim-l9.zip -d vim-l9
RUN cp -R vim-l9/* /usr/share/vim/vim74/
RUN rm -rf vim-l9
RUN rm vim-l9.zip
RUN ln -s /raccoon-vim-config/.vimrc /root/.vimrc
RUN ln -s /raccoon-vim-config/.vim /root/.vim
RUN /root/.vim/bundle/neobundle.vim/bin/neoinstall

# install zh-tw language pack
RUN echo 'export LANG="zh_TW.UTF-8"' >> /root/.bashrc
RUN apt-get install -y language-pack-zh-hant

# install redis-server
RUN apt-add-repository ppa:chris-lea/redis-server
RUN apt-get update
RUN apt-get install -y redis-server
ADD ./File/redis.conf /etc/redis/redis.conf

# install node.js
RUN apt-get install python-software-properties
RUN apt-add-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

# copy realtime server file
COPY File/real-time-server/ /real-time-server/

# run npm install 
RUN cd /real-time-server/ && npm install

# add startup file
ADD ./File/start.sh /root/start.sh

# set start cmd
CMD ["/bin/bash" , "/root/start.sh"]

# expose port
EXPOSE 6379 33555

