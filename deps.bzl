load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def bazel_esp32_dependencies():
    # The cross compiler, tools and headers.
    http_archive(
        name = "xtensa_esp32_elf_linux64",
        build_file = "//:BUILD.esp32toolchain",
        sha256 = "674080a12f9c5ebe5a3a5ce51c6deaeffe6dfb06d6416233df86f25b574e9279",
        strip_prefix = "xtensa-esp32-elf",
        urls = ["https://dl.espressif.com/dl/xtensa-esp32-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz"],
    )
    
    # The Arduino base libraries.
    http_archive(
        name = "arduino_esp32",
        build_file = "//:BUILD.esp32",
        sha256 = "95e9e6b7ab6d245710f2deb9c911ab2f17c0ed0c6a6b20363ca8eae3f3006749",
        strip_prefix = "esp32-2.0.0-alpha1",
        urls = ["https://github.com/espressif/arduino-esp32/releases/download/2.0.0-alpha1/esp32-2.0.0-alpha1.zip"],
    )

