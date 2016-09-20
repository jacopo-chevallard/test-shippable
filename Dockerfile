ENV CMAKE_MACROS $HOME/cmake-macros

RUN git clone https://github.com/jacopo-chevallard/cmake-macros.git $CMAKE_MACROS

RUN mkdir -p build
RUN cd build
RUN cmake -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran ..
RUN make
