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
