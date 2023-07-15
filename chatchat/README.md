# [Chat Chat](https://chat.okisdev.com)

> Chat Chat to unlock your next level AI conversational experience. You can use multiple APIs from OpenAI, Microsoft Azure, Claude, Cohere, Hugging Face, and more to make your AI conversation experience even richer.

## Important Notes

-   Some APIs are paid APIs, please make sure you have read and agreed to the relevant terms of service before use.
-   Some features are still under development, please submit PR or Issue.
-   The demo is for demonstration purposes only, it may retain some user data.
-   AI may generate offensive content, please use it with caution.

## Preview

### Interface

![UI](https://cdn.harrly.com/project/GitHub/Chat-Chat/img/UI-1.png)

![Dashboard](https://cdn.harrly.com/project/GitHub/Chat-Chat/img/Dashboard-1.png)

### Functions

https://user-images.githubusercontent.com/66008528/235539101-562afbc8-cb62-41cc-84d9-1ea8ed83d435.mp4

https://user-images.githubusercontent.com/66008528/235539163-35f7ee91-e357-453a-ae8b-998018e003a7.mp4

## Features

-   [x] TTS
-   [x] Dark Mode
-   [x] Chat with files
-   [x] Markdown formatting
-   [x] Multi-language support
-   [x] Support for System Prompt
-   [x] Shortcut menu (command + k)
-   [x] Wrapped API (no more proxies)
-   [x] Support for sharing conversations
-   [x] Chat history (local and cloud sync)
-   [x] Support for streaming messages (SSE)
-   [x] Plugin support (`/search`, `/fetch`)
-   [x] Support for message code syntax highlighting
-   [x] Support for OpenAI, Microsoft Azure, Claude, Cohere, Hugging Face

## Roadmap

Please refer to https://github.com/users/okisdev/projects/7

## Usage

### Prerequisites

-   Any API key from OpenAI, Microsoft Azure, Claude, Cohere, Hugging Face

### Environment variables

| variable name         | description                 | default                               | mandatory                | prompt                                                                                                            |
| --------------------- | --------------------------- | ------------------------------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| `BASE_URL`            | Your website URL            | Local default `http://localhost:3000` | (with prefix) **Yes**    |                                                                                                                   |
| `DATABASE_URL`        | Postgresql database address |                                       | **Yes**                  | Start with `postgresql://` (if not required, please fill in `postgresql://user:password@example.com:port/dbname`) |
| `NEXTAUTH_URL`        | Your website URL            |                                       | (without prefix) **Yes** |                                                                                                                   |
| `NEXTAUTH_SECRET`     | NextAuth Secret             |                                       | **Yes**                  | Random hash (16 bits is best)                                                                                     |
| `OPENAI_API_KEY`      | OpenAI API key              |                                       | No                       |                                                                                                                   |
| `OPENAI_API_ENDPOINT` | OpenAI API access point     |                                       | No                       |                                                                                                                   |
| `EMAIL_HOST`          | SMTP Host                   |                                       | No                       |                                                                                                                   |
| `EMAIL_PORT`          | SMTP Port                   |                                       | No                       |                                                                                                                   |
| `EMAIL_USERNAME`      | SMTP username               |                                       | No                       |                                                                                                                   |
| `EMAIL_PASSWORD`      | SMTP password               |                                       | No                       |                                                                                                                   |
| `EMAIL_FORM`          | SMTP sending address        |                                       | No                       |                                                                                                                   |

### Deployment

> Please modify the environment variables before deployment, more details can be found in the [documentation](https://docs.okis.dev/chat/deployment/).

## LICENSE

[AGPL-3.0](./LICENSE)

## Support me

[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/okisdev)

## Technology Stack

```nextjs / tailwindcss / shadcn UI```
