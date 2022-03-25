
RewriteEngine On
# редирект с http на https
RewriteCond %{SERVER_PORT} !^443$
RewriteRule .* https://%{SERVER_NAME}%{REQUEST_URI} [R,L]

Options -Indexes 
# Опция SymLinks проверяет владельца, при ее использовании следует учитывать, что будет небольшая потеря производительности.
#+SymLinksIfOwnerMatch
AddDefaultCharset utf-8

<IfModule mod_rewrite.c>
    RewriteEngine On

    # Технические работы
    # ----------------------------------------------------
    # условие, если строка запроса не равна /techwork.html
    #RewriteCond %{REQUEST_URI} !^/techwork.html

    # на любой запрос выводим страницы /techwork.html
    #RewriteRule ^.*$ /techwork.html
    # ----------------------------------------------------

    # the main rewrite rule for the frontend application
    RewriteCond %{REQUEST_URI} !^/(backend/web|admin)
    RewriteRule !^frontend/web /frontend/web%{REQUEST_URI} [L]

    # redirect to the page without a trailing slash (uncomment if necessary)
    #RewriteCond %{REQUEST_URI} ^/admin/$
    #RewriteRule ^(admin)/ /$1 [L,R=301]
    # the main rewrite rule for the backend application
    RewriteCond %{REQUEST_URI} ^/admin
    RewriteRule ^admin(.*) /backend/web/$1 [L]

    # if a directory or a file of the frontend application exists, use the request directly
    RewriteCond %{REQUEST_URI} ^/frontend/web
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    # otherwise forward the request to index.php
    RewriteRule . /frontend/web/index.php [L]

    # if a directory or a file of the backend application exists, use the request directly
    RewriteCond %{REQUEST_URI} ^/backend/web
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    # otherwise forward the request to index.php
    RewriteRule . /backend/web/index.php [L]

    RewriteCond %{REQUEST_URI} \.(htaccess|htpasswd|svn|git)
    RewriteRule \.(htaccess|htpasswd|svn|git) - [F]
</IfModule>