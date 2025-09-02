import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Widget principal do aplicativo.
/// Responsável por configurar o MaterialApp, tema e tela inicial.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa "DEBUG"
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
  // Lista de filmes
  final List<Filme> filmes = const [
    Filme(1, 'Interestelar', 'Christopher Nolan', 8.7),
    Filme(2, 'Cidade de Deus', 'Fernando Meirelles', 8.6),
    Filme(3, 'O Poderoso Chefão', 'Francis Ford Coppola', 9.2),
    Filme(4, 'A Viagem de Chihiro', 'Hayao Miyazaki', 8.6),
    Filme(5, 'O Senhor dos Anéis: A Sociedade do Anel', 'Peter Jackson', 8.9),
  ];

  late final Filme filmeComMaiorNota;
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Descobre o filme com a maior nota
    filmeComMaiorNota = filmes.reduce(
      (atual, proximo) =>
          atual.notaImdb > proximo.notaImdb ? atual : proximo,
    );

    // Configura a animação para pulsar a borda
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
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

              // Verifica se este é o filme com maior nota
              final bool isMelhorFilme = filme.id == filmeComMaiorNota.id;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                  leading: Icon(
                    Icons.movie,
                    color: isMelhorFilme ? _colorAnimation.value : Colors.blue,
                    size: 32,
                  ),
                  title: Text(
                    filme.nome,
                    style: TextStyle(
                      fontWeight: isMelhorFilme
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color:
                          isMelhorFilme ? _colorAnimation.value : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Diretor: ${filme.diretor}\nNota IMDb: ${filme.notaImdb}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
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
