import 'package:do_it/models/quest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // encode to json

class QuestsRepository {
  static const _storageKey = 'quests';

  Future<List<Quest>> loadQuests() async {
    final prefs = await SharedPreferences.getInstance();
    final questsListJson = prefs.getStringList(_storageKey) ?? []; //load quests and an empty list incase nothing on the storage
    return questsListJson.map((questJson) => Quest.fromJson(json.decode(questJson))).toList();
  }
  
  Future<void> saveQuest(List<Quest> quests) async {
    final prefs = await SharedPreferences.getInstance();
    final questsListJson = quests.map((quest) => json.encode(quest.toJson())).toList();
    await prefs.setStringList(_storageKey, questsListJson);
  }
}