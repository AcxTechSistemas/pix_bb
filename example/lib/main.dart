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
      theme: ThemeData(useMaterial3: true),
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

class _HomePageState extends State<HomePage> {
  late PixBB pixBB;
  @override
  void initState() {
    super.initState();
    pixBB = PixBB(
      ambiente: Ambiente.producao,
      basicKey: '',
      developerApplicationKey: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Api Pix V1 Banco do Brasil')),
      body: FutureBuilder(
        future: pixBB.getToken().then(
          (token) => pixBB.fetchTransactions(
            token: token,
            dateTimeRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 4)),
              end: DateTime.now(),
            ),
          ),
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                int length = snapshot.data!.length;

                return RefreshIndicator(
                  onRefresh: () {
                    return Future(() => setState(() {}));
                  },
                  child: ListView.builder(
                    itemCount: length,
                    itemBuilder: (context, index) {
                      var transaction = snapshot.data![index];

                      return ListTile(
                        title: Text(transaction.pagador.nome.split(' ')[0]),
                        subtitle: Text(transaction.valor),
                        trailing: Text(transaction.horario),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                if (snapshot.error is PixException) {
                  final error = snapshot.error;
                  final errorMessage =
                      error is PixException
                          ? error.error
                          : snapshot.error.toString();
                  return Center(child: Text(errorMessage));
                }
              }
              return const Center(child: Text('Nenhuma transação encontrada'));
          }
        },
      ),
    );
  }
}
