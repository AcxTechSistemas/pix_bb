# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),

and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

# Unreleased

## 0.1.6 - 2023-02-28

## Changed

- It will no longer be necessary to pass the basicKey and the appDevKey to the getTransactionsByDate and getRecentTransactions methods, These parameters are now required when instantiating the PixBB class.

Example:

```dart
final pixBB = PixBB(
  ambiente: Ambiente.homologacao,
  basicKey:'BASIC_KEY',
  appDevKey: 'APP_DEV_KEY',
);
```

## Removed

- Removed the need to pass the: basicKey and the appDevKey to the getTransactionsByDate and getRecentTransactions methods

## Added

- Improved documentation comments.

## Fixed

- Fixed image size
