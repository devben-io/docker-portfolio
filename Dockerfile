# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.12-glibc

ENV VERSION 0.47.0
ENV ARCHIVE https://github.com/buchen/portfolio/releases/download/${VERSION}/PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz
ENV APP_ICON_URL=https://www.portfolio-performance.info/images/logo.png
	
RUN apk --no-cache add ca-certificates wget && update-ca-certificates && \
	cd /opt && wget ${ARCHIVE} && tar xvzf PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz && \
	rm PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz

RUN \
    add-pkg \
        openjdk8-jre \
		gtk+3.0

RUN \
	sed -i '1s;^;-configuration\n/opt/portfolio/configuration\n-data\n/opt/portfolio/workspace\n;' /opt/portfolio/PortfolioPerformance.ini && \
	echo "osgi.nl=de" >> /opt/portfolio/configuration/config.ini && \
	chmod -R 777 /opt/portfolio && \
    install_app_icon.sh "$APP_ICON_URL"

# Copy the start script.
COPY startapp.sh /startapp.sh

# Set the name of the application.
ENV APP_NAME="Portfolio Performance"
