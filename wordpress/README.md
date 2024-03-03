# WordPress

WordPress is a free and open source blogging tool and a content management system (CMS) based on PHP and MySQL.  This SDL includes MariaDB (MySQL fork).

## Troubleshooting

### 413 Request Entity Too Large

You might get the `413 Request Entity Too Large` error when uploading large files.  
To fix this, make sure to set `expose.http_options.max_body_size` to a large enough value in your deployment SDL file and once you've deployed the wordpress image, modify the `.htaccess` file (or make your own image with the fixed file):

Prepare the env:

```
AKASH_DSEQ=<your dseq>
AKASH_PROVIDER=<provider address your deployment is running at>
AKASH_NODE=<set to one of the nodes from https://raw.githubusercontent.com/ovrclk/net/master/mainnet/rpc-nodes.txt list>
```

Drop into your wordpress deployment:

```
akash provider lease-shell --tty --stdin -- wordpress bash
```

And fix the `.htaccess` file there:

```
cat >> /var/www/html/.htaccess << EOF
php_value upload_max_filesize 64M
php_value post_max_size 64M
php_value max_execution_time 300
php_value max_input_time 300
EOF
```

You can also achieve the same by modifying the php.ini file.
