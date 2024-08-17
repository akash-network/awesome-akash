# PrivateGPT

**PrivateGPT is a production-ready AI project that allows you to ask questions about your documents using the power of Large Language Models (LLMs), even in scenarios without an Internet connection. 100% private, no data leaves your execution environment at any point.**

`GitHub` - 3x3cut0r/privategpt - https://github.com/3x3cut0r/docker/tree/main/privategpt  
`DockerHub` - 3x3cut0r/privategpt - https://hub.docker.com/r/3x3cut0r/privategpt

![privategpt](https://github.com/3x3cut0r/docker/assets/1408580/39d4e5ed-4a5c-4ea5-8b78-83a8c4c2df9b)

## Documentation

`GitHub` - zylon-ai/private-gpt - https://github.com/zylon-ai/private-gpt  
`Docs` - docs.privategpt.dev - https://docs.privategpt.dev/

## Index

1. [Usage](#usage)  
   1.1 [docker run](#dockerrun)  
   1.2 [docker-compose.yaml](#docker-compose)  
   1.3 [docker-compose.yaml with custom model](#docker-compose-custom)
2. [Environment Variables](#environment-variables)
3. [Volumes](#volumes)
4. [Ports](#ports)
5. [Find Me](#findme)
6. [License](#license)

## 1 Usage <a name="usage"></a>

### 1.1 docker run <a name="dockerrun"></a>

```shell
docker run -d \
    --name privategpt \
    -p 8080:8080/tcp \
    3x3cut0r/privategpt:latest
```

### 1.2 docker-compose.yml <a name="docker-compose"></a>

```shell
version: '3.9'

services:
  # https://hub.docker.com/r/3x3cut0r/privategpt
  privategpt:
    image: 3x3cut0r/privategpt:latest
    container_name: privategpt
    ports:
      - 8080:8080/tcp
```

### 1.3 docker-compose.yml with custom model <a name="docker-compose-custom"></a>

```shell
version: '3.9'

services:
  # https://hub.docker.com/r/3x3cut0r/privategpt
  privategpt:
    image: 3x3cut0r/privategpt:latest
    container_name: privategpt
    environment:
      LLAMACPP_LLM_HF_REPO_ID: "lmstudio-community/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
      LLAMACPP_LLM_HF_MODEL_FILE: "Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
      HUGGINGFACE_EMBEDDING_HF_MODEL_NAME: "nomic-ai/nomic-embed-text-v1.5"
      EMBEDDING_INGEST_MODE: "parallel"
      EMBEDDING_COUNT_WORKERS: "4"
    volumes:
      - /path/to/your/model/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf:/home/worker/app/models/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf
    ports:
      - 8080:8080/tcp
```

### 2 Environment Variables <a name="environment-variables"></a>

**you can adjust all values inside the [settings.yaml](https://github.com/3x3cut0r/docker/blob/main/privategpt/settings.yaml) with environment variables**

###### Server

- `ENV_NAME` - Name of the environment (prod, staging, local...) - **Default: prod**
- `PORT` - Port of PrivateGPT FastAPI server - **Default: 8080**
- `KEEP_FILES` - Specifies if the server should keep uploaded files after restarting the container (lowercase true or false)- **Default: true**
- `RUN_SETUP` - Set to true, to run poetry setup again. Do it only once to download models and set it to false afterwards - **Default: false**

###### Cors

- `CORS_ENABLED` - Flag indicating if CORS headers are set or not. If set to True, the CORS headers will be set to allow all origins, methods and headers - **Default: false**
- `CORS_ALLOW_CREDENTIALS` - Indicate that cookies should be supported for cross-origin requests - **Default: false**
- `CORS_ALLOW_ORIGINS` - A list of origins that should be permitted to make cross-origin requests - **Default: \***
- `CORS_ALLOW_ORIGIN_REGEX` - A regex string to match against origins that should be permitted to make cross-origin requests - **Default: **
- `CORS_ALLOW_METHODS` - A list of HTTP methods that should be allowed for cross-origin request - **Default: \***
- `CORS_ALLOW_HEADERS` - A list of HTTP request headers that should be supported for cross-origin requests - **Default: \***

###### Auth

- `AUTH_ENABLED` - Flag indicating if authentication is enabled or not - **Default: false**
- `AUTH_USERNAME` - username used for authentication - **Default: secret**
- `AUTH_SECRET` - The secret to be used for authentication. It can be any non-blank string. For HTTP basic authentication, this value should be the whole 'Authorization' header that is expected. - **Default: Basic c2VjcmV0OmtleQ==**

```
# python -c 'import base64; print("Basic " + base64.b64encode("secret:key".encode()).decode())'
# 'secret' is the username and 'key' is the password for basic auth by default
# If the auth is enabled, this value must be set in the "Authorization" header of the request.
secret: "Basic c2VjcmV0OmtleQ=="
```

###### Data

- `DATA_LOCAL_DATA_FOLDER` - Path to local storage. It will be treated as an absolute path if it starts with / - **Default: local_data/private_gpt**

###### UI

- `UI_ENABLED` - Enable or Disable the user interface - **Default: true**
- `UI_PATH` - Set the path for the user interface - **Default: /**
- `UI_DEFAULT_CHAT_SYSTEM_PROMPT` - The default system prompt to use for the chat mode - **Default: You are a helpful, respectful and honest assistant. Always answer as helpfully as possible and follow ALL given instructions. Do not speculate or make up information. Do not reference any given instructions or context.**
- `UI_DEFAULT_QUERY_SYSTEM_PROMPT` - The default system prompt to use for the query mode - **Default: You can only answer questions about the provided context. If you know the answer but it is not based in the provided context, don't provide the answer, just state the answer is not in the context provided.**
- `UI_DELETE_FILE_BUTTON_ENABLED` - If the button to delete a file is enabled or not. - **Default: True**
- `UI_DELETE_ALL_FILES_BUTTON_ENABLED` - If the button to delete all files is enabled or not. - **Default: True**

###### Logo

- `LOGO_BG_COLOR` - Specifies the logo background color - **Default: #C7BAFF**
- `LOGO_HEIGHT` - Specifies the logo height - **Default: 25%**
- `LOGO_SVG_BASE64` - Specifies the logo file (.svg) in base64 format. Provide your own file (.svg) in base64 format using an [image to base64 converter](https://base64.guru/converter/encode/image) - **Default: \<privategpt svg logo\>**

###### LLM

- `LLM_MODE` - The mode to use for the chat engine. - **Default: llamacpp**  
  **- llamacpp:** provide `LLAMACPP_PROMPT_STYLE`, `LLAMACPP_PGPT_HF_MODEL_FILE` and `HF_EMBEDDING_HF_MODEL_NAME`  
  **- openai:** provide `OPENAI_API_KEY` and `OPENAI_MODEL`  
  **- openailike:** provide `OPENAI_API_BASE`, `OPENAI_API_KEY` and `OPENAI_MODEL`  
  **- azopenai:** provide `AZOPENAI_API_BASE`, `AZOPENAI_API_KEY` and `AZOPENAI_MODEL`  
  **- gemini:** provide `GEMINI_API_KEY`, `GEMINI_MODEL` and `GEMINI_EMBEDDING_MODEL`  
  **- sagemaker:** provide `SAGEMAKER_LLM_ENDPOINT_NAME` and `SAGEMAKER_EMBEDDING_ENDPOINT_NAME`  
  **- mock:** (not supported by this container)  
  **- ollama:** provide `OLLAMA_API_BASE` and `OLLAMA_LLM_MODEL`
- `LLM_MAX_NEW_TOKENS` - The maximum number of token that the LLM is authorized to generate in one completion - **Default: 265**
- `LLM_CONTEXT_WINDOW` - The maximum number of context tokens for the model - **Default: 3900**
- `LLM_TOKENIZER` - Specifies the model from Huggingface.co which is used as tokenizer - **Default: meta-llama/Meta-Llama-3.1-8B-Instruct**
- `LLM_TEMPERATURE` - The temperature of the model. Increasing the temperature will make the model answer more creatively. A value of 0.1 would be more factual - **Default: 0.1**

###### Rag Settings

- `RAG_SIMILARITY_TOP_K` - This value controls the number of documents returned by the RAG pipeline - **Default: 2**
- `RAG_SIMILARITY_VALUE` - If set, any documents retrieved from the RAG must meet a certain match score. Acceptable values are between 0 and 1. - **Default: 0.45**
- `RAG_RERANK_ENABLED` - This value controls whether a reranker should be included in the RAG pipeline. - **Default: false**
- `RAG_RERANK_MODEL` - Rerank model to use. Limited to SentenceTransformer cross-encoder models. - **Default: cross-encoder/ms-marco-MiniLM-L-2-v2**
- `RAG_RERANK_TOP_N` - This value controls the number of documents returned by the RAG pipeline. - **Default: 1**

###### Summarize Settings

- `SUMMARIZE_USE_ASYNC` - If set to True, the summarization will be done asynchronously. - **Default: true**

###### llamacpp

- `LLAMACPP_PROMPT_STYLE` - The prompt style to use for the chat engine. - **Default: llama3**  
  **- default:** use the default prompt style from the llama_index. It should look like `role: message`  
  **- llama2:** use the llama2 prompt style from the llama_index. Based on `<s>`, `[INST]` and `<<SYS>>`  
  **- llama3:** use the llama3 prompt style from the llama_index.  
  **- tag:** use the tag prompt style. It should look like `<|role|>: message`  
  **- mistral:** use the mistral prompt style. It should look like `<s>[INST] {System Prompt} [/INST]</s>[INST] { UserInstructions } [/INST]`
  **- chatml**
- `LLAMACPP_LLM_HF_REPO_ID` - Name of the HuggingFace model to use for chat - **Default: lmstudio-community/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf**
- `LLAMACPP_LLM_HF_MODEL_FILE` - Specifies the llm model file. Can be a llm model name from the HuggingFace repo or a local file that you mounted via volume to /home/worker/app/models - **Default: Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf**
- `LLAMACPP_TFS_Z` - Tail free sampling is used to reduce the impact of less probable tokens from the output. A higher value (e.g., 2.0) will reduce the impact more, while a value of 1.0 disables this setting. - **Default: 1.0**
- `LLAMACPP_TOP_K` - Reduces the probability of generating nonsense. A higher value (e.g. 100) will give more diverse answers, while a lower value (e.g. 10) will be more conservative. - **Default: 40**
- `LLAMACPP_TOP_P` - Works together with top-k. A higher value (e.g., 0.95) will lead to more diverse text, while a lower value (e.g., 0.5) will generate more focused and conservative text. (Default: 0.9) - **Default: 0.9**
- `LLAMACPP_REPEAT_PENALTY` - Sets how strongly to penalize repetitions. A higher value (e.g., 1.5) will penalize repetitions more strongly, while a lower value (e.g., 0.9) will be more lenient. - **Default: 1.1**

###### Embedding

- `EMBEDDING_MODE` - The mode to use for the embedding engine. (see MODE) - **Default: huggingface**
  **you can additionally use huggingface**
- `EMBEDDING_INGEST_MODE` - The ingest mode to use for the embedding engine. - **Default: simple**  
  **- simple:** ingest files sequentially and one by one. It is the historic behaviour.  
  **- batch:** if multiple files, parse all the files in parallel, and send them in batch to the embedding model``.  
  **- parallel:** parse the files in parallel using multiple cores, and embedd them in parallel. (fastest mode for local setup)
  **- pipeline:** the Embedding engine is kept as busy as possible
- `EMBEDDING_COUNT_WORKERS` - The number of workers to use for file ingestion. Do not go too high with this number, as it might cause memory issues. (especially in parallel mode). Do not set it higher than your number of threads of your CPU. - **Default: 2**  
  **- for simple mode:** this number has no effect in simple mode.  
  **- for batch mode:** this is the number of workers used to parse the files.  
  **- for parallel mode:** this is the number of workers used to parse the files and embed them.
  **- for pipeline mode:** this is the number of workers that can perform embeddings.
- `EMBEDDING_EMBED_DIM` - The dimension of the embeddings stored in the Postgres database. - **Default: 384**

- **Specify the model used for embedding with `HUGGINGFACE_EMBEDDING_HF_MODEL_NAME`**

###### HuggingFace

- `HUGGINGFACE_EMBEDDING_HF_MODEL_NAME` - Name of the HuggingFace model to use for embeddings - **Default: BAAI/bge-small-en-v1.5**
- `HUGGINGFACE_TOKEN` - Huggingface access token, required to download some models - **Default: None**
- `HUGGINGFACE_TRUST_REMOTE_CODE` - If set to True, the code from the remote model will be trusted and executed. - **Default: true**

###### Vectorstore

- `VECTORSTORE_DATABASE` - Specifies the vectorstore database being used. - **select one of: chroma, qdrant, postgres .Default: qdrant**

###### Nodestore

- `NODESTORE_DATABASE` - Specifies the nodestore database being used. - **select one of: simple, postgres .Default: simple**

###### qdrant

- `QDRANT_PATH` - Persistence path for QdrantLocal - **Default: local_data/private_gpt/qdrant**

###### milvus

- `MILVUS_URI` - The URI of the Milvus instance. For example: 'local_data/private_gpt/milvus/milvus_local.db' for Milvus Lite. - **Default: local_data/private_gpt/milvus/milvus_local.db**
- `MILVUS_TOKEN` - A valid access token to access the specified Milvus instance. This can be used as a recommended alternative to setting user and password separately. - **Default: milvus-1234**
- `MILVUS_COLLECTION_NAME` - The name of the collection in Milvus. Default is 'make_this_parameterizable_per_api_call'. - **Default: milvus_db**
- `MILVUS_OVERWRITE` - Overwrite the previous collection schema if it exists. - **Default: false**

###### Clickhouse

- `CLICKHOUSE_HOST` - The server hosting the ClickHouse database - **Default: localhost**
- `CLICKHOUSE_PORT` - The port on which the ClickHouse database is accessible - **Default: 8443**
- `CLICKHOUSE_USERNAME` - The username to use to connect to the ClickHouse database - **Default: admin**
- `CLICKHOUSE_PASSWORD` - The password to use to connect to the ClickHouse database - **Default: clickhouse**
- `CLICKHOUSE_DATABASE` - The default database to use for connections - **Default: embeddings**
- `CLICKHOUSE_SECURE` - Use https/TLS for secure connection to the server - **Default: False**
- `CLICKHOUSE_INTERFACE` - Must be either 'http' or 'https'. Determines the protocol to use for the connection - **Default:**
- `CLICKHOUSE_SETTINGS` - Specific ClickHouse server settings to be used with the session - **Default:**
- `CLICKHOUSE_CONNECT_TIMEOUT` - Timeout in seconds for establishing a connection - **Default:**
- `CLICKHOUSE_SEND_RECEIVE_TIMEOUT` - Read timeout in seconds for http connection - **Default:**
- `CLICKHOUSE_VERIFY` - Verify the server certificate in secure/https mode - **Default:**
- `CLICKHOUSE_CA_CERT` - Path to Certificate Authority root certificate (.pem format) - **Default:**
- `CLICKHOUSE_CLIENT_CERT` - Path to TLS Client certificate (.pem format) - **Default:**
- `CLICKHOUSE_CLIENT_CERT_KEY` - Path to the private key for the TLS Client certificate - **Default:**
- `CLICKHOUSE_HTTP_PROXY` - HTTP proxy address - **Default:**
- `CLICKHOUSE_HTTPS_PROXY` - HTTPS proxy address - **Default:**
- `CLICKHOUSE_SERVER_HOST_NAME` - Server host name to be checked against the TLS certificate - **Default:**

###### Postgres

- `POSTGRES_HOST` - the postgres host address - **Default: postgres**
- `POSTGRES_PORT` - the postgres port - **Default: 5432**
- `POSTGRES_DATABASE` - the postgres database name - **Default: postgres**
- `POSTGRES_USER` - the postgres username - **Default: postgres**
- `POSTGRES_PASSWORD` - the postgres usernames password - **Default: admin**
- `POSTGRES_SCHEMA_NAME` - the postgres schema name - **Default: private_gpt**

###### Sagemaker

- `SAGEMAKER_LLM_ENDPOINT_NAME` - **Default: huggingface-pytorch-tgi-inference-2023-09-25-19-53-32-140**
- `SAGEMAKER_EMBEDDING_ENDPOINT_NAME` - **Default: huggingface-pytorch-inference-2023-11-03-07-41-36-479**

###### OpenAI

- `OPENAI_API_BASE` - Base URL of OpenAI API. Example: https://api.openai.com/v1 - **Default: https://api.openai.com/v1**
- `OPENAI_API_KEY` - Your API Key for the OpenAI API. Example: sk-1234 - **Default: sk-1234**
- `OPENAI_MODEL` - OpenAI Model to use. (see [OpenAI Models Overview](https://platform.openai.com/docs/models/overview)). Example: gpt-4 - **Default: gpt-3.5-turbo**
- `OPENAI_REQUEST_TIMEOUT` - Time elapsed until openailike server times out the request. Default is 120s. Format is float. - **Default: 120.0**
- `OPENAI_EMBEDDING_API_BASE` - Base URL of OpenAI API. Example: https://api.openai.com/v1 - **Default: same as OPENAI_API_BASE**
- `OPENAI_EMBEDDING_API_KEY` - Your API Key for the OpenAI Embedding API. Example: sk-1234. - **Default: same as OPENAI_API_KEY**
- `OPENAI_EMBEDDING_MODEL` - OpenAI embedding Model to use. Example: text-embedding-3-large - **Default: text-embedding-3-small**

###### Gemini

- `GEMINI_API_KEY` - Your Google API Key for the Gemini API. Example: AI1234 - **Default: AI1234**
- `GEMINI_MODEL` - Google Model to use. Example: models/gemini-pro - **Default: models/gemini-pro**
- `GEMINI_EMBEDDING_MODEL` - Google Embedding Model to use. Example: models/embedding-001 - **Default: models/embedding-001**

###### Ollama

- `OLLAMA_API_BASE` - Base URL of Ollama API. Example: http://192.168.1.100:11434 - **Default: http://localhost:11434**
- `OLLAMA_EMBEDDING_API_BASE` - Base URL of Ollama Embedding API. Example: http://192.168.1.100:11434 - **Default: same as OLLAMA_API_BASE**
- `OLLAMA_LLM_MODEL` - Ollama model to use. (see [Ollama Library](https://ollama.com/library)). Example: 'llama2-uncensored' - **Default: llama3.1:latest**
- `OLLAMA_EMBEDDING_MODEL` - Model to use. Example: 'nomic-embed-text'. - **Default: nomic-embed-text**
- `OLLAMA_KEEP_ALIVE` - Time the model will stay loaded in memory after a request. examples: 5m, 5h, '-1' - **Default: 5m**
- `OLLAMA_TFS_Z` - Tail free sampling is used to reduce the impact of less probable tokens from the output. A higher value (e.g., 2.0) will reduce the impact more, while a value of 1.0 disables this setting. - **Default: 1.0**
- `OLLAMA_NUM_PREDICT` - Maximum number of tokens to predict when generating text. (Default: 128, -1 = infinite generation, -2 = fill context) - **Default: 128**
- `OLLAMA_TOP_K` - Reduces the probability of generating nonsense. A higher value (e.g. 100) will give more diverse answers, while a lower value (e.g. 10) will be more conservative. - **Default: 40**
- `OLLAMA_TOP_P` - Works together with top-k. A higher value (e.g., 0.95) will lead to more diverse text, while a lower value (e.g., 0.5) will generate more focused and conservative text. - **Default: 0.9**
- `OLLAMA_REPEAT_LAST_N` - Sets how far back for the model to look back to prevent repetition. (Default: 64, 0 = disabled, -1 = num_ctx) - **Default: 64**
- `OLLAMA_REPEAT_PENALTY` - Sets how strongly to penalize repetitions. A higher value (e.g., 1.5) will penalize repetitions more strongly, while a lower value (e.g., 0.9) will be more lenient. - **Default: 1.1**
- `OLLAMA_REQUEST_TIMEOUT` - Time elapsed until ollama times out the request. Default is 120s. Format is float. - **Default: 120.0**

###### Azure OpenAI

- `AZOPENAI_API_KEY` - Your API Key for the OpenAI API. Example: sk-1234 - **Default: sk-1234**
- `AZOPENAI_ENDPOINT` - Base URL of Azure OpenAI Endpoint. Example: https://api.myazure.com/v1 - **Default: https://api.myazure.com/v1**
- `AZOPENAI_API_VERSION` - The API version to use for this operation. This follows the YYYY-MM-DD format. - **Default: 2023_05_15**
- `AZOPENAI_EMBEDDING_DEPLOYMENT_NAME` - embedding deployment name in str format - **Default: None**
- `AZOPENAI_EMBEDDING_MODEL` - OpenAI Model to use. Example: 'text-embedding-ada-002'. - **Default: text-embedding-3-small**
- `AZOPENAI_LLM_DEPLOYMENT_NAME` - llm deployment name in str format - **Default: None**
- `AZOPENAI_LLM_MODEL` - OpenAI Model to use. (see [OpenAI Models Overview](https://platform.openai.com/docs/models/overview)). Example: gpt-4 - **Default: gpt-4**

### 3 Volumes <a name="volumes"></a>

- `/home/worker/app/local_data` - Directory for uploaded files. contains private data! Will be deleted after every restart if `KEEP_FILES=false`
- `/home/worker/app/models` - Directory for custom llm models. Mount your own model here and set environment variable `LLAMACPP_LLM_HF_MODEL_FILE`

### 4 Ports <a name="ports"></a>

- `8080/tcp` - HTTP Port

### 5 Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-julianreith%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### 6 License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
``
