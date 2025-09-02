# Projeto Dart - Parte 1 (Computação Móvel)

## 📌 Descrição
Este projeto foi desenvolvido para a disciplina **Computação Móvel** (Multivix),
como parte da **Avaliação Processual - 1º Bimestre**.  
O objetivo é demonstrar os fundamentos da linguagem **Dart**, aplicando conceitos de:
- Criação de classes e atributos
- Estruturas de dados (List)
- Estruturas de controle (laços e condicionais)

## 📂 Estrutura do Projeto
├── src/  
│ └── Aula.dart # Script principal em Dart  
├── .gitignore  
├── Project1.iml  
└── README.md  

## 🏗️ Classe implementada
A classe escolhida foi **Filme**, com os seguintes atributos:
- `id` (int) → Identificador do filme
- `nome` (String) → Nome do filme
- `diretor` (String) → Diretor responsável
- `notaImdb` (double) → Nota no IMDb

## 🔄 Lógica implementada
1. Foi criada uma lista (`List<Filme>`) com **5 filmes de exemplo**.
2. O programa percorre a lista exibindo todos os filmes.
3. A cada iteração, verifica se a nota do filme é maior que a nota do atual "melhor filme".
4. Ao final, exibe o **filme com maior nota IMDb**.

### Exemplo de saída no console:
Nome: "Interestelar"  
Diretor: Christopher Nolan  
Nota IMDb: 8.7  

Nome: "Cidade de Deus"  
Diretor: Fernando Meirelles  
Nota IMDb: 8.6  

...  

------ MELHOR FILME --------  
Nome: "O Poderoso Chefão"  
Diretor: Francis Ford Coppola  
Nota IMDb: 9.2  


## ▶️ Como executar
1. Instale o SDK do [Dart](https://dart.dev/get-dart).  
2. Clone este repositório:  
   ```bash  
   git clone https://github.com/DiiogoLR/Trabalho_SI_8s_1b.git  

Acesse a pasta do projeto e rode o arquivo principal:  

    cd projeto-dart-parte1/src  
    dart main.dart  

👨‍💻 Autores:

- Diogo Lima do Rosario
- Gellyorge Marvila Marques
- Gustavo Marvila Haddad Elias
