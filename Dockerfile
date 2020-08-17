# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.12-glibc AS base

# System config
RUN apk --no-cache add ca-certificates wget curl && update-ca-certificates && \
    add-pkg \
		openjdk11-jre \
		gtk+3.0 \
		dbus-x11 \
		dbus \
		webkit2gtk


FROM base as app

# ENV vars
ENV APP_NAME=${APP_NAME:-"Portfolio Performance"}
ARG VERSION
ENV APP_ICON_URL=https://www.portfolio-performance.info/images/logo.png

# Download & install App
## if $VERSION is not set via --build-arg -> fetch latest PP version
RUN	export VERSION=${VERSION:-$(curl --silent "https://api.github.com/repos/buchen/portfolio/releases/latest" |grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')} && \
	cd /opt && wget https://github.com/buchen/portfolio/releases/download/${VERSION}/PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz && \
	tar xvzf PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz && \
	rm PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz

# Configure App
RUN sed -i '1s;^;-configuration\n/opt/portfolio/configuration\n-data\n/opt/portfolio/workspace\n;' /opt/portfolio/PortfolioPerformance.ini && \
	echo "osgi.nl=de" >> /opt/portfolio/configuration/config.ini && \
	chmod -R 777 /opt/portfolio && \
	install_app_icon.sh "$APP_ICON_URL"

# Copy files to container
ADD rootfs /

