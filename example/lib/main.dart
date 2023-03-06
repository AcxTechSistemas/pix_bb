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

final pixBB = PixBB(
  ambiente: Ambiente.homologacao,
  basicKey:
      'Basic ZXlKcFpDSTZJamMzWlRka01tUXRNak14TUMwME9UUTBJaXdpWTI5a2FXZHZVSFZpYkdsallXUnZjaUk2TUN3aVkyOWthV2R2VTI5bWRIZGhjbVVpT2pVMU9URXhMQ0p6WlhGMVpXNWphV0ZzU1c1emRHRnNZV05oYnlJNk1YMDpleUpwWkNJNklqZGtOV1l4T1dJdFkySTROeTAwWkRCbUxUaGtaV010T1RVMk4yVXlaaUlzSW1OdlpHbG5iMUIxWW14cFkyRmtiM0lpT2pBc0ltTnZaR2xuYjFOdlpuUjNZWEpsSWpvMU5Ua3hNU3dpYzJWeGRXVnVZMmxoYkVsdWMzUmhiR0ZqWVc4aU9qRXNJbk5sY1hWbGJtTnBZV3hEY21Wa1pXNWphV0ZzSWpveExDSmhiV0pwWlc1MFpTSTZJbWh2Ylc5c2IyZGhZMkZ2SWl3aWFXRjBJam94TmpjM05EY3dOVFUwTVRjNGZR',
  appDevKey: '65a4f02e75e68dfbe07b35326a318fe9',
);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Pix V1 Banco do Brasil'),
      ),
      body: FutureBuilder(
        future: pixBB.getToken().then(
              (token) => pixBB.getRecentReceivedTransactions(
                accessToken: token.accessToken,
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
