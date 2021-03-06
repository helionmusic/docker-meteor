FROM node:8.14.1
MAINTAINER Helion Music (https://www.github.com/helionmusic)

ENV METEOR_VERSION 1.0.4.1
ENV METEOR_INSTALLER_SHA256 4020ef4d3bc257cd570b5b2d49e3490699c52d0fd98453e29b7addfbdfba9c80
ENV METEOR_LINUX_X86_32_SHA256 9d54898e5aada8313abec067bbf264ac726be55ccbf767419915fe8b981fb574
ENV METEOR_LINUX_X86_64_SHA256 4a814a6ec41a39e20b7a4d6abc5b2587f5c276eb7868a4ee1ca4edec51af87f2
ENV TARBALL_URL_OVERRIDE https://github.com/DanielDent/docker-meteor/releases/download/v${RELEASE}/meteor-bootstrap-${PLATFORM}-${RELEASE}.tar.gz

# 1. Download & verify the meteor installer.
# 2. Patch it to validate the meteor tarball's checksums.
# 3. Install meteor
# 4. Install demeteorizer

COPY meteor-installer.patch /tmp/meteor/meteor-installer.patch
COPY vboxsf-shim.sh /usr/local/bin/vboxsf-shim
RUN curl -SL https://install.meteor.com/?release=1.0.4.1 -o /tmp/meteor/inst \
    && chmod +x /tmp/meteor/inst \
    && /tmp/meteor/inst \
    && rm -rf /tmp/meteor \
    && npm install -g demeteorizer@4.3.0

VOLUME /app
WORKDIR /app
EXPOSE 3000
CMD [ "meteor" ]
