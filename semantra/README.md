# Semantra

Deployment video: https://www.youtube.com/watch?v=LfoPUIn-Eug

Project page: https://github.com/freedmand/semantra

Semantra is a multipurpose tool for semantically searching documents. Query by meaning rather than just by matching text.

The tool, made to run on the command line, analyzes specified text and PDF files on your computer and launches a local web search application for interactively querying them. The purpose of Semantra is to make running a specialized semantic search engine easy, friendly, configurable, and private/secure.

Semantra is built for individuals seeking needles in haystacks — journalists sifting through leaked documents on deadline, researchers seeking insights within papers, students engaging with literature by querying themes, historians connecting events across books, and so forth.


## Getting started

Deploy and click the URI in Akash Console.

## Models

Currently the following models are supported:

- Muennighoff/SGPT-1.3B-weightedmean-msmarco-specb-bitfit
- Muennighoff/SGPT-2.7B-weightedmean-msmarco-specb-bitfit
- Muennighoff/SGPT-5.8B-weightedmean-msmarco-specb-bitfit

### :warning: A note on _memory usage_

Semantra will crash if you don't have enough available memory for your model.

- 1.3B requires about 20GB of free RAM
- 2.7B requires about 30GB free
- 5.8B requires about 40GB free

If you are analyzing a large file or multiple files, you may need more ram.

