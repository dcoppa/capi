FROM alpine:3.20.3
ENV LANG en_US.UTF-8
ENV TZ Europe/Berlin
RUN umask 022
RUN apk update && apk upgrade -a --update-cache
ADD --chown=root argocd /usr/bin/argocd
ADD --chown=root kubectl /usr/bin/kubectl
ADD --chown=root entrypoint.sh /app/entrypoint.sh
RUN chmod 0755 /usr/bin/argocd /usr/bin/kubectl /app/entrypoint.sh
USER app
ENTRYPOINT ["/app/entrypoint.sh"]
