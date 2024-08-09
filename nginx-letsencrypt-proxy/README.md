# Nginx Let's Encrypt Proxy

This repository contains the necessary configuration files and instructions to set up an Nginx reverse proxy with Let's Encrypt SSL certificate.

## Prerequisites

Before getting started, make sure you have the following:

- A registered domain name

## Installation

1. Copy the nginx.conf and change the server_name to your domain and the proxy_pass to your application.

2. Upload the `nginx.conf` to Gist or any other file hosting service. Make sure the file is publicly accessible.

3. Go to console.akash.network and create a new deployment with the SDL in deploy.yml.

4. Replace the `NGINX_CONF_URL` in the SDL with the URL of the `nginx.conf` file you uploaded in step 2.

5. Replace the `DOMAIN` in the SDL with your domain name.

6. Make sure `FIRST_START` is set to `true` in the SDL.

7. Deploy the application and select a Provider.

8. Once the deployment starts, you can see the leased IP address in the Leases tab of the Akash Console.
Copy the IP address and create an A record in your domain's DNS settings pointing to this IP address.

9. Wait for the DNS changes to propagate. You can check the status of the DNS propagation using online tools like [DNS Checker](https://dnschecker.org/).

10. Update the `FIRST_START` to `false` in the SDL.

11. You should now be able to access your application using your domain name over HTTPS.

A successful deployment should look similar to this:
```bash
[nginx]: Saving to: '/etc/nginx/nginx.conf'
[nginx]: 2024-08-09 13:22:03 (50.3 MB/s) - '/etc/nginx/nginx.conf' saved [956/956]
[nginx]: 
[nginx]: Saving debug log to /var/log/letsencrypt/letsencrypt.log
[nginx]: Account registered.
[nginx]: Requesting a certificate for YOURDOMAIN.COM
[nginx]: 
[nginx]: Successfully received certificate.
[nginx]: Certificate is saved at: /etc/letsencrypt/live/YOURDOMAIN.COM/fullchain.pem
[nginx]: Key is saved at:         /etc/letsencrypt/live/YOURDOMAIN.COM/privkey.pem
[nginx]: This certificate expires on 2024-11-07.
[nginx]: These files will be updated when the certificate renews.
[nginx]: Certbot has set up a scheduled task to automatically renew this certificate in the background.
[nginx]: 
[nginx]: Deploying certificate
[nginx]: Successfully deployed certificate for YOURDOMAIN.COM to /etc/nginx/nginx.conf
[nginx]: Congratulations! You have successfully enabled HTTPS on https://YOURDOMAIN.COM
```

## FAQ

### How do I renew the SSL certificate?

The SSL certificate is automatically renewed by Certbot. You don't need to do anything to renew the certificate.

### How do I update the Nginx configuration?

To update the Nginx configuration, you need to update the `nginx.conf` file and upload it to a publicly accessible URL. Then update the `NGINX_CONF_URL` in the SDL with the new URL. Note that it will recreate the Certificate.

### What do i do if i run in to the error `too many registrations for this IP`?

If you run into the error `too many registrations for this IP`, it means that you have reached the Let's Encrypt rate limit for the number of registrations from a single IP address. You can wait for the rate limit to reset or use a different Provider to register the certificate.
