FROM  rayproject/ray-ml:nightly-py310-cu118
EXPOSE 6380
EXPOSE 8265

# RUN pip install  pandas boto3 fastparquet cloudpathlib[s3] diffusers[torch]==0.19.3 
COPY /starthead.py .

RUN sudo chmod 777 /home/ray/starthead.py
RUN sudo chmod a+x /home/ray/starthead.py
RUN sudo chown ray /home/ray/starthead.py
RUN sudo chmod 777 /home/ray
ENTRYPOINT [ "python3" ]
CMD ["/home/ray/starthead.py"]
