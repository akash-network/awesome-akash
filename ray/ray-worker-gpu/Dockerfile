FROM  rayproject/ray-ml:nightly-gpu
EXPOSE 6380
EXPOSE 8265
COPY /startworker.py .
RUN sudo chmod 777 /home/ray/startworker.py
RUN sudo chmod a+x /home/ray/startworker.py

RUN sudo chown ray /home/ray/startworker.py
RUN sudo chmod 777 /home/ray

RUN ls -lia /home/ray
ENTRYPOINT [ "python3" ]
# CMD [ "ray", "start", "--port=6380", "--dashboard-port=8265", "--dashboard-host=0.0.0.0", "--object-manager-port=8076", "--node-manager-port=8077", "--dashboard-agent-grpc-port=8078" , "--dashboard-agent-listen-port=8079", "--min-worker-port=10002" , "--max-worker-port=10005", "--block" ]
CMD ["/home/ray/startworker.py"]