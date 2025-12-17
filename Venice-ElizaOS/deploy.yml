--- 
version: "2.0"
services:
  service-1:
    image: kylecohen01/venice_eliza:1.1
    expose:
      - port: 3000
        as: 3000
        to:
          - global: true
      - port: 5173 #these are currently enabled for testing of the chat UI. This is currently not functional. Placeholder for testing
        as: 5173
        to:
          - global: true
      - port: 5174 #these are currently enabled for testing of the chat UI. This is currently not functional. Placeholder for testing
        as: 5174
        to:
          - global: true
    env:
      - TWITTER_USERNAME= #twitter username
      - TWITTER_PASSWORD= #twitter password
      - TWITTER_EMAIL= #twitter email address
      - TWITTER_POLL_INTERVAL=120
      - TWITTER_SEARCH_ENABLE=FALSE
      - TWITTER_TARGET_USERS= #twitter accounts to target
      - POST_INTERVAL_MIN=60 #min posting frequency
      - POST_INTERVAL_MAX=120 #max posting frequency
      - POST_IMMEDIATELY=true
      - TWITTER_DRY_RUN=false #test-run, true does not post to twitter
      - TWITTER_SPACES_ENABLE=false
      - ENABLE_TWITTER_POST_GENERATION=true
      - ENABLE_ACTION_PROCESSING=false 
      - MAX_ACTIONS_PROCESSING=1       
      - ACTION_TIMELINE_TYPE=foryou
      - VENICE_API_KEY= #venice api key
      - SMALL_VENICE_MODEL=llama-3.3-70b #venice model selectors
      - MEDIUM_VENICE_MODEL=llama-3.3-70b #venice model selectors
      - LARGE_VENICE_MODEL=llama-3.3-70b #venice model selectors
      - IMAGE_VENICE_MODEL=flux-dev #venice model selectors
      - DEFAULT_LOG_LEVEL=debug #log level - debug shows everything
      - CHAR_CLIENTS=twitter #clients to enable. SDL only setup for twitter integation or empty for chat only
      - CHAR_NAME= #name your character, do not use quotes
      - CHAR_BIO= #character bio, separate by commas, do not use quotes
      - CHAR_LORE= #character lore, separate by commas, do not use quotes
      - PROMPT_1_INPUT= #user sample prompt
      - PROMPT_1_RESPONSE= #character sample response
      - PROMPT_2_INPUT= #user sample prompt
      - PROMPT_2_RESPONSE= #character sample response
      - POST_EXAMPLES=
      - CHAR_OVERALL_STYLE= #character overall style, separate by commas, do not use quotes
      - CHAR_CHAT_STYLE= #character chat style, separate by commas, do not use quotes
      - CHAR_POST_STYLE= #character post style, separate by commas, do not use quotes
      - CHAR_ADJECTIVES= #character adjectives, separate by commas, do not use quotes
profiles:
  compute:
    service-1:
      resources:
        cpu:
          units:
            - 16
        memory:
          size: 32gb #tuning of these values for optimization required
        storage:
          - size: 64Gi  #tuning of these values for optimization required
  placement:
    dcloud:
      pricing:
        service-1:
          denom: uakt
          amount: 1000000
      attributes:
        host: akash
deployment:
  service-1:
    dcloud:
      profile: service-1
      count: 1