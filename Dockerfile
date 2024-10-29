FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    git \
    openjdk-11-jdk \
    software-properties-common \
    netcat-traditional \
    build-essential \
    && apt-get clean

RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import && \
    chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -    

RUN yes | add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update && apt-get install -y sbt=1.5.5 nodejs python3.9 python3.9-venv && apt-get clean

RUN npm install -g yarn@1.22.22

RUN git clone https://github.com/Texera/Udon

RUN cd Udon/core/new-gui && yarn install

RUN cd Udon/core/new-gui && python3.9 -m venv /venv

ENV PATH="/venv/bin:$PATH"

RUN sed -i "s|path = \"\"|path = \"$(which python3.9)\"|" /Udon/core/amber/src/main/resources/python_udf.conf

RUN cd Udon && pip install -r core/amber/requirements.txt

RUN pip install nltk spacy~=3.2.6
#RUN pip install --upgrade numpy
RUN pip install --upgrade spacy
RUN python -m spacy download en_core_web_sm
RUN pip install Pillow

RUN sed -i '1s/^/#!\/bin\/bash\n/' /Udon/core//scripts/deploy-daemon.sh
RUN npm install -g @angular/cli

WORKDIR /Udon/core/scripts

#ENTRYPOINT ["./deploy-daemon.sh"]
CMD ["tail", "-f", "/dev/null"]
