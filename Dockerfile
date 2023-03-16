
FROM ubuntu

RUN apt update -y
RUN apt upgrade -y

RUN apt-get update && apt-get install -y wget && \
    mkdir /azcopy && cd /azcopy && \
    wget https://aka.ms/downloadazcopy-v10-linux && \
    tar -xvf downloadazcopy-v10-linux && \
    rm downloadazcopy-v10-linux && \
    cp /azcopy/azcopy_linux_amd64*/azcopy /usr/bin/azcopy && \
    chmod 755 /usr/bin/azcopy


COPY *.sh /
RUN chmod +x /*.sh
RUN apt update -y
RUN apt upgrade -y
RUN apt install curl wget -y

ENTRYPOINT ["tail", "-f", "/dev/null"]

