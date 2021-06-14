load(":cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "esp32",
    toolchains = {
        "xtensa": ":xtensa_toolchain",
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "xtensa_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":xtensa_toolchain_config",
    toolchain_identifier = "xtensa-toolchain",
)

cc_toolchain_config(name = "xtensa_toolchain_config")
