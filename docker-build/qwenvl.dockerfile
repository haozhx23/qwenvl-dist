# FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-training:2.6.0-gpu-py312-cu126-ubuntu22.04-ec2
FROM 633205212955.dkr.ecr.us-east-1.amazonaws.com/nvcr-2409-sm

RUN pip install python-etcd 
# RUN apt update && apt install -y nvtop


RUN pip uninstall flash-attn -y
RUN pip install flash-attn --no-build-isolation
RUN pip install deepspeed==0.15.4
RUN pip install datasets==2.19.2
RUN pip install peft==0.10.0
RUN pip install torchvision
RUN pip install qwen-vl-utils
RUN pip install git+https://github.com/huggingface/transformers.git@9d2056f12b66e64978f78a2dcb023f65b2be2108
RUN pip install ujson
RUN pip install liger-kernel


# RUN pip install transformers==4.46.1 datasets fsspec==2023.9.2 python-etcd numpy==1.*
# RUN pip install torch==2.5.1+cu121 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121


# RUN mkdir /trainllamafacoty
# RUN pip install transformers datasets fsspec==2023.9.2 python-etcd numpy==1.*
# RUN git clone --depth 1 https://github.com/hiyouga/LLaMA-Factory.git
# RUN cd LLaMA-Factory && pip install -e ".[torch,metrics]"
# RUN cd /trainllamafacoty


# RUN mkdir /checkpoints

# RUN mkdir /fsdp

# RUN ln -s /usr/bin/python3 /usr/bin/python

# COPY ./train.py /fsdp/train.py

# COPY /model_utils /fsdp/model_utils

# WORKDIR /workspace