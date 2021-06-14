# bazel_esp32

To build, run:
```bash
bazel build --config=esp32 //:hello
```

To flash a device:
```bash
bazel build --config=esp32 //:gen_partitions
bazel build --config=esp32 //:gen_image
esptool.py --chip esp32 -p /dev/cu.usbserial-0001 --baud 460800 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0xe000 /home/simon/.arduino15/packages/esp32/hardware/esp32/2.0.0-alpha1/tools/partitions/boot_app0.bin 0x1000 /home/simon/.arduino15/packages/esp32/hardware/esp32/2.0.0-alpha1/tools/sdk/esp32/bin/bootloader_qio_80m.bin 0x10000 bazel-bin/hello.bin 0x8000 bazel-bin/hello.partitions.bin
```
