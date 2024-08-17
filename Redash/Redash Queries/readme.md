# Redash V10

The original repo is here: https://github.com/getredash

[Redash](redash.io) is an open-source data visualization and dashboarding tool that allows users to connect to various data sources, create interactive dashboards, and build visualizations to analyze data. It provides a user-friendly interface for querying, visualizing, and sharing data insights within an organization. Redash can be used to create reports, charts, graphs, and dashboards to help businesses make data-driven decisions.

  
### Akash Console DeploySet Up

The provided deploy.yaml uses [IP leases](https://akash.network/docs/network-features/ip-leases) and [persistent storage](https://akash.network/docs/network-features/persistent-storage). Remove one or both of these features if you are not receving bids.

After deploying, inside the shell of the deployment select "redash" and pass the following commands in order. 

```
bin/docker-entrypoint create_db
bin/docker-entrypoint server
```
`create_db` creates the initial database schema required by Redash.  
`server` is used to start the Redash web server. Redash will be available once this completes. 

Expected outputs from the commands can be seen below.

### Explanation of Services

**redash/redash:10.0.0.b50363** - This image is used multiple times, each service to be explained below.

 - redash - This is the Redash web server service. It serves the Redash web application to users, handles user interactions, and manages the execution of SQL queries. 
 - scheduler - The scheduler service manages scheduled jobs within Redash. It is responsible for executing background tasks at specified intervals.
 - scheduled_worker - This service runs worker processes for handling scheduled queries and schema-related tasks.
 - adhoc_worker - This service runs worker processes, but specifically for handling ad-hoc queries.
 - worker - This service runs a general-purpose worker process. 

**redis:5.0-alpine** - Redis is used as a caching and message broker system. It helps in caching frequently accessed data, managing background jobs, and facilitating real-time updates within Redash.

**redash/nginx:latest** - Nginx serves as a reverse proxy and web server for Redash. It handles HTTP requests, load balancing, SSL termination, and serves static content. Nginx directs traffic to the Redash web server and provides additional security and performance features.

**postgres:9.6-alpine** - PostgreSQL is used as the relational database backend for Redash. It stores various types of information, including user data, query metadata, visualization configurations, and other application-related data.

### Tutorials
[Redash YouTube channel](https://www.youtube.com/@redash1361/videos) demonstrating how to get started with queries and visualization.

### Example Queries

The following queries are made to answer questions defined in Akash Networks [Sig-Analytics PRD](https://github.com/akash-network/community/blob/main/sig-analytics/prd.md) using the Akash Console Database. More information on the database and schema can be found [here](https://github.com/akash-network/console).