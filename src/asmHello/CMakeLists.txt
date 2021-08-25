cmake_minimum_required(VERSION 3.0)

project(a2pitest_asmhello_project ASM)

set(source_files
    src/hello.s
)

set(linker_config_file "${CMAKE_SOURCE_DIR}/src/apple2bin.cfg")

add_executable(a2pitest_asmhello ${source_files})

set_target_properties(a2pitest_asmhello
    PROPERTIES
        OUTPUT_NAME ASMHELLO
        COMPILE_FLAGS "-t apple2"
        LINK_FLAGS "-t apple2 -C ${linker_config_file}"
)

# The linker configuration file needs to be a dependency of one of the source files,
# otherwise rebuild won't be triggered when the linker configuration changes.
set_source_files_properties(src/text.s PROPERTIES OBJECT_DEPENDS ${linker_config_file})
