FROM fluent/fluentd:v1.11-1

# Use root account to use apk
USER root
#编译版本
ARG  VERSION=v1.11

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev curl \
 && sudo gem install fluent-plugin-elasticsearch \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ADD https://raw.githubusercontent.com/fluent/fluentd-docker-image/master/$VERSION/alpine/fluent.conf /fluentd/etc/
ADD https://raw.githubusercontent.com/fluent/fluentd-docker-image/master/$VERSION/alpine/entrypoint.sh /bin/

RUN chmod +x /bin/entrypoint.sh

USER fluent
