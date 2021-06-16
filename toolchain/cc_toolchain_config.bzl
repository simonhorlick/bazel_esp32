load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

# This file has been written based off the variable definitions in the following
# files:
#  - https://github.com/espressif/arduino-esp32/blob/1.0.6/platform.txt
#  - https://github.com/espressif/arduino-esp32/blob/1.0.6/boards.txt

BUILD_F_CPU = "240000000L"
RUNTIME_IDE_VERSION = "10607"
BUILD_BOARD = "ESP32_DEV"
BUILD_ARCH = "ESP32"
BUILD_VARIANT = "esp32"

BUILD_EXTRA_FLAGS = [
    "-DF_CPU=" + BUILD_F_CPU,
    "-DARDUINO=" + RUNTIME_IDE_VERSION,
    "-DARDUINO_" + BUILD_BOARD,
    "-DARDUINO_ARCH_" + BUILD_ARCH,
    "-DARDUINO_BOARD=\"" + BUILD_BOARD + "\"",
    "-DARDUINO_VARIANT=\"" + BUILD_VARIANT + "\"",
    "-DESP32=1",
]

RUNTIME_PLATFORM_PATH = "external/arduino_esp32"
COMPILER_SDK_PATH = RUNTIME_PLATFORM_PATH + "/tools/sdk"

INCLUDE_DIRS = [
    "include/config",
    "include/app_trace",
    "include/app_update",
    "include/asio",
    "include/bootloader_support",
    "include/bt",
    "include/coap",
    "include/console",
    "include/driver",
    "include/efuse",
    "include/esp-tls",
    "include/esp32",
    "include/esp_adc_cal",
    "include/esp_event",
    "include/esp_http_client",
    "include/esp_http_server",
    "include/esp_https_ota",
    "include/esp_https_server",
    "include/esp_ringbuf",
    "include/esp_websocket_client",
    "include/espcoredump",
    "include/ethernet",
    "include/expat",
    "include/fatfs",
    "include/freemodbus",
    "include/freertos",
    "include/heap",
    "include/idf_test",
    "include/jsmn",
    "include/json",
    "include/libsodium",
    "include/log",
    "include/lwip",
    "include/mbedtls",
    "include/mdns",
    "include/micro-ecc",
    "include/mqtt",
    "include/newlib",
    "include/nghttp",
    "include/nvs_flash",
    "include/openssl",
    "include/protobuf-c",
    "include/protocomm",
    "include/pthread",
    "include/sdmmc",
    "include/smartconfig_ack",
    "include/soc",
    "include/spi_flash",
    "include/spiffs",
    "include/tcp_transport",
    "include/tcpip_adapter",
    "include/ulp",
    "include/unity",
    "include/vfs",
    "include/wear_levelling",
    "include/wifi_provisioning",
    "include/wpa_supplicant",
    "include/xtensa-debug-module",
    "include/esp-face",
    "include/esp32-camera",
    "include/esp-face",
    "include/fb_gfx",
]

COMPILER_CPREPROCESSOR_FLAGS = [
    "-DESP_PLATFORM",
    "-DMBEDTLS_CONFIG_FILE=\"mbedtls/esp_config.h\"",
    "-DHAVE_CONFIG_H",
    "-DGCC_NOT_5_2_0=0",
    "-DWITH_POSIX",
] + ["-I" + COMPILER_SDK_PATH + "/" + p for p in INCLUDE_DIRS] + [
    "-I" + RUNTIME_PLATFORM_PATH + "/cores/esp32",
    "-I" + RUNTIME_PLATFORM_PATH + "/variants/esp32",
]

COMPILER_WARNING_FLAGS = ["-Wall"]

COMPILER_C_FLAGS = [
    "-std=gnu99",
    "-Os",
    "-g3",
    "-fstack-protector",
    "-ffunction-sections",
    "-fdata-sections",
    "-fstrict-volatile-bitfields",
    "-mlongcalls",
    "-nostdlib",
    "-Wpointer-arith",
] + COMPILER_WARNING_FLAGS + [
    "-Wno-maybe-uninitialized",
    "-Wno-unused-function",
    "-Wno-unused-but-set-variable",
    "-Wno-unused-variable",
    "-Wno-deprecated-declarations",
    "-Wno-unused-parameter",
    "-Wno-sign-compare",
    "-Wno-old-style-declaration",
    "-MMD",
    "-c",
]

COMPILER_CPP_FLAGS = [
    "-std=gnu++11",
    "-Os",
    "-g3",
    "-Wpointer-arith",
    "-fexceptions",
    "-fstack-protector",
    "-ffunction-sections",
    "-fdata-sections",
    "-fstrict-volatile-bitfields",
    "-mlongcalls",
    "-nostdlib",
] + COMPILER_WARNING_FLAGS + [
    "-Wno-error=maybe-uninitialized",
    "-Wno-error=unused-function",
    "-Wno-error=unused-but-set-variable",
    "-Wno-error=unused-variable",
    "-Wno-error=deprecated-declarations",
    "-Wno-unused-parameter",
    "-Wno-unused-but-set-parameter",
    "-Wno-missing-field-initializers",
    "-Wno-sign-compare",
    "-fno-rtti",
    "-MMD",
    "-c",
]

