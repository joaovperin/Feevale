import 'domain/app_client.dart';
import 'domain/events/app_events.dart';

final clientsRepository = AppClientRepository();

void broadcastEvt(AppEvent event) {
  final _allClients = clientsRepository.listClients();
  final evtBytes = event.toBytes();

  for (final c in _allClients) {
    try {
      c.socket.add(evtBytes);
    } catch (err) {
      print('error in broadcast ${event.type.name} to ${c.nickname}: $err');
    }
  }
}

const _remindersList = [
  'Beba água!! 💦',
  'Nunca se esqueça: putz, esqueci já kkk 🤣🤣🤣😂😂😂🤣😅😆',
  'Se a vida te der limões 🍋, faça uma caipira!! E me chame pra tomar 🥹',
  'Insira um aviso criativo aqui',
  'Jesus te ama ❤️‍🔥',
  '🎈 Feliz aniversário!!!  🎈',
];

int _lastIdx = 0;

void broadcastAnyReminder() {
  if (_lastIdx >= _remindersList.length) {
    _lastIdx = 0;
  }
  broadcastEvt(AppEvent.reminder(_remindersList[_lastIdx++]));
}
