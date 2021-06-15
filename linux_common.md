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
## Общие устройства bluetooth linux+windows
How to fix

Using the instructions below, we'll first pair your Bluetooth devices with Ubuntu/Linux Mint, and then we'll pair Windows. Then we'll go back into our Linux system and copy the Windows-generated pairing key(s) into our Linux system.

    Pair all devices w/ Mint/Ubuntu
    Pair all devices w/ Windows
    Copy your Windows pairing keys in one of two ways:

        Use psexec -s -i regedit.exe from Windows (harder)
            Go to "Device & Printers" in Control Panel and go to your Bluetooth device's properties. Then, in the Bluetooth section, you can find the unique identifier. Copy that (you will need it later).
            Download PsExec from http://technet.microsoft.com/en-us/sysinternals/bb897553.aspx.
            Unzip the zip you downloaded and open a cmd window with elevated privileges. (Click the Start menu, search for cmd, then right-click the CMD and click "Run as Administrator".)
            cd into the folder where you unzipped your download.
            Run psexec -s -i regedit.exe
            Navigate to find the keys at HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\BTHPORT\Parameters\Keys.  If there is no CurrentControlSet, try ControlSet001.
            You should see a few keys labels with the MAC addresses - write down the MAC address associated with the unique identifier you copied before.

        Use chntpw from your Linux distro (easier). Start in a terminal then:

            sudo apt-get install chntpw

            Mount your Windows system drive

            cd /[WindowsSystemDrive]/Windows/System32/config

            chntpw -e SYSTEM opens a console

            Run these commands in that console:

            > cd CurrentControlSet\Services\BTHPORT\Parameters\Keys
            > cd ControlSet001\Services\BTHPORT\Parameters\Keys
            > # if there is no CurrentControlSet, then try ControlSet001
            > # on Windows 7, "services" above is lowercased.
            > ls
            # shows you your Bluetooth port's MAC address
            Node has 1 subkeys and 0 values
              key name
              <aa1122334455>
            > cd aa1122334455  # cd into the folder
            > ls  
            # lists the existing devices' MAC addresses
            Node has 0 subkeys and 1 values
              size     type            value name             [value if type DWORD]
                16  REG_BINARY        <001f20eb4c9a>
            > hex 001f20eb4c9a
            => :00000 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX ...ignore..chars..
            # ^ the XXs are the pairing key

            Make a note of which Bluetooth device MAC address matches which pairing key. The Mint/Ubuntu one won't need the spaces in-between.  Ignore the :00000.
    Go back to Linux (if not in Linux) and add our Windows key to our Linux config entries. Just note that the Bluetooth port's MAC address is formatted differently when moving from Windows to Linux - referenced as aa1122334455 in Windows in my example above. The Linux version will be in all caps and punctuated by ':' after every two characters - for example AA:11:22:33:44:55.  Based on your version of Linux, you can do one of these:
        Before Mint 18/16.04 you could do this:

            sudo edit /var/lib/bluetooth/[MAC address of Bluetooth]/linkkeys - [the MAC address of Bluetooth] should be the only folder in that Bluetooth folder.

            This file should look something like this:

            [Bluetooth MAC]   [Pairing key]                 [digits in pin]  [0]
            AA:11:22:33:44:55 XXXXXXXXxxXXxXxXXXXXXxxXXXXXxXxX 5 0
            00:1D:D8:3A:33:83 XXXXXXXXxxXXxXxXXXXXXxxXXXXXxXxX 4 0

            Change the Linux pairing key to the Windows one, minus the spaces.
        In Mint 18 (and Ubuntu 16.04) you may have to do this:

            Switch to root: su -

            cd to your Bluetooth config location /var/lib/bluetooth/[bth port  MAC addresses]

            Here you'll find folders for each device you've paired with. The folder names being the Bluetooth devices' MAC addresses and contain a single file info. In these files, you'll see the link key you need to replace with your Windows ones, like so:

            [LinkKey]
            Key=B99999999FFFFFFFFF999999999FFFFF

    Once updated, restart your Bluetooth service in one of the following ways, and then it works!

        Ubuntu, Mint, Arch:

        sudo systemctl restart Bluetooth 

        Alternatively, reboot your machine into Linux.
    Reboot into Windows - it works!
---

## Чтобы не сбивалось время при dualboot

В Windows:
Дальше наберите команду для 32 битных систем:

> Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1

А для 64-битных, нужно использовать тип значения  REG_QWORD:

> Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_QWORD /d 1
> sc config w32time start= disabled
> 

В linux:
 sudo timedatectl set-local-rtc 1 --adjust-system-clock
 sudo timedatectl
  sudo sed -i 's/UTC=yes/UTC=no/' /etc/default/rcS
  /etc/default/rcS и заменить UTC=yes на UTC=no. 
  
## Если не работают usb в virtualBox под ubuntu
 - Установить extension pack
 - В терминале ввести:
`sudo gpasswd -a yourusername vboxusers`
 - Выйти из системы и залогиниться вновь



## Делаем чтобы USB COM порт был доступен простому пользователю Linux
Опубликовано lamazavr - вс, 01/25/2015 - 15:20
Body

По умолчанию udev в Linux системах настроен так, что не дает обычному пользователю системы пользоваться COM портами. Под это правило попадает и USB-COM переходник на ft232.
Это конечно во многих случаях оправдано, но сильно надоедает. Ведь так нужно запускать терминал от root.
Избежать этого очень просто. Нужно поменять правила системы udev.

Изначально у меня права такие:
$ ls -l /dev/ | grep USB
crw-------. 1 root root      188,   0 янв 25 15:04 ttyUSB0

Сначала нужно узнать VendorID и ProductID нашего переходника. Это можно сделать такой командой:
$ lsusb | grep UART
Bus 003 Device 011: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC

Пара чисел здесь и есть нужные нам значения.
Теперь создаем файл в /etc/udev/rules.d/
sudo vim /etc/udev/rules.d/10-ft232.rules

И добавляем туда такое содержимое (изменяем если нужно idVendor и idProduct):

SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", \
    MODE:="0666", GROUP:="users",\
    SYMLINK+="ft232_%n"

Этой записью мы устанавливаем на USB устройство 0403:6001 права на запись и чтение обычным пользователям. А также говорим udev создавать символьную ссылку на него с именем ft232_номер.

Перезагружаем udev.
sudo udevadm control --reload-rules

Теперь проверяем права на наше устройство.
$ ls -l /dev/ | grep USB
lrwxrwxrwx. 1 root root             7 янв 25 15:09 ft232_0 -> ttyUSB0
crw-rw-rw-. 1 root users     188,   0 янв 25 15:09 ttyUSB0

Все прописалось. Можно использовать.
Еще раз проверяем права:
$ ls -l /dev/ | grep USB
lrwxrwxrwx. 1 root root             7 янв 25 15:09 ft232_0 -> ttyUSB0
crw-rw-rw-. 1 root users     188,   0 янв 25 15:09 ttyUSB0

