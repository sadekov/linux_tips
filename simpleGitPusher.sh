#!/bin/bash
echo -e "\e[31m~~~ git-пушер ~~~\e[0m"

# Чтобы не запрашивал логин-пароль постоянно
git config credential.helper store

echo -e "\e[34mДобавляем...\e[0m"
git add . && \
#git add -u && \

echo -e "\e[36mВведите комментарий: \e[0m" 
read -r commitString
commitStringLength=${#commitString}

echo -e "\e[34mКомитим...\e[0m"
if [[ $commitStringLength -gt 2 ]]
then
  git commit -m"$commitString"
else
  echo -e "\e[36mКоммент - wip\e[0m"
  git commit -m"wip"
fi

#echo -e "\e[34mПушим?\e[0m"
#read -r ent
echo -e "\e[34mПушим...\e[0m"
git push 

echo -e "\e[32mДля продолжения нажмите ввод...\e[0m"
read -r ent
# 1 -t 5 -n 1 -s
