#!/bin/bash
set -o posix
insertColor='\033[1;33;4m'
answerColor='\033[01;35m'
indicationColor='\033[3;32m'
indicationColor2='\033[1;32m'
indicationItalic='\033[3;37m'
norm='\033[0m'
n='\n'
doubleNext=$'\n\n'
countLines=$(wc --lines <"$(find ~/ -name path.sh)")

for ((i = 1; i < countLines + 1; i++)); do
    path=$(sed -n "${i}"p "$(find ~/ -name path.sh)")
    project=$(sed -n "${i}"p "$(find ~/ -name name.sh)")
    declare -a projectArray=("${projectArray[@]}" "${project}")
    declare -a pathArray=("${pathArray[@]}" "${path}")
done
Lignes=$countLines
Colonnes=1

printf "$doubleNext$indicationColor Aperçu des projets configurés: %s$n$norm"
load_data() {
    local rc=0
    local index
    local ligne
    local colonne
    for i in "${!projectArray[@]}"; do
        ligne=$((rc / Colonnes))
        colonne=1
        ((index = i))
        alpha[$index]=$(echo -e "$indicationColor2 ➩ ${projectArray[$i]}$norm ✒ $indicationItalic ${pathArray[$i]} $norm")
        ((rc += 1))
    done
}

affiche_data() {
    local ligne=0
    local index

    echo

    while [ "$ligne" -lt "$Lignes" ]; do
        local colonne=0

        echo -e -n "          $indicationColor2$ligne$norm "

        while [ "$colonne" -lt "$Colonnes" ]; do
            ((index = ligne))
            echo -n "${alpha[index]} "
            ((colonne += 1))
        done

        ((ligne += 1))
        echo

    done
}
load_data
affiche_data

echo -n -e "$n$insertColor Copier le chemin du projet à lancer $norm"
read path
if [ -e "${path}" ]; then
    code "${path}"
    printf "$answerColor Lancement du projet... %s$n$norm"
    bash "$(find ~/ -name menu.sh)"
else
    printf "$answerColor Erreur dans le lancement %s$n$norm"
    bash "$(find ~/ -name menu.sh)"
fi