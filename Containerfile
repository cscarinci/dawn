FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/ublue-os/aurora-dx:stable

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit
    
RUN bootc container lint
