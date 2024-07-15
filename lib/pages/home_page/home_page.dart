import 'package:todo_app_with_firebase/headers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseServices.instance.getStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snaps) {
            if (snaps.hasData) {
              QuerySnapshot? snapData = snaps.data;
              List<QueryDocumentSnapshot> allDocs = snapData?.docs ?? [];

              List<Todo> allTodos = allDocs
                  .map(
                    (e) => Todo.fromMap(e.data() as Map),
                  )
                  .toList();

              return ListView.builder(
                itemCount: allTodos.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(allTodos[index].title),
                    trailing: Checkbox(
                      value: allTodos[index].status,
                      onChanged: (val) {
                        allTodos[index].status = val ?? false;

                        FirebaseServices.instance.updateStatus(
                          todoModel: allTodos[index],
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseServices.instance.addTodo(
            todo: Todo('id', 'title', false, 0),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
