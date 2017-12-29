# Build: `docker build -t rdrx .`
# Run: `docker run -dit --name rdrx -p 127.0.0.1:80:80 rdrx`

FROM httpd:alpine
MAINTAINER point.it@howiget.email

# dumb/bad/lazy; !care, because simple.
COPY ./rdrx.conf /
RUN cat /rdrx.conf >> /usr/local/apache2/conf/httpd.conf
