FROM chartmuseum/chartmuseum

ONBUILD COPY --chown=1000:1000 ./chartstorage /home/chartmuseum/chartstorage

ENTRYPOINT ["/chartmuseum", "--storage=local", "--storage-local-rootdir=/home/chartmuseum/chartstorage"]
