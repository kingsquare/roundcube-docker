<?php
require_once __DIR__ . '/config.inc.php.sample';

// force installer to be disabled (check later for minimal setup)
$config['enable_installer'] = false;
$config['docker'] = true;

// default log is stdout
$config['log_driver'] = 'stdout';

// set config from env
foreach ([
    'db_dsnw' => ['RCUBE_DATABASE_URL', 'DATABASE_URL'], // support DATABASE_URL for, among others, dokku deployments
    'default_host' => 'RCUBE_DEFAULT_HOST',
    'smtp_server' => ['RCUBE_SMTP_SERVER', 'RCUBE_DEFAULT_HOST'],
    'identities_level' => 'RCUBE_IDENTITIES_LEVEL',
    'skin_logo' => 'RCUBE_SKIN_LOGO',
    'product_name' => 'RCUBE_PRODUCT_NAME',
    'skin' => 'RCUBE_SKIN',
] as $configKey => $envKeys) {
    if (!is_array($envKeys)) {
        $envKeys = [$envKeys];
    }
    foreach ($envKeys as $envKey) {
        $envValue = getenv($envKey);
        if ($envValue === false) {
            continue;
        }
        if ($configKey === 'default_host') {
            if (!empty($envValue)) {
                $envValue = explode(',', $envValue);
            }
        }
        $config[$configKey] = $envValue;
        continue 1;
    }
}

if (file_exists(__DIR__ . '/config.custom.php')) {
    require_once __DIR__ . '/config.custom.php';
}

// check minimal config is set
if (!array_key_exists('db_dsnw', $config)) {
    die('Missing environment variable RCUBE_DATABASE_URL');
}
if (!array_key_exists('docker', $config)) {
    die('Your custom config should not reinitialize the $config variable');
}
