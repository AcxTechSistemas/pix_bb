## [3.0.0] - 10-04-2026

- **Refatoração Completa**: Migração para Clean Architecture (camadas `domain`, `data`, `core`).
- **SOLID**: Aplicação rigorosa dos princípios SOLID (Inversão de Dependência, Segregação de Interface).
- **ResultDart 2.x**: Migração de `result_dart` para versão 2.2.0 (Breaking Change interna na tipagem de Retorno).
- **Correção de Bugs**:
  - Resolvido erro 403 Forbidden (Adicionado prefixo "Basic " e codificação form-urlencoded).
  - Resolvido erro 500 Internal Server Error (Correção de formato de data e endpoint de listagem).
  - Correção na paginação que buscava a página 0 duas vezes.
- **Example**: Reformulação completa do exemplo com UI premium, segurança de credenciais e dashboard intuitivo.
- **Documentação**: Atualização do README e ARCHITECTURE para refletir a nova estrutura.

## [2.0.0] - 16-04-2023

- Update QueryParams => Body Call
- Update Packages

## [1.0.4] - 16-04-2023

- Removed unnescessary errorTypes
- Iprove unity tests

## [1.0.3] - 16-04-2023

- Add nescessary models exports

## [1.0.2] - 16-04-2023

- Downgrade intl to 0.17 min version

## [1.0.1] - 25-03-2023

- Fix Readme typing errors

## [1.0.0] - 25-03-2023

### This release generated BREAKING CHANGES see the docs!

- Defined the architecture of the project
- Improvements were made to the method for querying received transactions see the docs for more information
- Improvements all error cases see the docs for more information

## [0.1.7] - 25-03-2023

- Fixed testing errors
