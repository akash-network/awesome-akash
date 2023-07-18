## What is Weaviate?

Weaviate is an open source vector database that stores both objects and vectors. This allows for combining vector search with structured filtering.

Weaviate in a nutshell:

    Weaviate is an open source vector database.
    Weaviate allows you to store and retrieve data objects based on their semantic properties by indexing them with vectors.
    Weaviate can be used stand-alone (aka bring your vectors) or with a variety of modules that can do the vectorization for you and extend the core capabilities.
    Weaviate has a GraphQL-API to access your data easily.
    Weaviate is fast (check our open source benchmarks).

Weaviate in detail: Weaviate is a low-latency vector database with out-of-the-box support for different media types (text, images, etc.). It offers Semantic Search, Question-Answer Extraction, Classification, Customizable Models (PyTorch/TensorFlow/Keras), etc. Built from scratch in Go, Weaviate stores both objects and vectors, allowing for combining vector search with structured filtering and the fault tolerance of a cloud-native database. It is all accessible through GraphQL, REST, and various client-side programming languages.
Weaviate helps

    Software Engineers - Who use Weaviate as an ML-first database for their applications.
        Out-of-the-box modules for NLP / semantic search, automatic classification, and image similarity search.
        Easy to integrate with the current architecture, with full CRUD support like other OSS databases.
        Cloud-native, distributed, runs well on Kubernetes, and scales with one's workloads.

    Data Engineers - Who use Weaviate as a vector database that is built up from the ground with ANN at its core and with the same UX they love from Lucene-based search engines.
        Weaviate has a modular setup that allows you to use your ML models inside Weaviate. Due to its flexibility, you can also use out-of-the-box ML models (e.g., SBERT, ResNet, fasttext, etc.).
        Weaviate takes care of the scalability so that you don't have to.
        Deploy and maintain ML models in production reliably and efficiently.

    Data Scientists - Who use Weaviate for a seamless handover of their Machine Learning models to MLOps.
        Deploy and maintain your ML models in production reliably and efficiently.
        Weaviate's modular design allows you to package any custom-trained model you want easily.
        Smooth and accelerated handover of your Machine Learning models to engineers.

## Features

Weaviate makes it easy to use state-of-the-art AI models while providing the scalability, ease of use, safety and cost-effectiveness of a purpose-built vector database. Most notably:

    Fast queries
    Weaviate typically performs nearest neighbor (NN) searches of millions of objects in considerably less than 100ms. You can find more information on our benchmark page.

    Ingest any media type with Weaviate Modules
    Use State-of-the-Art AI model inference (e.g., Transformers) for accessing data (text, images, etc.) at search-and-query time to let Weaviate manage the process of vectorizing data for you - or provide your own vectors.

    Combine vector and scalar search
    Weaviate allows for efficient, combined vector and scalar searches. For example, "articles related to the COVID-19 pandemic published within the past 7 days." Weaviate stores both objects and vectors and ensures the retrieval of both is always efficient. There is no need for a third-party object storage.

    Real-time and persistent
    Weaviate lets you search through your data even if it's currently being imported or updated. In addition, every write is written to a Write-Ahead-Log (WAL) for immediately persisted writes - even when a crash occurs.

    Horizontal Scalability
    Scale Weaviate for your exact needs, e.g., maximum ingestion, largest possible dataset size, maximum queries per second, etc.

    High-Availability
    Is on our roadmap and will be released later this year.

    Cost-Effectiveness
    Very large datasets do not need to be kept entirely in-memory in Weaviate. At the same time, available memory can be used to increase the speed of queries. This allows for a conscious speed/cost trade-off to suit every use case.

    Graph-like connections between objects
    Make arbitrary connections between your objects in a graph-like fashion to resemble real-life connections between your data points. Traverse those connections using GraphQL.

## How does Weaviate work?

Within Weaviate, all individual data objects are based on a class property structure where a vector represents each data object. You can connect data objects (like in a traditional graph) and search for data objects in the vector space.

You can add data to Weaviate through the RESTful API end-points and retrieve data through the GraphQL interface.

Weaviate's vector indexing mechanism is modular, and the current available plugin is the Hierarchical Navigable Small World (HNSW) multilayered graph.
What are Weaviate modules?

