# Добавление QT в PATH

- open terminal in home directory
`$ gedit .bashrc`

- append those lines
`export PATH=$PATH:/opt/Qt/5.15.2/gcc_64/bin`
`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/Qt/5.15.2/gcc_64/lib`
`export QTDIR=/opt/Qt/5.15.2/gcc_64`

- arm-none-eabi (optional)
`export PATH=$PATH:$HOME[arm-none-eabi-path]`

- reload bashrc
`$ source ~/.bashrc`

---
