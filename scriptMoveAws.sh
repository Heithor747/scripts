#!/bin/bash

echo -e "\033[0;32m Script para copiar arquivos de um diretório para outro no S3.\033[0m\n\n"

function tutorial() {
		paths=`aws s3 ls s3://yourpath/`
		echo -e "\n\n1º - Digite o nome do path do qual deseja copiar os arquivos.
		Por exemplo: development/"
		echo -e "\nAtualmente, os paths disponíveis são:"
		echo -e "$paths\n"
		read
		#sleep 1


		echo -e "\n\n2º - Digite o nome do path para o qual deseja enviar os arquivos.
		Por exemplo: development/\n"
		read	

		echo -e "\n\n3º - Digite o filtro pela qual irá fazer a seleção dos arquivos.
		Por exemplo: /id/wallet/\n"
		read
		echo -e "\n\nPor último, tenha em mente que é de extrema importância que \033[0;31m você \033[0m coloque as barras!\n\n"
}

function introduction() {

		rule='^[0-9]+$'
		echo -e "Digite qual opção deseja:

		0 - Sair.
		1 - Ver o tutorial.
		2 - Pular o tutorial e ir direto para a ação"

		read option

		if ! [[ $option =~ $rule ]]; then
				echo "Opção Inválida."
				exit
		fi


		while [ $option -ne 0 ]; do
				case $option in
						0)
								exit
								;;
						1)	
								tutorial
								introduction
								;;
						2)	
								copyFiles
								introduction
								;;
						*)
								echo "Número inválido!"
								echo "Voltando ao menu inicial!"
								introduction
								;;
				esac
		done
}

function copyFiles() {
		read -p "Digite o path de origem:
		Exemplo: development/
		production/ 
		" pathStart 
		echo $pathStart

		read -p "Digite o path de destino(NÃO USAR MESMO PATH QUE A ORIGEM):
		Exemplo: pathDeDestino/ 
		" pathEnd
		echo $pathEnd

		read -p "O path que você deseja filtrar (Onde estão os arquivos que devem ser copiados):
		Exemplo de formato /id/wallet/
		" directory
		directory="*$directory*"
		echo $directory

		echo "aws s3 cp s3://yourpath/$pathStart s3://yourpath/$pathEnd --exclude \"*\" --include $directory --recursive"

		aws s3 cp s3://yourpath/"$pathStart" s3://yourpath/"$pathEnd" --exclude '*' --include "$directory" --recursive
}

introduction