Weaviate modules are used to extend Weaviate's capabilities and are optional. There are Weaviate modules that automatically vectorize your content (i.e., *2vec) or extend Weaviate's capabilities (often related to the type of vectors you have.) You can also create your own modules. Click here to learn more about them.
What is a vector database?

If you work with data, you probably work with search engine technology. The best search engines are amazing pieces of software, but because of their core architecture, they come with limitations when it comes to finding the data you are looking for.

Take for example the data object: { "data": "The Eiffel Tower is a wrought iron lattice tower on the Champ de Mars in Paris." }

Storing this in a traditional search engine might leverage inverted indices to index the data. This means that to retrieve the data, you need to search for "Eiffel Tower", "wrought iron lattice", or other exact phrases, to find it. But what if you have vast amounts of data, and you want the document about the Eiffel Tower, but you search for "landmarks in France"? Traditional search engines can't help you there, so this is where vector databases show their superiority.

Weaviate uses vector indexing mechanisms at its core to represent the data. The vectorization modules (e.g., the NLP module) vectorize the above-mentioned data object in a vector-space where the data object sits near the text "landmarks in France". This means that Weaviate can't find a 100% match, but it will find a very close one, and return the result.

The above example is for text (i.e., NLP), but you can use vector search for any machine learning model that vectorizes, like images, audio, video, genes, etc.
When should I use Weaviate?

There are four main situations when you should consider using Weaviate.

    If you don't like the quality of results that your current search engine gives you. (With Weaviate you can search through your data semantically.)
    If you want to do textual and image similarity search with out-of-the-box state-of-the-art ML models. (Combine storing and querying of multiple media types in one Weaviate instance.)
    If you want to combine semantic (vector) and scalar search with a vector database taking milliseconds. (Weaviate stores both your objects and vectors and makes sure the retrieval of both is always efficient).
    If you need to scale your own machine learning models to production size. (HNSW algorithm and horizontally scalable support near-realtime database operations)
    If you need to classify large datasets fast and near-realtime. (kNN, zero-shot or contextual classification with out-of-the-box or custom ML models).

People use Weaviate for cases such as semantic search, image search, similarity search, anomaly detection, power recommendation engines, e-commerce search, data classification in ERP systems, automated data harmonization, cybersecurity threat analysis, and many, many more cases.

## Weaviate with the text2vec-transformers module

An example docker-compose setup file with the transformers model sentence-transformers/multi-qa-MiniLM-L6-cos-v1 is:

```
version: '3.4'
services:
  weaviate:
    image: semitechnologies/weaviate:1.19.4
    restart: on-failure:0
    ports:
     - "8080:8080"
    environment:
      QUERY_DEFAULTS_LIMIT: 20
      AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED: 'true'
      PERSISTENCE_DATA_PATH: "./data"
      DEFAULT_VECTORIZER_MODULE: text2vec-transformers
      ENABLE_MODULES: text2vec-transformers
      TRANSFORMERS_INFERENCE_API: http://t2v-transformers:8080
      CLUSTER_HOSTNAME: 'node1'
  t2v-transformers:
    image: semitechnologies/transformers-inference:sentence-transformers-multi-qa-MiniLM-L6-cos-v1
    environment:
      ENABLE_CUDA: 0 # set to 1 to enable
      # NVIDIA_VISIBLE_DEVICES: all # enable if running with CUDA
```

Note that transformer models are Neural Networks built to run on GPUs. Running Weaviate with the text2vec-transformers module and without GPU is possible, but it will be slower. Enable CUDA if you have a GPU available (ENABLE_CUDA=1).

For more information on how to set up the environment with the text2vec-transformers module, see this page.

The text2vec-transformers module requires at least Weaviate version v1.2.0.

Weaviate without any modules

An example docker-compose setup for Weaviate without any modules can be found below. In this case, no model inference is performed at either import or search time. You will need to provide your own vectors (e.g. from an outside ML model) at import and search time:

```
version: '3.4'
services:
  weaviate:
    image: semitechnologies/weaviate:1.19.4
    ports:
    - 8080:8080
    restart: on-failure:0
    environment:
      QUERY_DEFAULTS_LIMIT: 25
      AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED: 'true'
      PERSISTENCE_DATA_PATH: '/var/lib/weaviate'
      DEFAULT_VECTORIZER_MODULE: 'none'
      CLUSTER_HOSTNAME: 'node1'
```

