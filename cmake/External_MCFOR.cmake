# An external project for MCFOR
# URL 
set ( MCFOR_PREFIX "${CMAKE_BINARY_DIR}/dependencies" )

set ( MCFOR_SOURCE  "${MCFOR_PREFIX}/mcfor-src" )
set ( MCFOR_BINARY  "${MCFOR_PREFIX}/mcfor" )
set ( MCFOR_INSTALL ${CMAKE_INSTALL_PREFIX} )

ExternalProject_Add(
  EXT_MCFOR
  DOWNLOAD_DIR ${MCFOR_PREFIX}
  SOURCE_DIR ${MCFOR_SOURCE}
  BINARY_DIR ${MCFOR_BINARY}
  INSTALL_DIR ${MCFOR_INSTALL}
  GIT_REPOSITORY git@github.com:jacopo-chevallard/mcfor.git
  GIT_TAG feature/shippable_CI_CD
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_VERBOSE_MAKEFILE=ON -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH}
  )

set ( MCFOR_INCLUDE_DIR "${MCFOR_INSTALL}/include" CACHE INTERNAL "MCFOR include directory" )
set ( MCFOR_LIBRARIES "${MCFOR_INSTALL}/lib/${CMAKE_LIBRARY_PREFIX}mcfor${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "MCFOR library" )


