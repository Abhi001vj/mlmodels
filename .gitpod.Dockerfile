FROM gitpod/workspace-full:latest

USER root
RUN apt-get update && apt-get install -y \
  cloc graphviz \
  && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
  
USER gitpod
RUN wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
RUN bash Anaconda3-5.0.1-Linux-x86_64.sh -b
RUN rm Anaconda3-5.0.1-Linux-x86_64.sh
ENV PATH=$PATH:$HOME/anaconda3
ENV PATH=$PATH:$HOME/anaconda3/bin
RUN conda install conda
RUN conda init
RUN ["/bin/bash", "-c", ". /home/gitpod/anaconda3/etc/profile.d/conda.sh && conda activate base && pip install simplejson radon"]
RUN ["/bin/bash", "-c", ". /home/gitpod/anaconda3/etc/profile.d/conda.sh && conda activate base && conda install -c conda-forge pygit2"]
RUN echo "conda activate base" > ~/.bashrc
ENV jupynb="jupyter notebook --NotebookApp.allow_origin=\'$(gp url 8888)\' --ip='*' --NotebookApp.token='' --NotebookApp.password=''"



RUN ["/bin/bash", "-c", ". /home/gitpod/anaconda3/etc/profile.d/conda.sh && conda create -n py36 python=3.6.5 -y "]
RUN ["/bin/bash", "-c", ". /home/gitpod/anaconda3/etc/profile.d/conda.sh && conda activate py36  &&  pip install torch==1.2.0 tensorflow==1.15.2 keras<2.4.0 numpy optuna<1.2.0 pandas<1.0 scipy>=1.3.0 scikit-learn==0.21.2 numexpr>=2.6.8 sqlalchemy<=1.3.13 boto3==1.9.187 toml setuptools==45.2.0 python-dateutil==2.8.0 "] 



USER root
