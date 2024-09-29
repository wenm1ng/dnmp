composer () {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --user www-data:www-data \
        --volume ~/phpweb/dnmp/data/composer:/tmp/composer \
        --volume $(pwd):/app \
        --workdir /app \
        dnmp_php composer "$@"
}