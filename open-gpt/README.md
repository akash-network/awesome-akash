## OPENGPT on Akash Network

---

OpenGPT is an open source effort to create a similar experience to OpenAI's GPTs. It builds upon LangChain, LangServe and LangSmith. OpenGPTs gives you more control, allowing you to configure:

The LLM you use (choose between the 60+ that LangChain offers)
The prompts you use (use LangSmith to debug those)
The tools you give it (choose from LangChain's 100+ tools, or easily write your own)
The vector database you use (choose from LangChain's 60+ vector database integrations)
The retrieval algorithm you use
The chat history database you use

for more details on OpenGPT - https://github.com/langchain-ai/opengpts/tree/main

Set up language models

By default, this uses OpenAI, but there are also options for Azure OpenAI and Anthropic. If you are using those, you may need to set different environment variables.

For OpenAI, you need openai paid api access. Enable billing in platform.openai.com and add some balance to perform tasks throught GPT turbo 3.5 or GPT 4.

OPENAI_API_KEY=

Other language models can be used, and in order to use them you will need to set more environment variables. See the section below on LLMs for how to configure Azure OpenAI, Anthropic, and Amazon Bedrock.

Set up tools By default this uses a lot of tools. Some of these require additional environment variables. You do not need to use any of these tools, and the environment variables are not required to spin up the app (they are only required if that tool is called).

      - YDC_API_KEY=test
      - TAVILY_API_KEY=test
      - KAY_API_KEY=test

