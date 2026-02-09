# Some config files vim also bash

- For Chinese Input Source, checkout fcitx5, it is very close Windows10 Native input experience now.

## Some bash config in vim
```bash
alias vim='PYTHONPATH="" vim' # Fix for bad Python Path
```
## GRUB Related
To make sure grub can be loaded, we can add a fallback solution if Windows keep modifying boot entry, copy `grubx64.efi` to `EFI/BOOT/BOOTX64.EFI` under `/boot/efi`

## Steam LD config in China with proxy
```bash
alias steam="LD_PRELOAD=\"/usr/lib/libgio-2.0.so.0 /usr/lib/libglib-2.0.so.0\" steam"
alias steam_update="LD_PRELOAD=\"\" steam"
```

## Kill process by grep
```
ps -ef |grep <process keywords> | grep yai |grep -v grep |awk '{print $2}' | xargs -r kill -9
```

## Combine pdf
```
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=<output_pdf> <pdf_1> <pdf_2> ...
# Change PDFSETTINGS for smaller size
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
   -dQUIET -dDetectDuplicateImages \
   -dCompressFonts=true -o <output_pdf> <pdf_1> <pdf_2> ...
```

## Powershell X-forwarding
**Notice**: You still need an X-server to use this feature. So it's better to just use WSL2
```powershell
$env:DISPLAY = "localhost:0.0“
echo $env:DISPLAY
```

## Arch Linux Update Signature Issue
```bash
sudo pacman -Sy archlinux-keyring && pacman -Syu
```

## GDM White Screen Issue
Try this it solved the issue once for me
```bash
sudo -u gdm dbus-run-session gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
```

## Enable Wayland
1. Create `/etc/modprobe.d/nvidia.conf`. Put following into the file:

   ```
   options nvidia NVreg_PreserveVideoMemoryAllocations=1
   options nvidia_drm modeset=1
   ```
2. Modify `/etc/mkinitcpio.conf`
   - `MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)` and `FILES=(/etc/modprobe.d/nvidia.conf)`.
   - Remove `kms` from `HOOKS` according to https://wiki.archlinux.org/title/NVIDIA#Installation. I don't think this is necessary unless `nouveau` is installed
3. Enable `nvidia-suspend.service, nvidia-hibernate.service, and nvidia-resume.service` according to https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks
4. Run `sudo mkinitcpio -P` to rebuild initial ramdisk
5. Create a hook file `/etc/pacman.d/hooks/nvidia.hook` for `nvidia` to auto rebuild ramdisk everytime the package gets updated.

   ```
   [Trigger]
   Operation=Install
   Operation=Upgrade
   Operation=Remove
   Type=Package
   # Uncomment the installed NVIDIA package
   Target=nvidia
   #Target=nvidia-open
   #Target=nvidia-lts
   # If running a different kernel, modify below to match
   Target=linux
   
   [Action]
   Description=Updating NVIDIA module in initcpio
   Depends=mkinitcpio
   When=PostTransaction
   NeedsTargets
   Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
   ```

## How to inspect executable file binary

`od -A x -t x1 -j 0x28 -N 4 hello` (type `man od` for more info about `od`. It's a UNIX command line tool)
- `-A x` tells od to display the address (which is the left most column) in hexadecimal.
- `-t x1` specifies that each byte should be displayed as a hexadecimal value.
- `-j 0x28` skips the first 0x28 (40 decimal) bytes before starting to read and display the file content.
- `-N 4` limits the output to 4 bytes, so only 4 bytes after the specified skip will be read and displayed.
- `hello` is the name of your input file.

`od -A x -t x1 -j 0x2000 -N 17 hello`. Use this command you can verify this has similar output as `objdump -s -j .rodata hello`.

Also notice this ELF file is little endian. Use `readelf -h hello` you can verify this. Meaning, if you see the output of `od -A x -t x1 -j 0x28 -N 4 hello` is `000028 98 36 00 00`. And we know this is the address by the hint from the question. Therefore, this actually points to `0x00003698`. Endianness: https://en.wikipedia.org/wiki/Endianness. You can also verify this address is true by converting it to decimal which is `13976` and it is same as the output of `readelf -h hello` (Check `Start of section headers`). Check the specification of header in ELF64 (64bit) here. https://osdev.org/ELF#Header. `Section header table position` is actually 8 bytes btw. But in our program 0x2c --> 0x2f are all 0 so it doesn't matter `0x0000000000003698 == 0x00003698`.

```
readelf -h hello
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Position-Independent Executable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x1060
  Start of program headers:          64 (bytes into file)
  Start of section headers:          13976 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         13
  Size of section headers:           64 (bytes)
  Number of section headers:         31
  Section header string table index: 30
```
