import 'package:do_it/models/quest.dart';
import 'package:do_it/widgets/quest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:do_it/repositories/quests_repository.dart';

class QuestsPage extends StatefulWidget {
  const QuestsPage({super.key});

  @override
  State<QuestsPage> createState() => _QuestsPageState();
}

class _QuestsPageState extends State<QuestsPage> {
  final questTitleController = TextEditingController();
  final questDescriptionController = TextEditingController();
  final QuestsRepository questsRepository = QuestsRepository();

  List<Quest> quests = [];

  @override
  void initState() {
    super.initState();
    loadQuests();
  }

  void loadQuests() async {
    final loadedQuests = await questsRepository.loadQuests();
    setState(() {
      quests = loadedQuests;
    });
  }

  void removeQuest(Quest quest) {
    setState(() {
      quests.remove(quest);
    });
    questsRepository.saveQuest(quests);
  }

  void addQuest(Quest quest) {
    setState(() {
      quests.add(quest);
    });
    questsRepository.saveQuest(quests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: const Image(
            image: AssetImage("lib/assets/images/logo.png"),
            width: 38,
            height: 38,
          ),
        ),
        title: const Text('To Do'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ...quests.map((quest) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Slidable(
                    key: ValueKey(quest.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            removeQuest(quest);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: MyQuest(
                      quest: quest,
                      onChanged: (value) {
                        setState(() {
                          quest.toggleDone();
                          questsRepository.saveQuest(quests);
                        });
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: questTitleController,
                          decoration: const InputDecoration(
                            labelText: 'Quest Title',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: questDescriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Quest Description',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            final title = questTitleController.text;
                            final description = questDescriptionController.text;
                            if (title.isNotEmpty && description.isNotEmpty) {
                              final quest = Quest(
                                id: DateTime.now().toString(),
                                title: title,
                                description: description,
                                isDone: false,
                              );
                              questTitleController.clear();
                              questDescriptionController.clear();
                              addQuest(quest);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Add Quest'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
