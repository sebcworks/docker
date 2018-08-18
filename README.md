# Sonerezh with Docker / sebcworks version

This is the Git repository of the official Docker image for [Sonerezh](https://www.sonerezh.bzh). See the Hub page for more informations.

**WARNING**: the Docker image for Sonerezh is still under development. Some functionnality are broken like email notifications for example.

## How to build this image

Simply clone this repository and use `docker build`:

```sh
$> git clone --master https://github.com/sebcworks/sonerezh-docker
$> cd docker/nginx
$> docker build --tag sebcworks/sonerezh .
```

## How to use this image

### Manually

You can configure your Sonerezh instance manually. First you will need to run `mysql` or `mariadb` container:

```sh
$> docker run --name sonerezh-db --env MYSQL_ROOT_PASSWORD=changeme \
                                 --env MYSQL_USER=sonerezh \
                                 --env MYSQL_PASSWORD=changemetoo \
                                 --env MYSQL_DATABASE=sonerezh \
                                 --volume /path/to/mysql/data:/var/lib/mysql \
                                 --detach \
                                 mariadb
```

And then run Sonerezh container:

```sh
$> docker run --name sonerezh-app --link sonerezh-db:sonerezh-db \
                                  --volume /path/to/music:/music:ro \
                                  --volume /path/to/thumbnails:/thumbnails \
                                  --env MYSQL_USER=sonerezh \
                                  --env MYSQL_PASSWORD=changemetoo \
                                  --env MYSQL_DATABASE=sonerezh \
                                  --detach --publish 8080:80 \
                                  sebcworks/sonerezh
```

Your Sonerezh instance is available at http://127.0.0.1:8080 :) Make sure Sonerezh have read access to `/path/to/music` and read/write access to `/path/to/thumbnails`.

### Via docker-compose

See example [docker-compose file](nginx/docker-compose.yml)

Next, you'll have to:

* create mariadb.env file (see [example](nginx/mariadb.env.example))
* create database-info.env file (see [example](nginx/database-info.env.example))
* update the docker-compose.yml file to set the link to your music in the volume definition (you may do the same for thumbnails)

```yaml
    volumes:
      - /path/to/your/music:/music:ro
```

* *optionnaly* update the exposed port

```yaml
    ports:
      - 8080:80
```

Your folder should looks like this:

```ls
-rw-r--r-- 1 root root  80 Aug 18 15:27 database-info.env
-rw-r--r-- 1 root root 729 Aug 18 15:29 docker-compose.yml
-rw-r--r-- 1 root root  57 Aug 18 15:27 mariadb.env
```

Then, all you can launch the containers:

```sh
$> pwd
/path/to/your/folder/sonerezh
$> docker-compose up -d
```

## Contributing

You are invited to contribute new features, fixes, or update, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.
Before you start to code, we recommend discussing your plans through a [GitHub issue on the original repository](https://github.com/Sonerezh/sonerezh/issues), especially for more ambitious contributions.
