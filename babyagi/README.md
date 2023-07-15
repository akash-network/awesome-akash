# babyagi Objective

This Python script is an example of an AI-powered task management system. The system uses OpenAI and vector databases such as Chroma or Weaviate to create, prioritize, and execute tasks. The main idea behind this system is that it creates tasks based on the result of previous tasks and a predefined objective. The script then uses OpenAI's natural language processing (NLP) capabilities to create new tasks based on the objective, and Chroma/Weaviate to store and retrieve task results for context. This is a pared-down version of the original [Task-Driven Autonomous Agent](https://twitter.com/yoheinakajima/status/1640934493489070080?s=20) (Mar 28, 2023).

This README will cover the following:

- [How the script works](#how-it-works)

- [How to use the script](#how-to-use)

- [Supported Models](#supported-models)

- [Warning about running the script continuously](#continous-script-warning)

# How It Works

The script works by running an infinite loop that does the following steps:

1. Pulls the first task from the task list.
2. Sends the task to the execution agent, which uses OpenAI's API to complete the task based on the context.
3. Enriches the result and stores it in [Chroma](https://docs.trychroma.com)/[Weaviate](https://weaviate.io/).
4. Creates new tasks and reprioritizes the task list based on the objective and the result of the previous task.

![image](https://user-images.githubusercontent.com/21254008/235015461-543a897f-70cc-4b63-941a-2ae3c9172b11.png)

The `execution_agent()` function is where the OpenAI API is used. It takes two parameters: the objective and the task. It then sends a prompt to OpenAI's API, which returns the result of the task. The prompt consists of a description of the AI system's task, the objective, and the task itself. The result is then returned as a string.

The `task_creation_agent()` function is where OpenAI's API is used to create new tasks based on the objective and the result of the previous task. The function takes four parameters: the objective, the result of the previous task, the task description, and the current task list. It then sends a prompt to OpenAI's API, which returns a list of new tasks as strings. The function then returns the new tasks as a list of dictionaries, where each dictionary contains the name of the task.

The `prioritization_agent()` function is where OpenAI's API is used to reprioritize the task list. The function takes one parameter, the ID of the current task. It sends a prompt to OpenAI's API, which returns the reprioritized task list as a numbered list.

Finally, the script uses Chroma/Weaviate to store and retrieve task results for context. The script creates a Chroma/Weaviate collection based on the table name specified in the TABLE_NAME variable. Chroma/Weaviate is then used to store the results of the task in the collection, along with the task name and any additional metadata.


# Supported Models

This script works with all OpenAI models, as well as Llama and its variations through Llama.cpp. Default model is **gpt-3.5-turbo**. To use a different model, specify it through LLM_MODEL or use the command line.

## Llama

Llama integration requires llama-cpp package. You will also need the Llama model weights.

- **Under no circumstances share IPFS, magnet links, or any other links to model downloads anywhere in this repository, including in issues, discussions or pull requests. They will be immediately deleted.**

Once you have them, set LLAMA_MODEL_PATH to the path of the specific model to use. For convenience, you can link `models` in BabyAGI repo to the folder where you have the Llama model weights. Then run the script with `LLM_MODEL=llama` or `-l` argument.

# Warning

This script is designed to be run continuously as part of a task management system. Running this script continuously can result in high API usage, so please use it responsibly. Additionally, the script requires the OpenAI API to be set up correctly, so make sure you have set up the API before running the script.

# Contribution

Needless to say, BabyAGI is still in its infancy and thus we are still determining its direction and the steps to get there. Currently, a key design goal for BabyAGI is to be _simple_ such that it's easy to understand and build upon. To maintain this simplicity, we kindly request that you adhere to the following guidelines when submitting PRs:

- Focus on small, modular modifications rather than extensive refactoring.
- When introducing new features, provide a detailed description of the specific use case you are addressing.

A note from @yoheinakajima (Apr 5th, 2023):

> I know there are a growing number of PRs, appreciate your patience - as I am both new to GitHub/OpenSource, and did not plan my time availability accordingly this week. Re:direction, I've been torn on keeping it simple vs expanding - currently leaning towards keeping a core Baby AGI simple, and using this as a platform to support and promote different approaches to expanding this (eg. BabyAGIxLangchain as one direction). I believe there are various opinionated approaches that are worth exploring, and I see value in having a central place to compare and discuss. More updates coming shortly.

I am new to GitHub and open source, so please be patient as I learn to manage this project properly. I run a VC firm by day, so I will generally be checking PRs and issues at night after I get my kids down - which may not be every night. Open to the idea of bringing in support, will be updating this section soon (expectations, visions, etc). Talking to lots of people and learning - hang tight for updates!

# BabyAGI Activity Report

To help the BabyAGI community stay informed about the project's progress, Blueprint AI has developed a Github activity summarizer for BabyAGI. This concise report displays a summary of all contributions to the BabyAGI repository over the past 7 days (continuously updated), making it easy for you to keep track of the latest developments.

To view the BabyAGI 7-day activity report, go here: [https://app.blueprint.ai/github/yoheinakajima/babyagi](https://app.blueprint.ai/github/yoheinakajima/babyagi)


# Inspired projects

In the short time since it was release, BabyAGI inspired many projects. You can see them all [here](docs/inspired-projects.md).

# Backstory

BabyAGI is a pared-down version of the original [Task-Driven Autonomous Agent](https://twitter.com/yoheinakajima/status/1640934493489070080?s=20) (Mar 28, 2023) shared on Twitter. This version is down to 140 lines: 13 comments, 22 blanks, and 105 code. The name of the repo came up in the reaction to the original autonomous agent - the author does not mean to imply that this is AGI.

Made with love by [@yoheinakajima](https://twitter.com/yoheinakajima), who happens to be a VC (would love to see what you're building!)
