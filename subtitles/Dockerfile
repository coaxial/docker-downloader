FROM golang:1.9-alpine as builder
ARG JOBBER_VERSION=1.3.2
ARG TARBALL_SHASUM=c265ee1a7076c523b44e900869b8af01817d92a5b543501e77db9277c8cf1f25
RUN apk add --no-cache make rsync grep ca-certificates openssl
WORKDIR /go_wkspc/src/github.com/dshearer
RUN wget "https://api.github.com/repos/dshearer/jobber/tarball/v${JOBBER_VERSION}" -O jobber.tar.gz && \
    echo "${TARBALL_SHASUM}  jobber.tar.gz" | sha256sum -cw && \
    tar xzf *.tar.gz && rm *.tar.gz && mv dshearer-* jobber && \
    cd jobber && \
    make check && \
    make install DESTDIR=/jobber-dist/

FROM python:3.6-alpine3.7
COPY --from=builder /jobber-dist/usr/local/libexec/jobberrunner /jobber/jobberrunner
COPY --from=builder /jobber-dist/usr/local/bin/jobber /jobber/jobber
ENV PATH /jobber:${PATH}
RUN mkdir -p /var/jobber/0

ARG S6_OVERLAY_VERSION=1.21.2.2
ARG S6_OVERLAY_ARCH=x86
ARG SUBLIMINAL_VERSION=2.0.5
ENV S6_LOGGING_SCRIPT ""

ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-$S6_OVERLAY_ARCH.tar.gz /tmp

RUN tar xzf /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz -C / &&\
  rm /tmp/s6-overlay-$S6_OVERLAY_ARCH.tar.gz
RUN adduser -u 911 -s /bin/false -D user
RUN apk --no-cache add shadow

RUN pip install subliminal==$SUBLIMINAL_VERSION

RUN mkdir -p /var/log/subliminal /var/log/jobber /var/cache/subliminal
COPY root/ /
RUN chmod 0600 /home/root/.jobber

ENTRYPOINT ["/init"]
