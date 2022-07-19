import 'package:flutter/material.dart';
import 'package:joystreet_todo/model/task.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({Key? key, required this.item}) : super(key: key);

  final Task item;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controladorDescricao =
        TextEditingController(text: widget.item.descricao);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe da tarefa'),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await showDialog<bool?>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Aviso"),
                    content: const Text("Ao continuar, a tarefa será excluída"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('CANCELAR'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
              if (result != null && result) Navigator.pop(context, null);
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Salvar',
        onPressed: () {
          Navigator.pop(context, widget.item);
        },
        label: const Text('Salvar'),
        icon: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (String? val) {
                  if (val == null) {
                    widget.item.descricao = "";
                    return;
                  }
                  widget.item.descricao = val;
                },
                controller: _controladorDescricao,
                decoration: InputDecoration(
                  hintText: 'Botar a comida do cachorro...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Checkbox(
              value: widget.item.concluido,
              onChanged: (bool? val) {
                if (val == null) {
                  return;
                }
                setState(
                  () {
                    widget.item.concluido = val;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
