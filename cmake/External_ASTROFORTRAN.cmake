# An external project for ASTROFORTRAN
# URL 
set ( ASTROFORTRAN_PREFIX "${CMAKE_BINARY_DIR}/dependencies" )

set ( ASTROFORTRAN_SOURCE  "${ASTROFORTRAN_PREFIX}/astrofortran-src" )
set ( ASTROFORTRAN_BINARY  "${ASTROFORTRAN_PREFIX}/astrofortran" )
set ( ASTROFORTRAN_INSTALL ${CMAKE_INSTALL_PREFIX} )

ExternalProject_Add(
  EXT_ASTROFORTRAN
  DOWNLOAD_DIR ${ASTROFORTRAN_PREFIX}
  SOURCE_DIR ${ASTROFORTRAN_SOURCE}
  BINARY_DIR ${ASTROFORTRAN_BINARY}
  INSTALL_DIR ${ASTROFORTRAN_INSTALL}
  GIT_REPOSITORY git@github.com:jacopo-chevallard/astrofortran.git
  GIT_TAG feature/shippable_CI_CD
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH}
  )

set ( ASTROFORTRAN_INCLUDE_DIR "${ASTROFORTRAN_INSTALL}/include" CACHE INTERNAL "ASTROFORTRAN include directory" )
set ( ASTROFORTRAN_LIBRARIES "${ASTROFORTRAN_INSTALL}/lib/${CMAKE_LIBRARY_PREFIX}astrofortran${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "ASTROFORTRAN library" )


