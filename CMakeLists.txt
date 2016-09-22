# CMake project file for mt_stream
cmake_minimum_required ( VERSION 2.6 )
project ( BEAGLEProject )
enable_language ( Fortran )

# You are building shared libs!
set ( CMAKE_BUILD_SHARED_LIBS ON CACHE INTERNAL "build shared libs" )

# Whether to seach for existing packages system wide ot just in the CMAKE_INSTALL_PREFIX path
set ( CMAKE_NO_DEFAULT_PATH ON CACHE INTERNAL "no default path" )

# Verbose output
set ( CMAKE_VERBOSE_MAKEFILE OFF CACHE INTERNAL "verbose cmake output" )

# Set the CMAKE_MODULE_PATH
LIST ( APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" )
LIST (APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MACROS})

# Set flag for Shippable CD/CI
if (SHIPPABLE)
  set (SHIPPABLE ON CACHE INTERNAL "Flag for Shippable CD/CI")
endif (SHIPPABLE)

include ( ExternalProject )
include( libFindGeneral )

# Default flags
if ( USE_MPI )
  include ( MPI_Fortran_Flags )
endif ( USE_MPI )

# RPATH configuration
include ( General_rpath_config )

# Whether you build a static or shared library
set(LIBRARY_TYPE SHARED)
if (CMAKE_LIBRARY_TYPE)
  set(LIBRARY_TYPE ${CMAKE_LIBRARY_TYPE})
endif (CMAKE_LIBRARY_TYPE)

if (${LIBRARY_TYPE} STREQUAL "STATIC")
  set (CMAKE_LIBRARY_PREFIX ${CMAKE_STATIC_LIBRARY_PREFIX} CACHE INTERNAL "Prefix for CMake libraries")
  set (CMAKE_LIBRARY_SUFFIX ${CMAKE_STATIC_LIBRARY_SUFFIX} CACHE INTERNAL "Suffix for CMake libraries")
elseif (${LIBRARY_TYPE} STREQUAL "SHARED")
  set (CMAKE_LIBRARY_PREFIX ${CMAKE_SHARED_LIBRARY_PREFIX} CACHE INTERNAL "Prefix for CMake libraries")
  set (CMAKE_LIBRARY_SUFFIX ${CMAKE_SHARED_LIBRARY_SUFFIX} CACHE INTERNAL "Suffix for CMake libraries")
endif (${LIBRARY_TYPE} STREQUAL "STATIC")


# Check that when using GNU Fortran the free form flag is passed
if ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
  include( GNU_Fortran_Flags )
elseif ( CMAKE_Fortran_COMPILER_ID STREQUAL Intel )
  include( Intel_Fortran_Flags )
endif ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )

libfind_detect ( MCFOR FIND_PATH lib_checking.mod INCLUDE_DIRS ${CMAKE_INSTALL_PREFIX}/include FIND_LIBRARY astrofortran LIBRARY_DIRS ${CMAKE_INSTALL_PREFIX}/lib NO_DEFAULT_PATH ${CMAKE_NO_DEFAULT_PATH} )


if ( NOT MCFOR_FOUND )
  include( External_MCFOR )
endif ( NOTMCFOR_FOUND )

# *******************************************
# ************  LIBRARY *******************
# *******************************************

include_directories ( 
  ${MCFOR_INCLUDE_DIR}
  )

set ( LIBRARIES_LIST
  ${MCFOR_LIBRARIES}
  )

# Set library name
set ( PROGRAM_NAME hello_world )

# Where do we put the *mod files created during compilation?
set ( CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files )

# Source files used to build the library
FILE(GLOB SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
      "${CMAKE_CURRENT_SOURCE_DIR}/src/*.f90")

list(REMOVE_ITEM SRC_FILES src/hello_world.f90)

# BEAGLE
add_executable( ${PROGRAM_NAME}
  src/hello_world.f90
  ${SRC_FILES}
  )

# install binary
install(
  TARGETS ${PROGRAM_NAME} 
  RUNTIME 
  DESTINATION bin
)

# install header (*mod) files
install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ 
  DESTINATION include
)

