# linux_common_notes
## Добавление папки в path
- Открывааем терминал в домашней директории и вводим
`$ gedit .bashrc`

- Добавляем в конце файла
`export PATH=$PATH:/opt/Qt/5.15.2/gcc_64/bin`

- Перезапускаем bashrc
`$ source ~/.bashrc`

---

## Установка arm-none-eabi
-Распаковка архива
`$ tar xjf ~/Downloads/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2`

-Добавление в path
`export PATH=$PATH:$HOME/local/gcc-arm-none-eabi-7-2017-q4-major/bin`

---

## Запоминание последней запущенной ОС grub

`$ gedit /etc/default/grub`

`GRUB_SAVEDEFAULT=true
 GRUB_DEFAULT="saved"`

`$ update-grub2`

---

## Сокрытие директории (snap)

`echo snap >> ~/.hidden`

---
## Изменение прав доступа (opt)

`sudo chmod +x /opt`\
`sudo chown -R sadekov:sadekov /opt`

---
