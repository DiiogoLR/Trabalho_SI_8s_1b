# 📱 Trabalho de Sistemas de Informação – 8º Semestre (1ºB)

Este projeto foi desenvolvido como parte da disciplina de **Sistemas de Informação**, no 8º semestre (turma 1ºB).  
O objetivo é **construir um aplicativo em Flutter** que sirva como base para experimentação prática dos conceitos vistos em aula, explorando desde a estrutura inicial de um app até a exibição de dados em tela.

---

## 🎯 Objetivo do Trabalho

- Demonstrar a **criação de um aplicativo multiplataforma** usando **Dart & Flutter**.  
- Compreender a **estrutura de um projeto Flutter** e como ele se organiza.  
- Implementar elementos básicos de interface, como:
  - `Scaffold` (estrutura de layout principal),
  - `AppBar` (barra superior),
  - `ListView` (exibição de listas de dados).  

O projeto tem caráter **didático**, servindo como ponto de partida para a construção de apps mais completos.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Dart  
- **Framework:** Flutter  
- **Plataformas alvo:** Android, iOS, Web e Desktop  

---

## 📂 Estrutura do Projeto
Trabalho_SI_8s_1b/  
├── android/ → Arquivos de build do Android  
├── ios/ → Arquivos de build do iOS  
├── web/ → Versão Web do aplicativo  
├── linux/ → Versão para Linux  
├── macos/ → Versão para macOS  
├── windows/ → Versão para Windows  
├── lib/  
│ └── main.dart → Código principal do aplicativo  
├── pubspec.yaml → Dependências e metadados do projeto  
└── README.md → Documentação do projeto  

---

## 🚀 Como Executar o Projeto

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/gellyorge/Trabalho_SI_8s_1b.git
   cd Trabalho_SI_8s_1b
2. Instale as dependências do Flutter:  
   ```bash
    flutter pub get  
4. Execute o projeto:  
- Em um dispositivo/emulador Android:  
  ```bash
  flutter run  
- Em um navegador:  
  ```bash
  flutter run -d chrome  
- Em desktop (Windows/macOS/Linux):  
```bash
flutter run -d windows
```
---

📖 Explicação do Código

O arquivo principal está em lib/main.dart, onde:  

- É criada uma classe Filme para representar os dados (id, nome, diretor, nota).  
- O app utiliza StatelessWidget como estrutura principal.  
- A interface é construída com Scaffold + AppBar.  
- Os filmes são exibidos em uma lista usando ListView.builder.  

---  

👨‍💻 Contribuidores

- Diogo Lima do Rosario
- Gellyorge Marvila Marques
- Gustavo Marvila Haddad Elias
