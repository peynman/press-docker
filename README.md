### Larapress Stack Dockers
a ready to load docker environment to run laravel/php applications in a cluster

## Setup docker-compose mode
1. create .env file from .example.env
2. set ```BACKEND_NETWORK``` and ```FRONTEND_NETWORK``` in ``.env`` file to ```backend_local``` and ```frontend_local```
3. run the services
    1. ```docker-compose up -d apache2 php-fpm redis mariadb```
    2. ```docker-compose up -d php-cli```

## Setup swarm mode
1. create overlay networks
    1. ```docker network create --attachable -d overlay backend```
    2. ```docker network create --attachable -d overlay frontend```
    3. if you want to connect from compose instances add ```--attachabl``` flag
2. set ```BACKEND_NETWORK``` and ```FRONTEND_NETWORK``` in ``.env`` file to ```backend``` and ```frontend```
3. login in to registery ```docker login HOST:PORT```
4. make all data/logs/media directories on all hosts
    1. ```mkdir -p .data/{redis,mariadb,php-fpm,apache2,traefik,traefik,influxdb,livestream} .data/traefik/letsencrypt```
    2. ```mkdir -p .media .logs/{redis,mariadb,php-fpm,apache2,traefik,influxdb,livestream,horizon}```
5. run swarm stack
    1. ```docker stack deploy --with-registry-auth -c <(docker-compose config) app```

### Setup Xdebug VSCode
1. add XDEBUG_SESSION to EncryptCookies middleware in laravel App\Http\Middleware\EncryptCookies
    1. ```protected $except = [ 'XDEBUG_SESSION'];```

### Generate Dev Certificate
1. ```cd traefik/certs && openssl req -x509 -out localhost.crt -keyout localhost.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=*.host.local' -extensions EXT -config <(printf "[dn]\nCN=*.host.local\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:*.host.local\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")```

## Setup Laravel application
1. ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan vendor:publish```
2. ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan migrate```


## Mardiadb backup
1. ```docker exec  $(docker ps -lqf 'name=mariadb') mysqldump -uroot -proot app | zip  /srv/larapress-online-academy/docker/.data/backups/$(date "+%b_%d_%Y_%H_%M_%S").zip -```

## Influxdb remove by key
1. ```influx delete -o app --bucket app -p '_measurement="user.wallet.windowed"' --start="2009-01-02T23:00:00Z" --stop="2039-01-02T23:00:00Z"```
