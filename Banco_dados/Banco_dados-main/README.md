# Banco de Dados da Livraria

Este repositório contém o projeto do banco de dados de uma livraria, desenvolvido como parte da aula do professor Leandro Colevati.

## Descrição

O banco de dados tem como objetivo gerenciar informações sobre livros, autores, clientes e vendas. Ele foi projetado para facilitar o armazenamento e a consulta de dados relevantes para o funcionamento de uma livraria.

## Estrutura do Banco de Dados

A seguir estão as principais tabelas incluídas no banco de dados:

### Tabelas

- **Livros**
  - `ID`: Identificador único do livro (chave primária)
  - `Titulo`: Título do livro
  - `AutorID`: Identificador do autor (chave estrangeira)
  - `Preco`: Preço do livro
  - `Estoque`: Quantidade disponível em estoque

- **Autores**
  - `ID`: Identificador único do autor (chave primária)
  - `Nome`: Nome do autor
  - `Nascimento`: Data de nascimento do autor
  - `Nacionalidade`: Nacionalidade do autor

- **Clientes**
  - `ID`: Identificador único do cliente (chave primária)
  - `Nome`: Nome do cliente
  - `Email`: Email do cliente
  - `Telefone`: Telefone do cliente

- **Vendas**
  - `ID`: Identificador único da venda (chave primária)
  - `ClienteID`: Identificador do cliente (chave estrangeira)
  - `DataVenda`: Data da venda
  - `Total`: Valor total da venda

### Relacionamentos

- Um **autor** pode ter vários **livros**.
- Um **cliente** pode realizar várias **vendas**.

## Instalação

1. Clone este repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
