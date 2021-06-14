load(":cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "esp32",
    toolchains = {
        "xtensa": ":xtensa_toolchain",
    },
)

filegroup(name = "empty")

filegroup(
    name = "all_files",
    srcs = [
        ":cc_wrapper",
        ":xtensa-esp32-elf-ar",
        ":xtensa-esp32-elf-ld",
        "@esp32_toolchain//:sources",
        "@xtensa_esp32_elf_linux64//:compiler_pieces",
    ],
)

filegroup(
    name = "cc_wrapper",
    srcs = ["cc_wrapper.sh"],
)

cc_toolchain(
    name = "xtensa_toolchain",
    all_files = ":all_files",
    ar_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":empty",
    linker_files = ":all_files",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":xtensa_toolchain_config",
    toolchain_identifier = "xtensa-toolchain",
)

cc_toolchain_config(name = "xtensa_toolchain_config")