COMPILER_C_ELF_FLAGS = [
    "-nostdlib",
    "-L" + COMPILER_SDK_PATH + "/lib",
    "-L" + COMPILER_SDK_PATH + "/ld",
    "-T",
    "esp32_out.ld",
    "-T",
    "esp32.project.ld",
    "-T",
    "esp32.rom.ld",
    "-T",
    "esp32.peripherals.ld",
    "-T",
    "esp32.rom.libgcc.ld",
    "-T",
    "esp32.rom.spiram_incompatible_fns.ld",
    "-u",
    "esp_app_desc",
    "-u",
    "ld_include_panic_highint_hdl",
    "-u",
    "call_user_start_cpu0",
    "-Wl,--gc-sections",
    "-Wl,-static",
    "-Wl,--undefined=uxTopUsedPriority",
    "-u",
    "__cxa_guard_dummy",
    "-u",
    "__cxx_fatal_exception",
]

COMPILER_C_ELF_LIBS = [
    "-lgcc",
    "-lesp_websocket_client",
    "-lwpa2",
    "-ldetection",
    "-lesp_https_server",
    "-lwps",
    "-lhal",
    "-lconsole",
    "-lpe",
    "-lsoc",
    "-lsdmmc",
    "-lpthread",
    "-llog",
    "-lesp_http_client",
    "-ljson",
    "-lmesh",
    "-lesp32-camera",
    "-lnet80211",
    "-lwpa_supplicant",
    "-lc",
    "-lmqtt",
    "-lcxx",
    "-lesp_https_ota",
    "-lulp",
    "-lefuse",
    "-lpp",
    "-lmdns",
    "-lbt",
    "-lwpa",
    "-lspiffs",
    "-lheap",
    "-limage_util",
    "-lunity",
    "-lrtc",
    "-lmbedtls",
    "-lface_recognition",
    "-lnghttp",
    "-ljsmn",
    "-lopenssl",
    "-lcore",
    "-lfatfs",
    "-lm",
    "-lprotocomm",
    "-lsmartconfig",
    "-lxtensa-debug-module",
    "-ldl",
    "-lesp_event",
    "-lesp-tls",
    "-lfd",
    "-lespcoredump",
    "-lesp_http_server",
    "-lfr",
    "-lsmartconfig_ack",
    "-lwear_levelling",
    "-ltcp_transport",
    "-llwip",
    "-lphy",
    "-lvfs",
    "-lcoap",
    "-lesp32",
    "-llibsodium",
    "-lbootloader_support",
    "-ldriver",
    "-lcoexist",
    "-lasio",
    "-lod",
    "-lmicro-ecc",
    "-lesp_ringbuf",
    "-ldetection_cat_face",
    "-lapp_update",
    "-lespnow",
    "-lface_detection",
    "-lapp_trace",
    "-lnewlib",
    "-lbtdm_app",
    "-lwifi_provisioning",
    "-lfreertos",
    "-lfreemodbus",
    "-lethernet",
    "-lnvs_flash",
    "-lspi_flash",
    "-lc_nano",
    "-lexpat",
    "-lfb_gfx",
    "-lprotobuf-c",
    "-lesp_adc_cal",
    "-ltcpip_adapter",
    "-lstdc++",
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "cc_wrapper.sh",
        ),
        tool_path(
            name = "ld",
            path = "xtensa-esp32-elf-ld",
        ),
        tool_path(
            name = "ar",
            path = "xtensa-esp32-elf-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/bin/false",
        ),
    ]

    default_compile_flags_feature = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-DCOMPILING_AS_CPP_NOT_C",
                        ] + COMPILER_CPREPROCESSOR_FLAGS + COMPILER_CPP_FLAGS + BUILD_EXTRA_FLAGS,
                    ),
                ],
            ),
        ],
    )

    default_c_compile_flags_feature = feature(
        name = "default_c_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.c_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-DCOMPILING_AS_C_NOT_CPP",
                        ] + COMPILER_CPREPROCESSOR_FLAGS + COMPILER_C_FLAGS + BUILD_EXTRA_FLAGS,
                    ),
                ],
            ),
        ],
    )

    all_link_actions = [
        ACTION_NAMES.cpp_link_executable,
        ACTION_NAMES.cpp_link_dynamic_library,
        ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ]

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = COMPILER_C_ELF_FLAGS + ["-Wl,--start-group"] + COMPILER_C_ELF_LIBS +
                                [
                                    "-Wl,--end-group",
                                    "-Wl,-EL",
                                ],
                    ),
                ],
            ),
        ],
    )

    features = [
        default_compile_flags_feature,
        default_c_compile_flags_feature,
        default_link_flags_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        cxx_builtin_include_directories = [
            "external/xtensa_esp32_elf_linux64/xtensa-esp32-elf/sys-include",
            "external/xtensa_esp32_elf_linux64/xtensa-esp32-elf/include/c++/5.2.0",
            "external/xtensa_esp32_elf_linux64/lib/gcc/xtensa-esp32-elf/5.2.0/include-fixed",
            "external/xtensa_esp32_elf_linux64/lib/gcc/xtensa-esp32-elf/5.2.0/include",
            RUNTIME_PLATFORM_PATH + "/cores/esp32",
            RUNTIME_PLATFORM_PATH + "/variants/esp32",
        ] + [COMPILER_SDK_PATH + "/" + p for p in INCLUDE_DIRS],
        features = features,
        toolchain_identifier = "xtensa-toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "xtensa",
        target_libc = "unknown",
        compiler = "cpp",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
