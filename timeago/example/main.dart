import 'dart:async' show Timer;
import 'dart:html';
import 'package:timeago/timeago.dart' as timeago;

final mainContainer = querySelector("#main");
final listContainer = querySelector("#list");

var locale = 'en';

main() async {
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('ja', timeago.JaMessages());
  timeago.setLocaleMessages('id', timeago.IdMessages());
  timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
  timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
  timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
  timeago.setLocaleMessages('zh', timeago.ZhMessages());
  timeago.setLocaleMessages('it', timeago.ItMessages());
  timeago.setLocaleMessages('fa', timeago.FaMessages());
  timeago.setLocaleMessages('ru', timeago.RuMessages());
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  timeago.setLocaleMessages('pl', timeago.PlMessages());
  timeago.setLocaleMessages('th', timeago.ThMessages());
  timeago.setLocaleMessages('th_short', timeago.ThShortMessages());
  timeago.setLocaleMessages('nb_NO', timeago.NbNoShortMessages());

  final loadedTime = new DateTime.now();

  final updateMainContainer = () {
    final now = new DateTime.now();
    final difference = now.difference(loadedTime);
    mainContainer.text = timeago.format(now.subtract(difference), locale: locale);
  };

  querySelectorAll(".locale-link").onClick.listen((event) async {
    final el = event.target as AnchorElement;

    locale = el.text;

    // Recreate list items
    listContainer.innerHtml = "";
    createListItems();
  });

  updateMainContainer();
  createListItems();

  new Timer.periodic(new Duration(seconds: 1), (_) => updateMainContainer());
}

addItem(String text) {
  listContainer.append(new LIElement()..text = text);
}

createListItems() {
  final currentTime = new DateTime.now();
  addItem(
      timeago.format(currentTime.subtract(new Duration(microseconds: 1 * 44 * 1000)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(minutes: 1)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(minutes: 5)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(minutes: 50)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(hours: 5)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(days: 1)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(days: 5)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(days: 30)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(days: 30 * 5)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(days: 365)), locale: locale));
  addItem(timeago.format(currentTime.subtract(new Duration(days: 365 * 5)), locale: locale));

  addItem("-");

  addItem(
      timeUntil(currentTime.add(new Duration(microseconds: 1 * 44 * 1000))));
  addItem(timeUntil(currentTime.add(new Duration(minutes: 1))));
  addItem(timeUntil(currentTime.add(new Duration(minutes: 5))));
  addItem(timeUntil(currentTime.add(new Duration(minutes: 50))));
  addItem(timeUntil(currentTime.add(new Duration(hours: 5))));
  addItem(timeUntil(currentTime.add(new Duration(days: 1))));
  addItem(timeUntil(currentTime.add(new Duration(days: 5))));
  addItem(timeUntil(currentTime.add(new Duration(days: 30))));
  addItem(timeUntil(currentTime.add(new Duration(days: 30 * 5))));
  addItem(timeUntil(currentTime.add(new Duration(days: 365))));
  addItem(timeUntil(currentTime.add(new Duration(days: 365 * 5))));
}

String timeUntil(DateTime date) {
  return timeago.format(date, locale: locale, allowFromNow: true);
}