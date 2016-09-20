FROM jacopochevallard/beaglebaseimage:1.3

# mount the current project workspace under /project inside the container
ADD . /project

WORKDIR /project

ENV CMAKE_MACROS /project/cmake-macros

RUN git clone https://github.com/jacopo-chevallard/cmake-macros.git $CMAKE_MACROS

RUN mkdir -p /project/build
RUN cd /project/build
RUN cmake -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran ..
RUN make
