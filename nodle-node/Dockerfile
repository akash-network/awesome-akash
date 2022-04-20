FROM ubuntu
ENV PROFILE=release
ENV MODE=release
ENV NAME="akash.network"
ENV CHAIN=eden
ENV PRUNING=
ENV STARTUP="--rpc-external --ws-external --rpc-cors all --wasm-execution compiled"

COPY ./run.sh /
EXPOSE 30333 9933 9944

ENTRYPOINT ["./run.sh"]
