cc_binary(
    name = "hello",
    srcs = ["@arduino_esp32//:cores/esp32/main.cpp"],  # main must depend on the library containing setup and loop.
    visibility = ["//visibility:public"],
    deps = [
        ":hello_lib",
        "@arduino_esp32//:core_c_lib",
        "@arduino_esp32//:core_lib",
    ],
)

cc_library(
    name = "hello_lib",
    srcs = ["hello.cc"],
    visibility = ["//visibility:public"],
    deps = [
        "@arduino_esp32//:SPI",
    ],
)

genrule(
    name = "gen_image",
    srcs = [":hello"],
    outs = ["hello.bin"],
    cmd = "python $(location @arduino_esp32//:esptool.py) --chip esp32 elf2image --flash_mode dio --flash_freq 80m --flash_size 4MB -o \"$@\" \"$<\"",
    tools = ["@arduino_esp32//:esptool.py"],
)

genrule(
    name = "gen_partitions",
    srcs = [],
    outs = ["hello.partitions.bin"],
    cmd = "python $(location @arduino_esp32//:gen_esp32part.py) $(location @arduino_esp32//:tools/partitions/min_spiffs.csv) \"$@\"",
    tools = [
        "@arduino_esp32//:gen_esp32part.py",
        "@arduino_esp32//:tools/partitions/min_spiffs.csv",
    ],
)
