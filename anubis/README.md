# Anubis

Anubis weighs the soul of your connection using a proof-of-work challenge in order to protect upstream resources from scraper bots.

TL;DR: If you don't want to use (centralized) solution like Cloudflare to protect your system from bots, use Anubis.

**From the docs:**

This program is designed to help protect the small internet from the endless storm of requests that flood in from AI companies. Anubis is as lightweight as possible to ensure that everyone can afford to protect the communities closest to them.

Anubis is a bit of a nuclear response. This will result in your website being blocked from smaller scrapers and may inhibit "good bots" like the Internet Archive. You can configure bot policy definitions to explicitly allowlist them and we are working on a curated set of "known good" bots to allow for a compromise between discoverability and uptime.

In most cases, you should not need this and can probably get by using Cloudflare to protect a given origin. However, for circumstances where you can't or won't use Cloudflare, Anubis is there for you.

Visit [Anubis Docs](https://anubis.techaro.lol/docs/) for more configuration details.