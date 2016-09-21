FROM jacopochevallard/beaglebaseimage:1.3

# mount the current project workspace under /project inside the container
COPY . /data
WORKDIR /data

RUN rm -rf /data/src /data/cmake-macros

CMD /data/bin/hello_world

