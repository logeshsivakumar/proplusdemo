
import 'package:awesome_notifications/awesome_notifications.dart';


class NotificationLocal{

  static localNotification(String title, String price ,String img)async{
    await AwesomeNotifications().createNotification(content:
    NotificationContent(
        id: 1,
        channelKey: 'key1',
      title: title,
      body: "Price:$price",
      bigPicture: img,
      notificationLayout: NotificationLayout.BigPicture
    )
    );
  }
}