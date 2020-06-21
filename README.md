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
    1. ```docker network create -d overlay backend```
    2. ```docker network create -d overlay frontend```
2. set ```BACKEND_NETWORK``` and ```FRONTEND_NETWORK``` in ``.env`` file to ```backend``` and ```frontend```
3. run swarm stack
    1. ```docker stack deploy -c <(docker-compose config) press```

### Setup Xdebug VSCode
1. add XDEBUG_SESSION to EncryptCookies middleware in laravel App\Http\Middleware\EncryptCookies
    1. ```protected $except = [ 'XDEBUG_SESSION'];```

## Setup Laravel application
1. ```php artisan vendor:publish```
2. ```php artisan migrate```
