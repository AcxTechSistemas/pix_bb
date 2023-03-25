## [1.0.0] - 25-03-2023

- Defined the architecture of the project

## Breaking Changes

- Improvements were made to the method for querying received transactions see the docs for more information

- Changed variable name in PixBB Instantiate :

  - dev_app_key => developerApplicationKey

- Changed the way to use the fetchTransaction method:
  - Before
  ```dart
  pixBB.getToken().then(
            (token) => pixBB.fetchRecentReceivedTransactions(
              accessToken: token.accessToken,
            );
  ```
  - Afeter
  ```dart
  pixBB.getToken().then(
              (token) => pixBB.fetchTransactions(
                token: token,
              ),
  ```
