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

final pixBB = PixBB();
const basicKey = 'BASIC_KEY';
const developerApplicationKey = 'DEV_APP_KEY';

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
