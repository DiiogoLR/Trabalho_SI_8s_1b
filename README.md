# 📱 Trabalho de Sistemas de Informação – 8º Semestre (1ºB)

Este projeto foi desenvolvido como parte da disciplina de **Sistemas de Informação**, no 8º semestre (turma 1ºB).  
O objetivo principal foi **desenvolver um aplicativo em Flutter** que permite o **gerenciamento completo de uma lista de filmes**, aplicando conceitos de **CRUD** (*Create, Read, Update, Delete*), formulários, animações e interação com o usuário.

---

## 📂 Estrutura do Projeto

```
Trabalho_SI_8s_1b/
├── android/           # Arquivos de build para Android
├── ios/              # Arquivos de build para iOS
├── web/              # Versão Web do app
├── linux/            # Versão para Linux
├── macos/            # Versão para macOS
├── windows/          # Versão para Windows
├── lib/
│   └── main.dart     # Código principal do aplicativo
├── pubspec.yaml      # Dependências e metadados do projeto
└── README.md         # Documentação do projeto
```

---

## 🚀 Como Executar o Projeto

### 1. **Clone o repositório**
```bash
git clone https://github.com/gellyorge/Trabalho_SI_8s_1b.git
cd Trabalho_SI_8s_1b
```

### 2. **Instale as dependências**
```bash
flutter pub get
```

### 3. **Execute o projeto**

#### Em um dispositivo/emulador Android:
```bash
flutter run
```

#### Em um navegador (Web):
```bash
flutter run -d chrome
```

#### Em desktop (Windows/macOS/Linux):
```bash
flutter run -d windows
```

---

## 📖 Explicação do Código

O arquivo principal está localizado em **`lib/main.dart`** e concentra toda a lógica do aplicativo.

---

### **1. Classe `Filme`**

```dart
class Filme {
  final int id;              // Identificador único do filme
  final String nome;         // Nome do filme
  final String diretor;      // Nome do diretor
  final double notaImdb;     // Nota IMDb do filme

  const Filme(this.id, this.nome, this.diretor, this.notaImdb);

  @override
  String toString() {
    return 'Nome: "$nome"\nDiretor: $diretor\nNota IMDb: ${notaImdb.toStringAsFixed(1)}\n';
  }
}
```

🔹 **Função:** Representa os dados de cada filme.  
🔹 **Campos:** `id`, `nome`, `diretor` e `notaImdb`.  
🔹 **Usada para:** Popular a lista, editar, excluir e manipular dados.

---

### **2. Tela Principal – `MyDataScreen`**

```dart
class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}
```

#### **Funções da tela:**

- Exibir **lista de filmes** com **ListView.builder**.
- Destacar o **melhor filme** usando **animação pulsante**.
- Permitir:
  - **Adicionar filmes** (via botão `+`);
  - **Editar filmes** (ao clicar no item da lista);
  - **Excluir filmes** com **swipe lateral** (`Dismissible`) + **SnackBar** para desfazer.

---

### **3. Cadastro e Edição de Filmes – `AddFilmeScreen`**

```dart
class AddFilmeScreen extends StatefulWidget {
  final Filme? filme;    // Caso seja passado, estamos editando

  const AddFilmeScreen({super.key, this.filme});

  @override
  State<AddFilmeScreen> createState() => _AddFilmeScreenState();
}
```

#### **Principais recursos:**

- Possui um **Form** com campos para:
  - Nome do filme;
  - Diretor;
  - Nota IMDb.
- **Validação de campos** para evitar erros.
- O mesmo formulário serve para **adicionar** ou **editar** filmes.

---

## ✨ Funcionalidades Implementadas

✅ **Adicionar filmes** – Botão “+” abre o formulário para cadastro.  
✅ **Editar filmes** – Clique em qualquer filme para alterar os dados.  
✅ **Excluir filmes** – Swipe para a esquerda remove o item.  
✅ **Desfazer exclusão** – SnackBar com botão de restauração.  
✅ **Animação visual** – O melhor filme da lista fica com borda e ícone pulsantes.

---

## 👨‍💻 Contribuidores

- **Diogo Lima do Rosário**  
- **Gellyorge Marvila Marques**  
- **Gustavo Marvila Haddad Elias**

---

## 🏆 Status do Projeto

> **Concluído ✅**  
O aplicativo atende a todos os requisitos solicitados, incluindo:
- Estrutura base do Flutter;
- CRUD completo;
- Animações dinâmicas;
- Interface responsiva e didática.
