# Speedtest-Tracker

[![Docker pulls](https://img.shields.io/docker/pulls/henrywhitaker3/speedtest-tracker?style=flat-square)](https://hub.docker.com/r/henrywhitaker3/speedtest-tracker) [![GitHub Workflow Status](https://img.shields.io/github/workflow/status/henrywhitaker3/Speedtest-Tracker/Stable?label=master&logo=github&style=flat-square)](https://github.com/henrywhitaker3/Speedtest-Tracker/actions) [![GitHub Workflow Status](https://img.shields.io/github/workflow/status/henrywhitaker3/Speedtest-Tracker/Dev?label=dev&logo=github&style=flat-square)](https://github.com/henrywhitaker3/Speedtest-Tracker/actions) [![last_commit](https://img.shields.io/github/last-commit/henrywhitaker3/Speedtest-Tracker?style=flat-square)](https://github.com/henrywhitaker3/Speedtest-Tracker/commits) [![issues](https://img.shields.io/github/issues/henrywhitaker3/Speedtest-Tracker?style=flat-square)](https://github.com/henrywhitaker3/Speedtest-Tracker/issues) [![commit_freq](https://img.shields.io/github/commit-activity/m/henrywhitaker3/Speedtest-Tracker?style=flat-square)](https://github.com/henrywhitaker3/Speedtest-Tracker/commits) ![version](https://img.shields.io/badge/version-v1.12.0-success?style=flat-square) [![license](https://img.shields.io/github/license/henrywhitaker3/Speedtest-Tracker?style=flat-square)](https://github.com/henrywhitaker3/Speedtest-Tracker/blob/master/LICENSE)

This program runs a speedtest check every hour and graphs the results. The back-end is written in [Laravel](https://laravel.com/) and the front-end uses [React](https://reactjs.org/). It uses the [Ookla's speedtest cli](https://www.speedtest.net/apps/cli) package to get the data and uses [Chart.js](https://www.chartjs.org/) to plot the results.

## Features

- Automatically run a speedtest every hour
- Graph of previous speedtests going back x days
- Backup/restore data in JSON/CSV format
- Slack/Discord/Telegram notifications
- [healthchecks.io](https://healthchecks.io) integration
- Organizr integration
- InfluxDB integration (currently v1 only, v2 is a WIP)
