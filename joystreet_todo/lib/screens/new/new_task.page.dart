import 'package:flutter/material.dart';
import 'package:joystreet_todo/model/task.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controladorDescricao = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova tarefa'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Salvar',
        onPressed: () {
          Navigator.pop(context, Task(descricao: _controladorDescricao.text));
        },
        label: const Text('Salvar'),
        icon: const Icon(Icons.save),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Semantics(
                  label: 'Input de descrição de tarefa',
                  child: TextFormField(
                    controller: _controladorDescricao,
                    decoration: InputDecoration(
                      hintText: 'Botar a comida do cachorro...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
