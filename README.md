# Basic PHP (Dev) Docker container
PHP-fpm with mcrypt, gdlib, pdo_mysql, json, opcache and zip extensions

Uses the following extensions
 - mcrypt (removed in 7.2)
 - gd
 - zip
 - json
 - pdo_mysql
 - mysqli
 - opcache
 
 
## Settings
### PHP version
The following Version are supported:
 - 7.0
 - 7.1
 - 7.2

### Env_vars
Use these Variables for the following Settings:

|ENV_VAR|Setting|Default Value|
|---|---|---|
|`PHP_MAX_EXECUTION_TIME`|`max_execution_time`|60|
|`PHP_MAX_INPUT_TIME`|`max_input_time`|60|
|`PHP_MEMORY_LIMIT`|`memory_limit`|512M|
|`PHP_ERROR_REPORTING`|`error_reporting`|E_ALL|
|`PHP_DISPLAY_ERRORS`|`display_errors`|On
|`PHP_DISPLAY_STARTUP_ERRORS`|`display_startup_errors`|On
|`PHP_POST_MAX_SIZE`|`post_max_size`|64M|
|`PHP_UPLOAD_MAX_FILESIZE`|`upload_max_filesize`|64M|
|`PHP_DATE_TIMEZONE`|`date.timezone`|Europe/Berlin|

### own php.ini
There is also the build `ARG` `PHP_INI` to point to completely different `php.ini`

To use the Env_vars and a own `php.ini`, just put `<<VAR_NAME>>` in the correct place and it will be automatically replaced

