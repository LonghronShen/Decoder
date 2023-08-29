find_package(Threads REQUIRED)
find_package(OpenSSL REQUIRED)

set(FETCHCONTENT_UPDATES_DISCONNECTED ON CACHE STRING "FETCHCONTENT_UPDATES_DISCONNECTED" FORCE)

include(FetchContent)

include(CheckFunctionExists)

if(NOT POW_FUNCTION_EXISTS AND NOT NEED_LINKING_AGAINST_LIBM)
  CHECK_FUNCTION_EXISTS(pow POW_FUNCTION_EXISTS)
  if(NOT POW_FUNCTION_EXISTS)
      unset(POW_FUNCTION_EXISTS CACHE)
      list(APPEND CMAKE_REQUIRED_LIBRARIES m)
      CHECK_FUNCTION_EXISTS(pow POW_FUNCTION_EXISTS)
      if(POW_FUNCTION_EXISTS)
          set(NEED_LINKING_AGAINST_LIBM True CACHE BOOL "" FORCE)
      else()
          message(FATAL_ERROR "Failed making the pow() function available")
      endif()
  endif()
endif()

# cmake_extensions
FetchContent_Declare(cmake_extensions
  GIT_REPOSITORY https://github.com/bro/cmake.git
  GIT_TAG master)

FetchContent_GetProperties(cmake_extensions)
if(NOT cmake_extensions_POPULATED)
  FetchContent_Populate(cmake_extensions)
  list(APPEND CMAKE_MODULE_PATH "${cmake_extensions_SOURCE_DIR}")
endif()

find_package(PCAP)

add_library(libpcap::libpcap SHARED IMPORTED)
set_target_properties(libpcap::libpcap
    PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES ${PCAP_INCLUDE_DIR}
        IMPORTED_LOCATION ${PCAP_LIBRARY})