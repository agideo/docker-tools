FROM buildpack-deps:stretch

RUN set -ex \
  && apt-get update \
  && apt-get install -y --no-install-recommends subversion libapache2-mod-svn apache2 \
  && a2enmod dav dav_svn authz_svn \
  && rm -rf /var/lib/apt/lists/*

RUN { \
  echo '<Location /repos>'; \
  echo '  DAV svn'; \
  echo '  SVNParentPath /var/lib/svn/repos'; \
  echo '  AuthType Basic'; \
  echo '  AuthName "Subversion Repository"'; \
  echo '  AuthUserFile /var/lib/svn/config/passwd'; \
  echo '  AuthzSVNGroupsFile /var/lib/svn/config/groups'; \
  echo '  AuthzSVNReposRelativeAccessFile authz'; \
  echo '  Require valid-user'; \
  echo '</Location>'; \
} >> /etc/apache2/sites-enabled/000-svn.conf

RUN set -ex \
  && mkdir -p /var/lib/svn/config \
  && mkdir /var/lib/svn/repos

WORKDIR /var/lib/svn
VOLUME /var/lib/svn

EXPOSE 80
CMD apachectl -DFOREGROUND
