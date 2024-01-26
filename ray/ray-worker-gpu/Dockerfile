FROM  rayproject/ray-ml:nightly-py310-cu118
EXPOSE 6380
EXPOSE 8265
RUN sudo apt-get install git-lfs s3fs -y
RUN git lfs install --skip-repo
RUN pip install s3fs
COPY /startworker.py .
RUN sudo chmod 777 /home/ray/startworker.py
RUN sudo chmod a+x /home/ray/startworker.py
RUN sudo chown ray /home/ray/startworker.py
RUN sudo chmod 777 /home/ray
ENTRYPOINT [ "python3" ]
CMD ["/home/ray/startworker.py"]