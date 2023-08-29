cmake_minimum_required(VERSION 3.18)

set(project_name "pcap-decoder")
project(${project_name}-exe C CXX)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "Set to 11 or 14 to enable C++11, C++14, C++17 or C++20 builds, respectively." FORCE)
set(CMAKE_C_STANDARD 11 CACHE STRING "Set to 99 or 11 to enable C99 or C11 builds, respectively." FORCE)
set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED ON)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(external/InitializeExternalComponents.cmake)

file(GLOB SRC functions.c tls_ssl.c rtp.c rtcp.c diameter.c ngcp.c rtsp.c)

add_executable(${project_name} decoder.c ${SRC})

target_link_libraries(${project_name}
    PRIVATE libpcap::libpcap
    PRIVATE OpenSSL::SSL
    PRIVATE OpenSSL::Crypto
)

if (NEED_LINKING_AGAINST_LIBM)
    target_link_libraries(${project_name}
        PRIVATE m
    )
endif()