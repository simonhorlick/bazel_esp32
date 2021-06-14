#!/bin/bash

# Ugh. Switch compiler based on the presence of the -std=gnu99 flag.
if [[ "$*" == *gnu99* ]]
then
  exec ./external/xtensa_esp32_elf_linux64/bin/xtensa-esp32-elf-gcc "$@"
elif [[ "$*" == *esp32.rom.ld* ]]
then
  exec ./external/xtensa_esp32_elf_linux64/bin/xtensa-esp32-elf-g++ "$@"
else
  exec ./external/xtensa_esp32_elf_linux64/bin/xtensa-esp32-elf-g++ "$@"
fi
