FROM nvidia/cuda:11.8.0-devel-ubuntu20.04
#FROM cryptoandcoffee/nvidia-docker-cuda-11-base

ENV DEBIAN_FRONTEND=noninteractive

#WORKDIR /root

# Install necessary tools and clean up
RUN apt update && \
    apt -y install msr-tools kmod psmisc numactl libbz2-dev wget jq curl xz-utils nvidia-opencl-dev libhwloc-dev libuv1-dev libssl-dev git build-essential cmake automake libtool autoconf bc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone and build xmrig-cuda
RUN git clone https://github.com/xmrig/xmrig-cuda.git && \
    mkdir xmrig-cuda/build && cd xmrig-cuda/build && \
    cmake .. -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda && \
    make -j$(nproc)

# Copy the CUDA plugin to the expected location
#RUN cp xmrig-cuda/build/libxmrig-cuda.so /usr/local/bin/

COPY run.sh /

ENV WALLET=4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K
ENV MEMORY_SIZE=1Gi
ENV AKASH_CLUSTER_PUBLIC_HOSTNAME=akash
ENV WORKER=akash
ENV GB_PAGES=false
ENV HUGE_PAGES=false
ENV MODE=light
ENV BENCH_TIME=10
ENTRYPOINT ["./run.sh"]
