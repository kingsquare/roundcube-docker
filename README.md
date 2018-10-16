# Roundcube Docker

A docker image for [roundcube](https://roundcube.net) deployment

## Configuration

Configuration is done via environment variables

|Key|Description|
|---|---|
|RCUBE_DATABASE_URL|i.e. `sqlite:////data/roundcube.db` [docs](https://github.com/roundcube/roundcubemail/wiki/Configuration#database-connection)|
|RCUBE_DEFAULT_HOST|The default IMAP server [docs](https://github.com/roundcube/roundcubemail/wiki/Configuration#imap-server-connection) comma delimit for multiple choices, set empty for user choice|
|RCUBE_SMTP_SERVER|The default SMTP server (defaults to `RCUBE_DEFAULT_HOST`) [docs](https://github.com/roundcube/roundcubemail/wiki/Configuration#sending-messages-via-smtp)|
|RCUBE_IDENTITIES_LEVEL|[docs](https://github.com/roundcube/roundcubemail/wiki/Configuration#restricting-sender-identities)|
|RCUBE_SKIN_LOGO|Override the skin logo [docs](https://github.com/roundcube/roundcubemail/wiki/Configuration#customize-the-look)|
|RCUBE_SUPPORT_URL|The support url to display for support [docs](https://github.com/roundcube/roundcubemail/wiki/Configuration#customize-the-look)|
|RCUBE_PRODUCT_NAME|The product name to display instead of _Roundcube Webmail_|
|RCUBE_SKIN|The default skin to use instead of the default|
|RCUBE_DES_KEY|This key is used to encrypt the users IMAP password which is temporarily stored in the session database. For security reasons it's important that your Roundcube installation has its very own encryption key and that you *don't use the default value! *|
|PHP_ENV|The php env (default `production` set to a `development` for inline error reporting, xdebug support et al|
|PHP_MEMORY_LIMIT|default `64M`|
|PHP_UPLOAD_MAX_FILESIZE|default `5M`|
|PHP_POST_MAX_SIZE|default `6M`|

### Advanced

Extend this Docker image and add an own`/app/config.custom.php`. See [config defaults](https://github.com/roundcube/roundcubemail/blob/master/config/defaults.inc.php)

#### php.ini

Extend this Docker image and add an own`/app/php.custom.ini`.

## Enabling xdebug and inline error reporting

Set the environment variable `PHP_ENV` to `development`

## Adding a custom skin

Docker-mount the skin directory into the skins directory.

Or just override the _larry_ skin

Docker-mount the skin directory over the skins/larry directory

### Using a custom skin as default

Set the environment variable `RC_SKIN` to the name of the custom skin directory.

# TODO

 * [ ] migrate to alpine
