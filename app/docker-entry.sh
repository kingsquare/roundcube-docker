#!/bin/bash

cp /app/config.{inc,custom}.php /var/www/html/config

# https://github.com/roundcube/roundcubemail/wiki/Installation
PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:=64M}
PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE:=5M}
PHP_POST_MAX_SIZE=${PHP_POST_MAX_SIZE:=6M}

cat << EOL > ${PHP_INI_DIR}/conf.d/Z99_roundcube.ini
memory_limit=${PHP_MEMORY_LIMIT}
upload_max_filesize=${PHP_UPLOAD_MAX_FILESIZE}
post_max_size=${PHP_POST_MAX_SIZE}
EOL

if [ -f /app/php.custom.ini ]; then
    cat /app/php.custom.ini >> ${PHP_INI_DIR}/conf.d/Z99_roundcube.ini
fi

#############################################################
# upstream cmd
apache2-foreground
