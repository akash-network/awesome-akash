FROM codercom/code-server:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    bash \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

ENV HOME=/root
ENV CLAUDE_CONFIG_DIR=/root/.claude
ENV XDG_CONFIG_HOME=/root/.config
ENV DISABLE_AUTOUPDATER=1
RUN mkdir -p /root/.claude/project \
             /root/.config/code-server

RUN curl -fsSL https://claude.ai/install.sh | bash

RUN code-server --install-extension Anthropic.claude-code

COPY run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh 
RUN cp /root/.local/bin/claude /usr/bin/

WORKDIR /root/.claude/project

ENTRYPOINT ["/usr/bin/env", "bash", "/usr/bin/run.sh"]
