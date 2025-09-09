import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Widget principal do aplicativo.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyDataScreen(),
    );
  }
}

/// Tela principal que exibe a lista de filmes.
class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

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

  late Filme filmeComMaiorNota;
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _atualizarFilmeComMaiorNota();

    // Configura animação da borda
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  /// Atualiza qual filme tem a maior nota
  void _atualizarFilmeComMaiorNota() {
    filmeComMaiorNota = filmes.reduce(
      (atual, proximo) =>
          atual.notaImdb > proximo.notaImdb ? atual : proximo,
    );
  }

  /// Abre a tela de adicionar filme
  Future<void> _adicionarNovoFilme() async {
    final novoFilme = await Navigator.push<Filme>(
      context,
      MaterialPageRoute(
        builder: (context) => AddFilmeScreen(
          nextId: filmes.length + 1,
        ),
      ),
    );

    if (novoFilme != null) {
      setState(() {
        filmes.add(novoFilme);
        _atualizarFilmeComMaiorNota();
      });
    }
  }

  /// Abre a tela para editar um filme existente
  Future<void> _editarFilme(Filme filme) async {
    final filmeEditado = await Navigator.push<Filme>(
      context,
      MaterialPageRoute(
        builder: (context) => AddFilmeScreen(
          nextId: filme.id,
          filmeExistente: filme,
        ),
      ),
    );

    if (filmeEditado != null) {
      setState(() {
        final index = filmes.indexWhere((f) => f.id == filme.id);
        filmes[index] = filmeEditado;
        _atualizarFilmeComMaiorNota();
      });
    }
  }

  /// Exclui um filme da lista
  void _excluirFilme(int index) {
    final filmeRemovido = filmes[index];

    setState(() {
      filmes.removeAt(index);
      if (filmes.isNotEmpty) {
        _atualizarFilmeComMaiorNota();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filme "${filmeRemovido.nome}" excluído!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
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
    _controller.dispose();
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
        animation: _colorAnimation,
        builder: (context, child) {
          return ListView.builder(
            itemCount: filmes.length,
            itemBuilder: (context, index) {
              final filme = filmes[index];
              final bool isMelhorFilme = filme.id == filmeComMaiorNota.id;

              return Dismissible(
                key: Key(filme.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => _excluirFilme(index),
                background: Container(
                  color: Colors.red,
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
                          ? _colorAnimation.value!
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
                    onTap: () => _editarFilme(filme),
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
        onPressed: _adicionarNovoFilme,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Tela para adicionar ou editar um filme
class AddFilmeScreen extends StatefulWidget {
  final int nextId;
  final Filme? filmeExistente;

  const AddFilmeScreen({super.key, required this.nextId, this.filmeExistente});

  @override
  State<AddFilmeScreen> createState() => _AddFilmeScreenState();
}

class _AddFilmeScreenState extends State<AddFilmeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _diretorController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.filmeExistente != null) {
      _nomeController.text = widget.filmeExistente!.nome;
      _diretorController.text = widget.filmeExistente!.diretor;
      _notaController.text = widget.filmeExistente!.notaImdb.toString();
    }
  }

  void _salvarFilme() {
    if (_formKey.currentState!.validate()) {
      final novoFilme = Filme(
        widget.filmeExistente?.id ?? widget.nextId,
        _nomeController.text,
        _diretorController.text,
        double.parse(_notaController.text),
      );

      Navigator.pop(context, novoFilme);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditando = widget.filmeExistente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditando ? 'Editar Filme' : 'Adicionar Filme'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Filme'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o nome do filme' : null,
              ),
              TextFormField(
                controller: _diretorController,
                decoration: const InputDecoration(labelText: 'Diretor'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o nome do diretor' : null,
              ),
              TextFormField(
                controller: _notaController,
                decoration: const InputDecoration(labelText: 'Nota IMDb'),
                keyboardType: TextInputType.number,
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