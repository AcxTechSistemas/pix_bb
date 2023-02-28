import 'package:flutter/material.dart';
import 'package:pix_bb/pix_bb.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final pixBB = PixBB(ambiente: Ambiente.homologacao);
const basicKey =
    'Basic ZXlKcFpDSTZJalU1TkRrek56Z3RaamhqWWlJc0ltTnZaR2xuYjFCMVlteHBZMkZrYjNJaU9qQXNJbU52WkdsbmIxTnZablIzWVhKbElqbzBPVFEzT0N3aWMyVnhkV1Z1WTJsaGJFbHVjM1JoYkdGallXOGlPakY5OmV5SnBaQ0k2SWpGbU4yTmpaRFF0TW1OaFl5MGlMQ0pqYjJScFoyOVFkV0pzYVdOaFpHOXlJam93TENKamIyUnBaMjlUYjJaMGQyRnlaU0k2TkRrME56Z3NJbk5sY1hWbGJtTnBZV3hKYm5OMFlXeGhZMkZ2SWpveExDSnpaWEYxWlc1amFXRnNRM0psWkdWdVkybGhiQ0k2TVN3aVlXMWlhV1Z1ZEdVaU9pSm9iMjF2Ykc5bllXTmhieUlzSW1saGRDSTZNVFkyT1RJek5qUXhNRGN4Tlgw';
const developerApplicationKey = 'd27b077902ffabb0136ee17d10050056b961a5bc';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Pix V1 Banco do Brasil'),
      ),
      body: FutureBuilder(
        future: pixBB.getToken(basicKey: basicKey).then(
              (token) => pixBB.getRecentReceivedTransactions(
                accessToken: token.accessToken,
                developerApplicationKey: developerApplicationKey,
              ),
            ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                int length = snapshot.data!.length;

                return ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    var transaction = snapshot.data![index];

                    return ListTile(
                      title: Text(transaction.pagador.nome.split(' ')[0]),
                      subtitle: Text(transaction.valor),
                      trailing: Text(transaction.horario),
                    );
                  },
                );
              }
              return const Center(
                child: Text('Nenhuma transação encontrada'),
              );
          }
        },
      ),
    );
  }
}
