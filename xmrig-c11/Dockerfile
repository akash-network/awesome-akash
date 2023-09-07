# Use NVIDIA CUDA base image
FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV POOL=pool.hashvault.pro:443
ENV WALLET=
ENV PASS=x
ENV WORKER=akash
ENV TLS=true
ENV TLS_FINGERPRINT=420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14
ENV ALGO=rx/0
ENV DONATE_LEVEL=0
ENV RANDOMX_MODE=
ENV CUSTOM_OPTIONS=

# Install system dependencies
RUN apt update && \
    apt -y install \
        msr-tools \
        kmod \
        psmisc \
        numactl \
        libbz2-dev \
        wget \
        jq \
        curl \
        xz-utils \
        nvidia-opencl-dev \
        libhwloc-dev \
        libuv1-dev \
        libssl-dev \
        git \
        build-essential \
        cmake \
        automake \
        libtool \
        autoconf \
        bc \
        util-linux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone, build and install XMRig
RUN git clone https://github.com/xmrig/xmrig && \
    cd xmrig && \
    sed -i 's/constexpr const int kDefaultDonateLevel = 1;/constexpr const int kDefaultDonateLevel = 0;/g' src/donate.h && \
    sed -i 's/constexpr const int kMinimumDonateLevel = 1;/constexpr const int kMinimumDonateLevel = 0;/g' src/donate.h && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j$(nproc)

# Clone, build and install XMRig-CUDA
RUN git clone https://github.com/xmrig/xmrig-cuda.git && \
    cd xmrig-cuda && \
    mkdir build && \
    cd build && \
    cmake .. \
        -DCUDA_LIB=/usr/local/cuda/lib64/stubs/libcuda.so \
        -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda && \
    make -j$(nproc)

# Copy run script
COPY ./run.sh /xmrig/

# Set execute permissions
RUN chmod +x /xmrig/run.sh

# Move libxmrig-cuda and xmrig to /xmrig
RUN cp /xmrig-cuda/build/libxmrig-cuda.so /xmrig/
RUN mv /xmrig/build/xmrig /xmrig/


# Command to run
ENTRYPOINT ["/xmrig/run.sh"]
