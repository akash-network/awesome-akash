# Ghost 5

Ghost is a free and open source blogging platform written in JavaScript. Ghost 5 includes membership features, including premium subscriptions and newsletters.

Go to http://yourhost/ghost/ to set up your account.

## Production

It is not recommended to use the `sqlite3` database if you plan more than 1000 members in your blog.  

The MySQL & persistent storage enabled version is available here:

- [deploy-mysql.yaml](deploy-mysql.yaml)

## IPFS

A sql lite version, that backsup images and the sql database to ifps is available here:

- [deploy-ipfs.yaml](deploy-ipfs.yaml)
