FROM  rayproject/ray-ml:nightly-py310-cu118
EXPOSE 6380
EXPOSE 8265
RUN sudo apt-get install git-lfs s3fs -y
RUN git lfs install --skip-repo
RUN pip install s3fs
COPY /starthead.sh .
RUN sudo chmod 777 /home/ray/starthead.sh
RUN sudo chmod a+x /home/ray/starthead.sh
RUN sudo chown ray /home/ray/starthead.sh
RUN sudo chmod 777 /home/ray
# ENTRYPOINT ["bash -c"]
CMD ["/home/ray/starthead.sh"]
