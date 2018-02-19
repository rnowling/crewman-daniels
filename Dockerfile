FROM debian:stretch

RUN apt-get update && \
    apt-get -y install \
    	    g++ \
	        gfortran \
	        git \
	        libfreetype6 \
    	    libfreetype6-dev \
	        libpng-dev \
    	    pkg-config \
    	    python-dev \
	        python-numpy \
    	    python-pip \
	        python-scipy \
            python-seaborn \
            cython \
            make \
            curl \
	    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install git lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get update && \
    apt-get -y install git-lfs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/sstephenson/bats.git
WORKDIR /opt/bats
RUN ./install.sh /usr/local

# workaround pip trying to install everything at once
# instead of in-order and failing
RUN pip install mdtraj
    
COPY . /opt/crewman-daniels
WORKDIR /opt/crewman-daniels
RUN pip install --requirement /opt/crewman-daniels/requirements.txt
ENV PATH="/opt/crewman-daniels/bin:${PATH}"

CMD /bin/bash
