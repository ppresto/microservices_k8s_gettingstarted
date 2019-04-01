FROM nginx
COPY build /usr/share/nginx/html

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
    bash \
    curl 
