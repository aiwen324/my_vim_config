# Some config files vim also bash

- For Chinese Input Source, checkout fcitx5, it is very close Windows10 Native input experience now.

## Some bash config in vim
```bash
alias vim='PYTHONPATH="" vim' # Fix for bad Python Path
```

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
