# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.12-glibc

# ENV vars
ENV APP_NAME="Portfolio Performance"
ENV VERSION 0.47.0
ENV ARCHIVE https://github.com/buchen/portfolio/releases/download/${VERSION}/PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz
ENV APP_ICON_URL=https://www.portfolio-performance.info/images/logo.png

# System config
RUN apk --no-cache add ca-certificates wget && update-ca-certificates && \
    add-pkg \
		openjdk8-jre \
		gtk+3.0 \
		dbus-x11 \
		dbus \
		webkit2gtk


# Download & install App
RUN	cd /opt && wget ${ARCHIVE} && tar xvzf PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz && \
	rm PortfolioPerformance-${VERSION}-linux.gtk.x86_64.tar.gz

# Configure App
RUN \
	sed -i '1s;^;-configuration\n/opt/portfolio/configuration\n-data\n/opt/portfolio/workspace\n;' /opt/portfolio/PortfolioPerformance.ini && \
	echo "osgi.nl=de" >> /opt/portfolio/configuration/config.ini && \
	chmod -R 777 /opt/portfolio && \
	install_app_icon.sh "$APP_ICON_URL"

# Copy files to container
ADD rootfs /

