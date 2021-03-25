### Larapress Stack Dockers
a ready to load docker environment to run laravel/php applications in a cluster

## Setup docker-compose mode
1. create .env file from .example.env
    1. change default passwords
2. set ```BACKEND_NETWORK``` and ```FRONTEND_NETWORK``` in ``.env`` file to ```backend_local``` and ```frontend_local```
3. run the services
    1. ```docker-compose up -d apache2 php-fpm redis mariadb```
    2. ```docker-compose up -d php-cli```

## Setup swarm mode
1. create .env file from .example.env
    1. change default passwords
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

## Mardiadb backup
1. ```docker exec  $(docker ps -lqf 'name=mariadb') mysqldump -uroot -proot app | zip  /srv/larapress-online-academy/docker/.data/backups/$(date "+%b_%d_%Y_%H_%M_%S").zip -```

## Influxdb remove by key
1. ```influx delete -o app --bucket app -p '_measurement="user.wallet.windowed"' --start="2009-01-02T23:00:00Z" --stop="2039-01-02T23:00:00Z"```


# Laravel Project
## Setup Laravel application
1. ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan migrate```

## Setup LaravelEcho as Boardcaster
1. Require pusher if you want to use echo ``composer require pusher/pusher-php-server "^5.0"``
1. Set ```BROADCAST_DRIVER=pusher``` in .env
1. Add echo in ``broadcast.php``
    ```
    'options' => [
        'cluster' => null,
        'encrypted' => true,
        'useTLS' => false,
        'host' => 'laravel-echo',
        'port' => env('ECHO_PORT', 6001),
        'scheme' => 'http'
    ],
    ```
1. Set ``PUSHER_APP_ID=`` and ``PUSHER_APP_KEY=`` in .env from docker .env
1. Add echo environment variables
    ```
    ECHO_PROTOCOL=http
    ECHO_HOST=laravel-echo
    ECHO_PORT=8443
    ECHO_WEB_PATH=/echo
    ```

## Setup PHPRedis and Session
1. Set redis password ``REDIS_PASSWORD=redispassword`` in .env
1. Add session-db, jobs-db to redis connections in ``database.php``
    ```
    'session-db' => [
        'url' => env('REDIS_URL'),
        'host' => env('REDIS_HOST', '127.0.0.1'),
        'password' => env('REDIS_PASSWORD', null),
        'port' => env('REDIS_PORT', '6379'),
        'database' => env('REDIS_SESSION_DB', '2'),
    ],
    'jobs-db' => [
        'url' => env('REDIS_URL'),
        'host' => env('REDIS_HOST', '127.0.0.1'),
        'password' => env('REDIS_PASSWORD', null),
        'port' => env('REDIS_PORT', 6379),
        'database' => env('REDIS_JOBS_DB', '3'),
    ],
    ```
1. Set session connection in .env ``SESSION_CONNECTION=session-db``
1. Add redis_jobs to queues in ``queue.php``
    ```php
    'redis_jobs' => [
        'driver' => 'redis',
        'connection' => 'jobs-db',
        'queue' => 'jobs',
        'retry_after' => 360,
        'block_for' => null,
    ],
    ```
# Larapress Project
## Require Larapress
1. ```docker exec  $(docker ps -lqf 'name=php-fpm') composer require peynman/larapress-auth```
1. ```docker exec  $(docker ps -lqf 'name=php-fpm') composer require peynman/larapress-pages```
1. ```docker exec  $(docker ps -lqf 'name=php-fpm') composer require peynman/larapress-ecommerce```
## Publish vendor files
1. ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan vendor:publish --tag=larapress```
## Setup Laravel User class
1. Add ``ICRUDUser``, ``IProfileUser``, ``IECommerceUser`` interfaces to User model.
1. Add ``BaseCRUDUser``, ``BaseProfileUser``, ``BaseECommerceUser`` traits to User model.
1. Add ``JWTSubject`` interface to User model.
1. Implement JWT methods
    ```php

        /**
         * Return a key value array, containing any custom claims to be added to the JWT.
         *
         * @return array
         */
        public function getJWTCustomClaims()
        {
            return [];
        }

        /**
         * Get the identifier that will be stored in the subject claim of the JWT.
         *
         * @return mixed
         */
        public function getJWTIdentifier()
        {
            return $this->getKey();
        }
    ```
1. Update users table in database
    ```php
    $table->string('name')->uniqid();
    $table->string('password');
    $table->integer('flags', false, true)->default(0);
    $table->rememberToken();
    $table->timestamps();
    $table->softDeletes();

    $table->index(['deleted_at', 'created_at', 'updated_at', 'name', 'flags']);
    ```
## Setup Laravel Horizon
1. ``docker exec  $(docker ps -lqf 'name=php-fpm') composer require laravel/horizon``
1. ``docker exec  $(docker ps -lqf 'name=php-fpm') php artisan horizon:install``
1. Change dashboard auth in ``HorizonServiceProvider.php``
```php
Gate::define('viewHorizon', function ($user) {
    return $user->hasPermission(['app.horizon']);
});
```
1. Add ``supervisor-2`` for long running jobs in ``horizon.php`` config
    ```php
    'supervisor-2' => [
        'connection' => 'redis_jobs',
        'queue' => ['jobs-db'],
        'balance' => 'simple',
        'processes' => 5,
        'tries' => 2,
        'memory' => 1024,
        'timeout' => 3500,
    ],
    ```

## Setup database
1. Run migrations ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan migrate```
1. Add permissions to db ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan lp:crud --action=update:permissions```
1. Add root user to db ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan lp:crud --action=create:super-user --name=root --password=root```
1. Add admin domain ```docker exec  $(docker ps -lqf 'name=php-fpm') php artisan lp:pages --action=add:domain --domain=admin.example.com```
