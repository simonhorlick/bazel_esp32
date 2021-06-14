#!/bin/bash

# Ugh. Switch compiler based on the presence of the -std=gnu99 flag.
if [[ "$*" == *gnu99* ]]
then
  echo "Detected C"
  exec /home/simon/.arduino15/packages/esp32/tools/xtensa-esp32-elf-gcc/gcc8_4_0-esp-2020r3/bin/xtensa-esp32-elf-gcc "$@"
elif [[ "$*" == *esp32.rom.ld* ]]
then
  echo "Detected LD"
  exec /home/simon/.arduino15/packages/esp32/tools/xtensa-esp32-elf-gcc/gcc8_4_0-esp-2020r3/bin/xtensa-esp32-elf-g++ "$@"
else
  echo "Detected C++"
  exec /home/simon/.arduino15/packages/esp32/tools/xtensa-esp32-elf-gcc/gcc8_4_0-esp-2020r3/bin/xtensa-esp32-elf-g++ "$@"
fi
