# bazel_esp32

This repo contains a custom c++ toolchain setup for the [bazel](https://bazel.build) build system. It allows you to use the standard `cc_library` and `cc_binary` to build esp32-compatible binaries.

Note that these rules are currently only supported on amd64 linux systems. Pull requests are welcome to add support for other systems.

## Usage

In your `WORKSPACE` file load the toolchain dependencies:

```
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "bazel_esp32",
    branch = "main",
    remote = "https://github.com/simonhorlick/bazel_esp32.git",
)

load("@bazel_esp32//:deps.bzl", "bazel_esp32_dependencies")

bazel_esp32_dependencies()
```

Add the toolchain configuration to your `.bazelrc` in the root of your repository:

```
build:esp32 --crosstool_top=@bazel_esp32//toolchain:esp32
build:esp32 --cpu=xtensa
build:esp32 --host_crosstool_top=@bazel_tools//tools/cpp:toolchain
```

In this example, `hello.cc` contains the standard Arduino `setup` and `loop` functions. To build a binary that we can run we must add the Arduino `main.cc` into the `cc_binary` srcs which in turn calls out to `setup` and `loop`.

```
cc_binary(
    name = "hello",
    srcs = ["@arduino_esp32//:cores/esp32/main.cpp"],  # main entry point.
    deps = [
        ":hello_lib",
        "@arduino_esp32//:core_c_lib",
        "@arduino_esp32//:core_lib",
    ],
)

cc_library(
    name = "hello_lib",
    srcs = ["hello.cc"],
    deps = [
        # note that Arduino libraries must be specified as normal c++ dependencies.
        "@arduino_esp32//:SPI",
    ],
)
```

To build ensure you are using the `esp32` configuration, like so:
```bash
$ bazel build --config=esp32 //:hello
INFO: Analyzed target //:hello (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:hello up-to-date:
  bazel-bin/hello
INFO: Elapsed time: 0.610s, Critical Path: 0.01s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action

$ file bazel-bin/hello
bazel-bin/hello: ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
```

## Examples

To flash a device:
```bash
bazel build --config=esp32 //:gen_partitions
bazel build --config=esp32 //:gen_image
esptool.py --chip esp32 -p /dev/cu.usbserial-0001 --baud 460800 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0xe000 /home/simon/.arduino15/packages/esp32/hardware/esp32/2.0.0-alpha1/tools/partitions/boot_app0.bin 0x1000 /home/simon/.arduino15/packages/esp32/hardware/esp32/2.0.0-alpha1/tools/sdk/esp32/bin/bootloader_qio_80m.bin 0x10000 bazel-bin/hello.bin 0x8000 bazel-bin/hello.partitions.bin
```
