# docs: https://developer.wordpress.org/cli/commands/plugin/

git -C ${GITPOD_REPO_ROOT}/${APACHE_DOCROOT}/wp-content/plugins/ clone https://github.com/wp-mail-logging/wp-mail-logging-2
mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'localhost';";
PLUGIN_DIR=${GITPOD_REPO_ROOT}/${APACHE_DOCROOT}/wp-content/plugins/wp-mail-logging-2
echo "Setup ${PLUGIN_DIR}"
composer update --lock --working-dir ${PLUGIN_DIR}
composer install --working-dir ${PLUGIN_DIR}
chmod +x ${PLUGIN_DIR}/bin/*
${PLUGIN_DIR}/bin/install-wp-tests.sh wordpress_test wordpress 'wordpress'
wp rewrite structure '/%year%/%monthnum%/%postname%/'

wp plugin delete hello akismet

wp plugin activate wp-mail-logging-2
# wp plugin activate ${REPO_NAME}

# wp plugin install plugin_slug --activate
