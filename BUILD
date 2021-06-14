cc_binary(
    name = "hello",
    visibility = ["//visibility:public"],
    srcs = ["@esp32_toolchain//:cores/esp32/main.cpp"], # main must depend on the library containing setup and loop.
    deps = [
        ":hello_lib",
        "@esp32_toolchain//:core_lib",
        "@esp32_toolchain//:core_c_lib",
    ],
)

cc_library(
    name = "hello_lib",
    srcs = ["hello.cc"],
    visibility = ["//visibility:public"],
)

genrule(
    name = "gen_image",
    srcs = [":hello"],
    outs = ["hello.bin"],
    cmd = "python /home/simon/.arduino15/packages/esp32/tools/esptool_py/3.0.0/esptool.py --chip esp32 elf2image --flash_mode dio --flash_freq 80m --flash_size 4MB -o \"$@\" \"$<\"",
)

genrule(
    name = "gen_partitions",
    srcs = [],
    outs = ["hello.partitions.bin"],
    cmd = "python /home/simon/.arduino15/packages/esp32/hardware/esp32/2.0.0-alpha1/tools/gen_esp32part.py /home/simon/.arduino15/packages/esp32/hardware/esp32/2.0.0-alpha1/tools/partitions/min_spiffs.csv \"$@\"",
)
