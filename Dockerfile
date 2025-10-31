FROM continuumio/miniconda3:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install git gcc g++ && \
    rm -rf /var/lib/apt/lists/*

COPY environment.yml .

RUN conda env create -f environment.yml && \
    conda clean --all -afy

ARG CACHEBUST
RUN cd /home && \ 
    git clone https://github.com/Jacks0n36/mlipenv

ENV PATH=/opt/conda/bin:$PATH
ENV MLIP_SOCKET_PORT=27182
ENV CALCULATOR=aimnet

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "aimnet", "python", "/home/mlipenv/mlip_server.py"]
