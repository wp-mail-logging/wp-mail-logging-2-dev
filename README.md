# wp-mail-logging-2-dev [<img alt="Open in gitpod" src="https://gitpod.io/button/open-in-gitpod.svg" />](https://gitpod.io/#https://github.com/wp-mail-logging/wp-mail-logging-2-dev)

## WP Mail Logging 2 Development Environment

This repository contains a complete environment to start development on wp-mail-logging-2.

It’s based on [Gitpod](https://www.gitpod.io/) which is is a ready-to-code dev environment with a single click. It will allow you to develop the plugin directly from your browser. You can even open the project remote from VSCode and IntelliJ.

## Getting Started

Click the `Open in gitpod` button and wait for the image to build. After this you will see VSCode IDE and a WordPress instance in the browser.

Find the plugin in `public_html/wp-content/plugins/wp-mail-logging2` and start development.

![image](https://user-images.githubusercontent.com/2690708/189997071-3b894dcd-9dd2-470a-b461-7408d5f35a37.png)

## Features

- LAMP (Apache, MySQL, PHP)
- [Composer](https://getcomposer.org/)
- [Adminer](https://www.adminer.org/)
- [NVM](https://github.com/nvm-sh/nvm)
- [Node.js](https://nodejs.org/) (LTS)
- WIP [Xdebug](https://xdebug.org/)
- [WP-CLI](https://wp-cli.org/)
- Git
- SVN
- [MailHog](https://github.com/mailhog/MailHog)

## Configure

You can fork the repository and edit the `.gitpod.yml` and `.gitpod.dockerfile`  and it push to your remote repository.

- By default, the webserver will use PHP `v7.4`. If you need a different version, change it on `ENV PHP_VERSION` in your `.gitpod.dockerfile` (line 4).

Also, the `wp-setup-plugin` will execute the  `.init.sh` file in the project root directory. There the checkout of the plugin is done. Then, you can use the `wp-cli` to install plugins, install themes, and [more](https://developer.wordpress.org/cli/commands/). Or create your own tasks.

```
# .init.shwp plugin install woocommerce --activate # install WooCommercewp
```

## Usage

Now you access `https://gitpod.io/#https://github.com/wp-mail-logging/wp-mail-logging-2-dev`.

Your admin credentials:

```
username: admin
password: password
```

### Utilities

- You can use the following commands in terminal:
    - `browse-url <endpoint>` open an endpoint of your WordPress installation.
    - `browse-home` alias for `browse-url /` (your Homepage)
    - `browse-wpadmin` alias for `browse-url /wp-admin` (WordPress Admin Painel)
    - `browse-dbadmin` alias for `browse-url /database` (to manage your database with Adminer)
    - `browse-phpinfo` alias for `browse-url /phpinfo` (a page with `<?php phpinfo(); ?>`)
    - `browse-emails` open the MailHog client
- You can setup your PHP on `.htaccess` file (eg: `php_value max_execution_time 600`)

## Contributing

To contribute, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to your fork: `git push origin <branch_name>`
5. Create the Pull Request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

Just found a bug? Report it on GitHub [Issues](https://github.com/wp-mail-logging/wp-mail-logging-2-dev/issues).

## Credits

The contents of the repostiory are based on https://github.com/luizbills/gitpod-wordpress © 2019 Luiz Paulo “Bills” but with improvements and customizations.
