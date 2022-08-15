#!/bin/bash
set -o posix
insertColor='\033[1;33;4m'
answerColor='\033[01;35m'
importantColor='\033[01;31m'
indicationColor='\033[3;32m'
hugeIndicationColor='\033[5;37;41m'
successColor='\033[01;32m'
exampleColor='\033[01;34m'
norm='\033[0m'
n=$'\n'
doubleNext=$'\n\n'
tab=$'\t\t'
yes=y
non=n

declare -a dependanciesName=([0]=react [1]=express [2]=eslint [3]=prettier [4]=styled-components [5]=react-router-dom
    [6]=nodemon [7]=dotenv [8]=express-promise-router [9]=mysql [10]=mysql2 [11]=joi
    [12]=argon2 [13]=sequelize [14]=json-webtoken [15]=jwt-decode [16]=express-session [17]=sweetalert2 [18]=cookie-parser [19]=sweetalert2-react-content
    [20]=nestJS [21]=multer [22]=mongoose [23]=axios)

declare -a dependanciesLink=([0]="npx create-react-app" [1]="npm install express --save" [2]="npm install eslint --save-dev" [3]="npm install --save-dev prettier"
    [4]="npm install --save styled-components" [5]="npm i react-router-dom"
    [6]="npm install --save-dev nodemon" [7]="npm install dotenv --save" [8]="npm install express-promise-router --save"
    [9]="npm install mysql" [10]="npm install --save mysql2" [11]="npm i joi"
    [12]="npm i argon2" [13]="npm install --save sequelize" [14]="npm install jsonwebtoken" [15]="npm i jwt-decode" [16]="npm i express-session"
    [17]="npm install sweetalert2" [18]="npm install cookie-parser" [19]="npm install --save sweetalert2-react-content"
    [20]="npm i -g @nestjs/cli ; nest new" [21]="npm install --save multer" [22]="npm install mongoose --save" [23]="npm install axios"
)

init() {
    printf "$insertColor Copier/coller le lien https du repo github trouvable au-dessus %s$norm$n"
    printf "$insertColor Quand demandé, à mettre dans: $norm$importantColor git repository %s$norm$n"
    printf "$answerColor Création du package.json en cours... %s$norm$n"
    npm init
}

preconfigure() {
    case "$1" in
    react)
        init
        echo -n -e "$insertColor Nom du dossier React: $norm"
        read name
        ${dependanciesLink[0]} "${name}"
        ;;
    nest)
        init
        ${dependanciesLink[20]}
        ;;
    express)
        init
        ${dependanciesLink[1]}
        ;;
    reactExpress)
        init
        ${dependanciesLink[1]}
        echo -n -e "$insertColor Nom du dossier React: $norm"
        read name
        ${dependanciesLink[0]} "${name}"
        ;;
    reactNest)
        init
        ${dependanciesLink[20]}
        echo -n -e "$insertColor Nom du dossier React: $norm"
        read name
        ${dependanciesLink[0]} "${name}"
        ;;
    *)
        exit 0
        ;;
    esac
}

echo -n -e "${insertColor}Choisir un projet préconfigurer ou faire sa propre configuration ? : full/empty $n${norm}"
read answer
if [ "${answer}" = "full" ]; then
    echo -n -e "$insertColor Suivre les consignes: $norm"
    printf "$doubleNext$tab$indicationColor Choisir l'une des options en tapant le mot en surlignement: %s$n$norm"
    printf "$tab$indicationColor Pour paramétrer un projet React, taper: $norm${hugeIndicationColor}react%s$norm$n"
    printf "$tab$indicationColor Pour paramétrer un projet NestJS, taper: $norm${hugeIndicationColor}nest%s$norm$n"
    printf "$tab$indicationColor Pour paramétrer un projet Express, taper: $norm${hugeIndicationColor}express%s$norm$n"
    printf "$tab$indicationColor Pour paramétrer un projet React et express, taper: $norm${hugeIndicationColor}reactExpress%s$norm$n"
    printf "$tab$indicationColor Pour paramétrer un projet React et NestJS, taper: $norm${hugeIndicationColor}reactNest%s$norm$n"
    printf "$tab$indicationColor Pour quitter le menu, taper: $norm${hugeIndicationColor}exit%s$norm$n"
    read answer
    preconfigure "${answer}"
elif [ "${answer}" = "empty" ]; then
    bash "$(find ~/ -name arrayDependancies.sh)"
fi
exit 0
