# Metabase

[Metabase](https://www.metabase.com/) is the easy, open-source way for everyone in your company to ask questions and learn from data.
![](metabase-product-screenshot.svg)

After the deployment is confirmed and running, open a browser and go to the IP address provided by the lease status (or by accessing Akash’s dashboard if preferred). You should be able to access Metabase on the specified port, and it will lead you to the Metabase setup wizard.

##  Notes

- **Data Storage**: The SDL example above does not configure persistent storage. If you need persistence across restarts, consider integrating with an external database or using Akash persistent storage options.

- **Environment Variables**: Configure environment variables for Metabase (e.g., `MB_DB_FILE` or `MB_DB_*` for database connection details) by adding an env block within the services section if needed.
