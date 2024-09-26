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
