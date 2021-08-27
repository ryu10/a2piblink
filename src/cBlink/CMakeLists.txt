cmake_minimum_required(VERSION 3.0)

project(a2pi_cblink_project C ASM)

set(source_files
    src/main.c
    src/sleep.c
    src/text.s
    src/wait.s
)

set(linker_config_file "${CMAKE_SOURCE_DIR}/src/apple2.cfg")
set(linker_library_path "/usr/local/share/cc65/lib")
set(compiler_include_path "/usr/local/share/cc65/include")

add_executable(a2pi_cblink ${source_files})

set_target_properties(a2pi_cblink
    PROPERTIES
        OUTPUT_NAME CBLINK
        COMPILE_FLAGS "-t apple2 "
        LINK_FLAGS "-t apple2 -C ${linker_config_file} -L ${linker_library_path} "
)

# The linker configuration file needs to be a dependency of one of the source files,
# otherwise rebuild won't be triggered when the linker configuration changes.
set_source_files_properties(src/text.s src/wait.s PROPERTIES OBJECT_DEPENDS ${linker_config_file})
