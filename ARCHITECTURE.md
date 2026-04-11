# Arquitetura (Pix BB 3.0.0)

Este documento descreve as decisões de design e a estrutura arquitetural do pacote `pix_bb`.

## Objetivo
O objetivo principal é fornecer uma interface robusta, testável e manutenível para a API de Pix do Banco do Brasil, seguindo as melhores práticas de desenvolvimento de software.

## Clean Architecture
O projeto foi refatorado seguindo os princípios da Clean Architecture, dividindo o código em camadas com responsabilidades bem definidas:

### 1. Camada de Domínio (`domain`)
Contém as regras de negócio puras e abstrações:
- **Entities**: Objetos de negócio (ex: `Pix`, `Token`).
- **Repositories (Interfaces)**: Abstrações que definem como os dados devem ser acessados.
- **UseCases**: Executam a lógica de negócio específica (ex: `GetTokenUseCase`, `FetchTransactionsUseCase`).

### 2. Camada de Dados (`data`)
Implementa as interfaces definidas no domínio:
- **Models**: Extensões das entidades com lógica de serialização (JSON).
- **Repositories (Implementações)**: Lógica de acesso a dados (chamadas de rede, tratamento de erros específicos de infraestrutura).

### 3. Camada Core (`core`)
Componentes compartilhados e infraestrutura básica:
- **Services**: Clientes HTTP (`DioClient`) e serviços base.
- **Utils**: Formatadores e utilitários globais.

## Princípios SOLID
- **S (Single Responsibility)**: Cada classe tem uma única responsabilidade.
- **O (Open/Closed)**: Uso de extensões e abstrações para permitir novos comportamentos sem modificar o código existente.
- **L (Liskov Substitution)**: Classes derivadas podem substituir suas bases sem quebrar o sistema.
- **I (Interface Segregation)**: Interfaces específicas para cada repositório.
- **D (Dependency Inversion)**: Camadas de alto nível não dependem de detalhes de baixo nível (uso intenso de D.I. via construtores).

## Tratamento de Erros (Result Pattern)
Utilizamos o pacote `result_dart` (versão 2.2.0) para garantir que as funções retornem explicitamente um Sucesso ou uma Falha (`Result<S>`). Isso elimina o uso excessivo de blocos `try-catch` desnecessários e torna o fluxo de dados mais previsível.

## Tecnologias e Padrões
- **Dio**: Cliente HTTP robusto com interceptores e tratamento de erros customizado.
- **Equatable**: Utilizado nas entidades para simplificar comparações e testes.
- **Mocktail**: Para criação de mocks nos testes de unidade.
- **intl**: Para garantir a formatação correta de datas exigida pelo Banco do Brasil (Fuso -03:00).
