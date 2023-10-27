# Dockerfile for variant-calling

# start with Ubuntu
FROM ubuntu

# install dependencies
RUN apt-get update && apt-get install -y \
  wget \
  nano

# install packages
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN mkdir /root/miniconda3
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -u -p /root/miniconda3
RUN /root/miniconda3/bin/conda init bash
RUN rm Miniconda3-latest-Linux-x86_64.sh

RUN /root/miniconda3/bin/conda install -c bioconda fastqc -y
RUN /root/miniconda3/bin/conda install -c bioconda trimmomatic -y
RUN /root/miniconda3/bin/conda install -c bioconda bwa -y
#RUN /root/miniconda3/bin/conda install -c bioconda samtools -y
#RUN /root/miniconda3/bin/conda install -c bioconda bcftools -y

# the conda versions of samtools and bcf tools don't work for this version of ubuntu
# as of October 2023
RUN apt-get install -y \
  samtools \
  bcftools

# start with bash
CMD ["/bin/sh", "-c", "exec bash"]
