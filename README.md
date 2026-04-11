<a name="readme-top"></a>

<h1 align="center">Pix BB - Fast and Robust Banco do Brasil Pix Integration</h1>

<div align="center">
  <a href="https://pub.dev/packages/pix_bb">
    <img src="https://raw.githubusercontent.com/AcxTechSistemas/pix_bb/main/images/package-logo.png" alt="Logo" width="400">
  </a>

  <p align="center">
    O pacote <b>pix_bb</b> fornece uma interface simplificada e robusta para integração com a API de Pix do Banco do Brasil. Totalmente refatorado seguir os princípios de <b>Clean Architecture</b> e <b>SOLID</b>.
    <br />
    <a href="https://pub.dev/documentation/pix_bb/latest/"><strong>Explore a documentação »</strong></a>
    <br />
    <br />
    <a href="https://github.com/AcxTechSistemas/pix_bb/issues">Reportar Bug</a>
    ·
    <a href="https://github.com/AcxTechSistemas/pix_bb/issues">Solicitar Recurso</a>
  </p>

[![License](https://img.shields.io/github/license/AcxTechSistemas/pix_bb?style=plastic)](https://github.com/AcxTechSistemas/pix_bb/blob/main/LICENSE)
[![Pub Points](https://img.shields.io/pub/points/pix_bb?label=pub%20points&style=plastic)](https://pub.dev/packages/pix_bb/score)
[![Pub Publisher](https://img.shields.io/pub/publisher/pix_bb?style=plastic)](https://pub.dev/publishers/acxtech.com.br/packages)

</div>

---

## 🚀 Versão 3.0.0 (Principais Mudanças)

- **Clean Architecture**: Reestruturação interna completa para maior estabilidade e manutenibilidade.
- **SOLID**: Todas as implementações agora seguem inversão de dependência e segregação de interfaces.
- **Result Pattern**: Erros são tratados de forma previsível usando `result_dart`.
- **Bug Fixes**: Correção de erros 403 (Auth) e 500 (API) comuns na integração com o BB.

---

## 📋 Pré-requisitos

- Chave Pix cadastrada no Banco do Brasil.
- Acesso exclusivo para **Pessoas Jurídicas**.
- Cadastro no [Portal de Desenvolvedores BB](https://developers.bb.com.br/).

---

## ⚙️ Começando

Instale o pacote via terminal:

```sh
flutter pub add pix_bb
```

Ou no seu `pubspec.yaml`:

```yaml
dependencies:
  pix_bb: ^3.0.0
```

---

## 📖 Como Usar

### 1. Instanciação
Configure a classe principal com suas credenciais.

```dart
import 'package:pix_bb/pix_bb.dart';

final pixBB = PixBB(
  ambiente: Ambiente.producao, // OU Ambiente.homologacao
  basicKey: 'SUA_BASIC_KEY',
  developerApplicationKey: 'SUA_APP_DEV_KEY',
);
```

### 2. Autenticação (Get Token)
Obtenha o token de acesso de forma assíncrona.

```dart
try {
  final token = await pixBB.getToken();
  print('Token extraído: ${token.accessToken}');
} catch (e) {
  print('Erro na autenticação: $e');
}
```

### 3. Listagem de Transações Pix
Busque transações recebidas com filtros de data (máximo 4 dias de intervalo).

```dart
// Busca as transações dos últimos 4 dias (padrão)
final transactions = await pixBB.fetchTransactions(token: token);

// Com range customizado
final customTransactions = await pixBB.fetchTransactions(
  token: token,
  dateTimeRange: DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 1)),
    end: DateTime.now(),
  ),
);
```

---

## 🔒 Segurança de Credenciais

Para manter suas credenciais seguras durante o desenvolvimento do seu exemplo, criamos um padrão de arquivo `credentials.dart` que é automaticamente ignorado pelo Git. 

1. No diretório `example/lib`, crie um arquivo `credentials.dart`.
2. Adicione suas chaves nele.
3. Certifique-se de que ele está no `.gitignore`.

---

## 🏗️ Arquitetura e Contribuição

Para detalhes sobre como o pacote é construído internamente, veja o arquivo [ARCHITECTURE.md](ARCHITECTURE.md).

Se desejar contribuir, por favor faça um fork do projeto e envie um Pull Request. Todas as contribuições são bem-vindas!

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

<p align="right">(<a href="#readme-top">voltar ao topo</a>)</p>

---

<p align="center">
  <a href="https://www.acxtech.com.br">
    <img width="110px" src="https://avatars.githubusercontent.com/u/125107060?s=400&v=4">
  </a>
  <p align="center">
    Built and maintained by <a href="https://www.acxtech.com.br">AcxTech Sistemas</a>.
  </p>
</p>
