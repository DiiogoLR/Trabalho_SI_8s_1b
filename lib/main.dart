import 'package:flutter/material.dart'; // Importa a biblioteca principal do Flutter

// Função principal que inicia o app
void main() {
  runApp(const MyApp()); // Executa o widget raiz do aplicativo
}

/// Widget principal do aplicativo.
/// Aqui configuramos o MaterialApp, tema e a tela inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa "DEBUG" no canto superior direito
      title: 'Lista de Filmes', // Título do app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor principal do tema
      ),
      home: const MyDataScreen(), // Define a tela inicial do app
    );
  }
}

/// Tela principal que exibe a lista de filmes.
class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

/// Estado da tela principal.
class _MyDataScreenState extends State<MyDataScreen>
    with SingleTickerProviderStateMixin {
  // Lista inicial de filmes
  final List<Filme> filmes = [
    const Filme(1, 'Interestelar', 'Christopher Nolan', 8.7),
    const Filme(2, 'Cidade de Deus', 'Fernando Meirelles', 8.6),
    const Filme(3, 'O Poderoso Chefão', 'Francis Ford Coppola', 9.2),
    const Filme(4, 'A Viagem de Chihiro', 'Hayao Miyazaki', 8.6),
    const Filme(5, 'O Senhor dos Anéis: A Sociedade do Anel', 'Peter Jackson', 8.9),
  ];

  // Variável para armazenar o filme com maior nota
  late Filme filmeComMaiorNota;

  // Controlador da animação
  late final AnimationController _controller;

  // Animação da cor para destacar o melhor filme
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Calcula o filme com a maior nota ao iniciar o app
    _atualizarFilmeComMaiorNota();

    // Configura a animação para pulsar a borda do melhor filme
    _controller = AnimationController(
      vsync: this, // Necessário para animações
      duration: const Duration(seconds: 1), // Duração da animação
    )..repeat(reverse: true); // Faz a animação ir e voltar

    // Define a transição de cores para a animação
    _colorAnimation = ColorTween(
      begin: Colors.blue, // Cor inicial
      end: Colors.red, // Cor final
    ).animate(_controller);
  }

  /// Função para atualizar o filme com maior nota IMDb
  void _atualizarFilmeComMaiorNota() {
    filmeComMaiorNota = filmes.reduce(
      (atual, proximo) =>
          atual.notaImdb > proximo.notaImdb ? atual : proximo,
    );
  }

  /// Função para adicionar um novo filme
  Future<void> _adicionarNovoFilme() async {
    // Abre a tela para adicionar filme e aguarda o retorno
    final novoFilme = await Navigator.push<Filme>(
      context,
      MaterialPageRoute(
        builder: (context) => AddFilmeScreen(
          nextId: filmes.length + 1, // Define o próximo ID
        ),
      ),
    );

    // Se o usuário salvar o filme, adicionamos à lista
    if (novoFilme != null) {
      setState(() {
        filmes.add(novoFilme);
        _atualizarFilmeComMaiorNota();
      });
    }
  }

  /// Função para editar um filme existente
  Future<void> _editarFilme(Filme filme) async {
    // Abre a tela para edição e aguarda o resultado
    final filmeEditado = await Navigator.push<Filme>(
      context,
      MaterialPageRoute(
        builder: (context) => AddFilmeScreen(
          nextId: filme.id, // Mantém o mesmo ID
          filmeExistente: filme, // Passa os dados do filme para edição
        ),
      ),
    );

    // Se o usuário salvar, atualizamos o filme na lista
    if (filmeEditado != null) {
      setState(() {
        final index = filmes.indexWhere((f) => f.id == filme.id);
        filmes[index] = filmeEditado;
        _atualizarFilmeComMaiorNota();
      });
    }
  }

  /// Função para excluir um filme
  void _excluirFilme(int index) {
    final filmeRemovido = filmes[index];

    // Remove o filme da lista
    setState(() {
      filmes.removeAt(index);
      if (filmes.isNotEmpty) {
        _atualizarFilmeComMaiorNota();
      }
    });

    // Exibe SnackBar com opção de desfazer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filme "${filmeRemovido.nome}" excluído!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            // Caso o usuário clique em "Desfazer", restaura o filme
            setState(() {
              filmes.insert(index, filmeRemovido);
              _atualizarFilmeComMaiorNota();
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos da animação
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Filmes'),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _colorAnimation, // Escuta mudanças de cor na animação
        builder: (context, child) {
          return ListView.builder(
            itemCount: filmes.length, // Quantidade de filmes
            itemBuilder: (context, index) {
              final filme = filmes[index];
              final bool isMelhorFilme = filme.id == filmeComMaiorNota.id;

              return Dismissible(
                key: Key(filme.id.toString()), // Chave única para cada item
                direction: DismissDirection.endToStart, // Swipe para a esquerda
                onDismissed: (direction) => _excluirFilme(index), // Remove o filme
                background: Container(
                  color: Colors.red, // Cor de fundo ao arrastar
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isMelhorFilme
                          ? _colorAnimation.value! // Borda animada
                          : Colors.grey.shade300,
                      width: isMelhorFilme ? 3 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => _editarFilme(filme), // Ao clicar, edita o filme
                    leading: Icon(
                      Icons.movie,
                      color: isMelhorFilme ? _colorAnimation.value : Colors.blue,
                      size: 32,
                    ),
                    title: Text(
                      filme.nome,
                      style: TextStyle(
                        fontWeight:
                            isMelhorFilme ? FontWeight.bold : FontWeight.normal,
                        color:
                            isMelhorFilme ? _colorAnimation.value : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      'Diretor: ${filme.diretor}\nNota IMDb: ${filme.notaImdb}',
                    ),
                    isThreeLine: true,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarNovoFilme, // Abre a tela para adicionar filme
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Tela para adicionar ou editar um filme
class AddFilmeScreen extends StatefulWidget {
  final int nextId; // Próximo ID do filme
  final Filme? filmeExistente; // Caso seja edição, traz o filme atual

  const AddFilmeScreen({super.key, required this.nextId, this.filmeExistente});

  @override
  State<AddFilmeScreen> createState() => _AddFilmeScreenState();
}

/// Estado da tela de adicionar/editar filmes
class _AddFilmeScreenState extends State<AddFilmeScreen> {
  // Chave para o formulário
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _diretorController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Se estiver editando, preenche os campos com os dados do filme existente
    if (widget.filmeExistente != null) {
      _nomeController.text = widget.filmeExistente!.nome;
      _diretorController.text = widget.filmeExistente!.diretor;
      _notaController.text = widget.filmeExistente!.notaImdb.toString();
    }
  }

  /// Função para salvar um novo filme ou atualizar um existente
  void _salvarFilme() {
    if (_formKey.currentState!.validate()) {
      final novoFilme = Filme(
        widget.filmeExistente?.id ?? widget.nextId, // Mantém ID se for edição
        _nomeController.text,
        _diretorController.text,
        double.parse(_notaController.text), // Converte nota para double
      );

      Navigator.pop(context, novoFilme); // Retorna o filme para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditando = widget.filmeExistente != null; // Verifica se é edição

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditando ? 'Editar Filme' : 'Adicionar Filme'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Vincula o formulário
          child: Column(
            children: [
              // Campo para nome do filme
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Filme'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o nome do filme' : null,
              ),
              // Campo para diretor do filme
              TextFormField(
                controller: _diretorController,
                decoration: const InputDecoration(labelText: 'Diretor'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o nome do diretor' : null,
              ),
              // Campo para nota IMDb
              TextFormField(
                controller: _notaController,
                decoration: const InputDecoration(labelText: 'Nota IMDb'),
                keyboardType: TextInputType.number, // Teclado numérico
                validator: (value) {
                  if (value!.isEmpty) return 'Informe a nota';
                  final nota = double.tryParse(value);
                  if (nota == null || nota < 0 || nota > 10) {
                    return 'Informe uma nota válida (0 a 10)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Botão para salvar ou editar filme
              ElevatedButton.icon(
                onPressed: _salvarFilme,
                icon: Icon(isEditando ? Icons.edit : Icons.save),
                label: Text(isEditando ? 'Salvar Alterações' : 'Salvar Filme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Classe que representa um filme.
class Filme {
  final int id;
  final String nome;
  final String diretor;
  final double notaImdb;

  const Filme(this.id, this.nome, this.diretor, this.notaImdb);

  @override
  String toString() {
    return 'Nome: "$nome"\nDiretor: $diretor\nNota IMDb: ${notaImdb.toStringAsFixed(1)}\n';
  }
}