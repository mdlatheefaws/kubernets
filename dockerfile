FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y nginx curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and unpack the HTML template
RUN rm -rf /var/www/html/* && \
    curl -L -o /tmp/site.zip https://templatemo.com/download/templatemo_600_prism_flux && \
    unzip /tmp/site.zip -d /tmp/site && \
    bash -lc 'shopt -s dotglob nullglob && d=(/tmp/site/*) && cp -r "${d[0]}"/* /var/www/html/' && \
    rm -rf /tmp/site /tmp/site.zip

EXPOSE 80
CMD ["nginx","-g","daemon off;"]
