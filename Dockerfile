FROM jacopochevallard/beaglebaseimage:1.3

# mount the current project workspace under /project inside the container
COPY . /data
WORKDIR /data

RUN cd /data/build

RUN make install

