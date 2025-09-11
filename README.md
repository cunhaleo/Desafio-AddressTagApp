# Address App + Core Data

💡 Motivação: 
- Criar um App para utilizar as funcionalidades do CoreData como o FetchedResultsController

 ✅ Condutas:
- Utilização de interfaces e injeção de dependências, reduzindo acoplamento e aumentando a testabilidade.
- Classes com responsabilidades únicas, possibilitando reuso e facilitando a manutenção

🔧 Ferramentas:
- UIKit
- Core Data
- Consumo de API usando uma camada de rede, permitindo Testes
- Parse de JSON com Generic Type e Coding Keys

📲 Sobre o App:
- Criei um App onde o usuário pode pesquisar um CEP em uma API, e salvar endereços localmente no dispositivo.
- Na aba “Meus endereços”, o usuário pode atualizar ou deletar itens salvos.
- A barra de pesquisa filtra os itens em tempo real através de Predicates.
- O Objeto FetchedResultsController do CoreData permite a atualização automática da TableView, quando ocorre qualquer mudança no Banco de dados.

https://github.com/user-attachments/assets/fdedb95d-71a6-44f8-89b3-7d4144cd99ab

