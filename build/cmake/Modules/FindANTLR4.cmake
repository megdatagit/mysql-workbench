#
# - Find antlr
# Find the native ANTLR4 includes and library
#
#  ANTLR4_INCLUDE_DIRS - where to find sqlite/connection.hpp, etc.
#  ANTLR4_LIBRARIES    - List of libraries when using pcre.
#  ANTLR4_FOUND        - True if pcre found.


IF (ANTLR4_INCLUDE_DIRS)
  # Already in cache, be silent
  SET(ANTLR4_FIND_QUIETLY TRUE)
ENDIF (ANTLR4_INCLUDE_DIRS)

FIND_PATH(ANTLR4_INCLUDE_DIR antlr4-runtime/antlr4-runtime.h HINTS ${ANTLR4_INCLUDE_DIRS})

SET(ANTLR4_NAMES antlr4-runtime)

if(ANTLR4_LIBRARIES)
  # Converto to a list of library argments
  string(REPLACE " " ";" ANTLR4_LIB_ARGS ${ANTLR4_LIBRARIES})
  # Parse the list in order to find the library path
  foreach(ANTLR4_LIB_ARG ${ANTLR4_LIB_ARGS})
    string(REPLACE "-L" "" ANTLR4_LIB_ARG_CLEAR ${ANTLR4_LIB_ARG})
    if(NOT ${ANTLR4_LIB_ARG_CLEAR} STREQUAL ${ANTLR4_LIB_ARG})
      set(ANTLR4_SUPPLIED_LIB_DIR ${ANTLR4_LIB_ARG_CLEAR})
    endif()
  endforeach(ANTLR4_LIB_ARG)
  find_library(ANTLR4_LIBRARY NAMES ${ANTLR4_NAMES} HINTS ${ANTLR4_SUPPLIED_LIB_DIR})
  
  unset(ANTLR4_LIB_ARG_CLEAR)
  unset(ANTLR4_LIB_ARG)
  unset(ANTLR4_LIB_ARGS)
else()
  find_library(ANTLR4_LIBRARY NAMES ${ANTLR4_NAMES})
endif()

# handle the QUIETLY and REQUIRED arguments and set ANTLR4_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ANTLR4 DEFAULT_MSG ANTLR4_LIBRARY ANTLR4_INCLUDE_DIR)

IF(ANTLR4_FOUND)
  get_filename_component(ANTLR4_LIB_FILENAME ${ANTLR4_LIBRARY} NAME_WE)
  get_filename_component(ANTLR4_LIB_DIRECTORY ${ANTLR4_LIBRARY} PATH)
  get_filename_component(ANTLR4_LIB_BASE_DIRECTORY ${ANTLR4_LIB_DIRECTORY} PATH)
  set(ANTLR4_INCLUDE_DIR ${ANTLR4_INCLUDE_DIR}/antlr4-runtime) 
  SET( ANTLR4_LIBRARIES "-L${ANTLR4_LIB_DIRECTORY} -l${ANTLR4_NAMES}" )
  SET( ANTLR4_INCLUDE_DIRS ${ANTLR4_INCLUDE_DIR} )
ELSE(ANTLR4_FOUND)
  SET( ANTLR4_LIBRARIES )
  SET( ANTLR4_INCLUDE_DIRS )
ENDIF(ANTLR4_FOUND)

message("ANTLR4 INCLUDE DIR: ${ANTLR4_INCLUDE_DIRS}")
message("ANTLR4 LIB DIR: ${ANTLR4_LIBRARIES}")

MARK_AS_ADVANCED( ANTLR4_LIBRARIES ANTLR4_INCLUDE_DIRS )
