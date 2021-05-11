## Добавление папки в path
- open terminal in home directory
$ gedit .bashrc

- append those lines
export PATH=$PATH:/opt/Qt/5.15.2/gcc_64/bin

-arm-none-eabi
$ tar xjf ~/Downloads/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
export PATH=$PATH:$HOME/local/gcc-arm-none-eabi-7-2017-q4-major/bin

- reload bashrc
$ source ~/.bashrc
-------------------------------------------

## Запоминание последней запущенной ОС grub
$ gedit /etc/default/grub

GRUB_SAVEDEFAULT=true
GRUB_DEFAULT="saved"

$ update-grub2
-------------------------------------------

## Сокрытие директории
echo snap >> ~/.hidden
-------------------------------------------
