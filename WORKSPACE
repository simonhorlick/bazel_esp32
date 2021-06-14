workspace(name = "helloworld")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
  name = "esp32_toolchain",
  build_file = "@//:BUILD.esp32",
  strip_prefix = "esp32-2.0.0-alpha1",
  url = "https://github.com/espressif/arduino-esp32/releases/download/2.0.0-alpha1/esp32-2.0.0-alpha1.zip",
)
