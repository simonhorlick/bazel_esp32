load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def bazel_esp32_dependencies():
    # The cross compiler, tools and headers.
    http_archive(
        name = "xtensa_esp32_elf_linux64",
        build_file = "@bazel_esp32//:BUILD.esp32toolchain",
        sha256 = "96f5f6e7611a0ed1dc47048c54c3113fc5cebffbf0ba90d8bfcd497afc7ef9f3",
        strip_prefix = "xtensa-esp32-elf",
        urls = ["https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-97-gc752ad5-5.2.0.tar.gz"],
    )

    # The Arduino base libraries.
    http_archive(
        name = "arduino_esp32",
        build_file = "@bazel_esp32//:BUILD.esp32",
        strip_prefix = "esp32-1.0.6",
        sha256 = "982da9aaa181b6cb9c692dd4c9622b022ecc0d1e3aa0c5b70428ccc3c1b4556b",
        urls = ["https://github.com/espressif/arduino-esp32/releases/download/1.0.6/esp32-1.0.6.zip"],
    )
