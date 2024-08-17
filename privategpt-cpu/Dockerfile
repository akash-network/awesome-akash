######################################
#SAVE THIS FILE AS Dockerfile and EXECUTE:
#docker build -t privategpt .
#Related YT video - https://www.youtube.com/watch?v=Ib3nQu5bB_k
#####################################
# Use the specified Python base image
FROM python:3.11-slim
# Set the working directory in the container
WORKDIR /app
# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential
# Clone the private repository
RUN git clone https://github.com/imartinez/privateGPT
WORKDIR /app/privateGPT
# Install poetry
RUN pip install poetry
# Install poetry

# Copy the project files into the container
COPY . /app
#Adding openai pre v1 to avoid error
#RUN sed -i '/\[tool\.poetry\.dependencies\]/a openai="0.28.1"' pyproject.toml

# Lock and install dependencies using poetry
#RUN poetry lock
RUN poetry install

# Install dependencies
#RUN poetry config virtualenvs.create false \
#    && poetry install --no-interaction --no-ansi

# Run setup script
#RUN poetry run python scripts/setup # download models
# Keep the container running
#CMD ["tail", "-f", "/dev/null"]


CMD poetry run python scripts/setup \
    && poetry install --extras "vector-stores-qdrant" && poetry run make run \
    && tail -f /dev/null
