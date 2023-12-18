#!/bin/bash

guessed=0
not_guessed=0
guessed_numbers=()
turn=1

while true; do
    random_number=$((RANDOM % 10))

    echo "Ход $turn. Введите число от 0 до 9 (для выхода введите q):"
    read input

    if [[ $input == "q" ]]; then
        echo "Игра завершена."
        break
    fi

    if ! [[ $input =~ ^[0-9]$ ]]; then
        echo "Ошибка: введите корректное число от 0 до 9."
        continue
    fi

    if [[ $input -eq $random_number ]]; then
        echo "$(tput setaf 2)Вы угадали!$(tput sgr0) Загаданное число: $random_number"
        guessed=$((guessed + 1))
        guessed_numbers+=("$(tput setaf 2)$input$(tput sgr0)")
    else
        echo "$(tput setaf 1)Вы не угадали.$(tput sgr0) Загаданное число: $random_number"
        not_guessed=$((not_guessed + 1))
        guessed_numbers+=("$(tput setaf 1)$input$(tput sgr0)")
    fi

    if [ "${#guessed_numbers[@]}" -gt 10 ]; then
        guessed_numbers=("${guessed_numbers[@]:1}")
    fi

    echo "Последние 10 чисел: ${guessed_numbers[@]}"

    total=$((guessed + not_guessed))
    guessed_percent=$((guessed * 100 / total))
    not_guessed_percent=$((not_guessed * 100 / total))

    echo "Статистика игры:"
    echo "Доля угаданных чисел: $guessed_percent%"
    echo "Доля не угаданных чисел: $not_guessed_percent%"

    turn=$((turn + 1))
done 
