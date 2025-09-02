// Definição da classe de filmes
class Filme{
        // Atributos da classe
        int id;
        String nome;
        String diretor;
        double notaImdb;

        // Construtor da classe
        Filme(this.id, this.nome, this.diretor, this.notaImdb);

        // Sobrescrevendo o metodo toString() para formatar a saída do objeto
         @override
        String toString() {
        return 'Nome: "$nome"\nDiretor: $diretor\nNota IMDb: ${notaImdb.toStringAsFixed(1)}\n';
  }
            
    }

void main() {
// "Banco de dados" de filmes em uma lista
var filmes = <Filme>[
    Filme(1, 'Interestelar', 'Christopher Nolan', 8.7),
    Filme(2, 'Cidade de Deus', 'Fernando Meirelles', 8.6),
    Filme(3, 'O Poderoso Chefão', 'Francis Ford Coppola', 9.2),
    Filme(4, 'A Viagem de Chihiro', 'Hayao Miyazaki', 8.6),
    Filme(5, 'O Senhor dos Anéis: A Sociedade do Anel', 'Peter Jackson', 8.9),
  ];




  // Variável que armazena o filme com maior nota IMDb
  Filme maiorNotaFilme = filmes[0];

  // Percorre todos os filmes
  for(var filme in filmes){
    // Verifica se a nota do filme atual é maior que a nota do "maiorNotaFilme"
    if(filme.notaImdb > maiorNotaFilme.notaImdb){
        maiorNotaFilme = filme;
    }
    // Exibe os dados do filme atual
    print(filme);
    
}
// Exibe o melhor filme encontrado
print('------ MELHOR FILME --------');
print(maiorNotaFilme);
}