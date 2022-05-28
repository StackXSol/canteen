import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// Use the SmtpServer class to configure an SMTP server:

String username = "info@stackx.online";
final smtpServer = SmtpServer("stackx.online",
    ignoreBadCertificate: true,
    username: username,
    password: "StackX@123",
    allowInsecure: true);

void orderNotifyUser(email, orderid) async {
  // Create our message.
  final message = Message()
    ..from = Address(username, "InIt")
    ..recipients.add(email)
    ..subject = 'Your order is placed with id $orderid'
    ..text =
        "We are happy to inform you that we have recieved your order with Order-ID $orderid.\nYour data is sent to the canteen, you can take away your food using the QR code provided in the app.\nThankyou for using our app and do let us know about the app on App Store.\nHave a good meal.";

  try {
    final sendReport = await send(message, smtpServer);

    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print(e);
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

void orderNotifyAdmin(email, orderid) async {
  // Create our message.

  final order_up = Message()
    ..from = Address(username, "StackX-AstroDrishti")
    ..recipients.add('StackX1617@gmail.com')
    ..subject = 'New Order With with id $orderid'
    ..text =
        "Please ensure scanning QR code before providing the order and check the items in it.";

  try {
    final sendReport = await send(order_up, smtpServer);

    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print(e);
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

void Register(email) async {
  // Create our message.
  final message = Message()
    ..from = Address(username, "InIt")
    ..recipients.add(email)
    ..subject = 'Welcome to init'
    ..text =
        "We are happy to wecome you on our platform. This brings your local canteen into your device,\nsaving all the time from queue's, now you can\norder your favourite ";

  try {
    final sendReport = await send(message, smtpServer);

    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print(e);
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
