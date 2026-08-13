import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ExternalLinks {
  static const _contactNumber = '221782780302';
  static const _contactEmail = 'novateur221@gmail.com';

  static final Uri community = Uri.parse(
    'https://chat.whatsapp.com/It78AylzQgF1Pce3aSjkFH?s=cl&p=a&ilr=4',
  );
  static final Uri privacy = Uri.parse(
    'https://novateur.netlify.app/confidentialiteMg.html',
  );
  static final Uri droneAtlasAcademy = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.novateur221.droneatlas',
  );

  static Uri certificationWhatsApp(
    String moduleTitle,
  ) => Uri.https('wa.me', '/$_contactNumber', <String, String>{
    'text':
        'Bonjour Novateur221, je souhaite recevoir les modalités du parcours de certification « $moduleTitle » dans Moi Géomaticien.',
  });

  static Uri certificationEmail(String moduleTitle) => Uri(
    scheme: 'mailto',
    path: _contactEmail,
    query: _encodeQueryParameters(<String, String>{
      'subject': 'Demande de certification — $moduleTitle',
      'body':
          'Bonjour Novateur221,\n\nJe souhaite recevoir les modalités du parcours de certification « $moduleTitle » : programme, prérequis, calendrier, évaluation et tarif.\n\nCordialement,',
    }),
  );

  static Uri get generalCertificationWhatsApp =>
      certificationWhatsApp('parcours adapté à mon secteur');

  static Uri get generalCertificationEmail =>
      certificationEmail('parcours adapté à mon secteur');

  static Uri get generalWhatsApp => Uri.https('wa.me', '/$_contactNumber', <
    String,
    String
  >{
    'text':
        'Bonjour Novateur221, je vous contacte depuis l’application Moi Géomaticien.',
  });

  static Uri get generalEmail => Uri(
    scheme: 'mailto',
    path: _contactEmail,
    query: _encodeQueryParameters(<String, String>{
      'subject': 'Contact depuis Moi Géomaticien',
      'body':
          'Bonjour Novateur221,\n\nJe vous contacte depuis l’application Moi Géomaticien.\n\nCordialement,',
    }),
  );

  static String _encodeQueryParameters(Map<String, String> params) => params
      .entries
      .map(
        (entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
      )
      .join('&');
}

Future<void> openExternalLink(
  BuildContext context,
  Uri uri, {
  String failureMessage = 'Impossible d’ouvrir ce lien sur cet appareil.',
}) async {
  try {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureMessage)));
    }
  } catch (error) {
    debugPrint('Ouverture du lien impossible : $error');
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failureMessage)));
    }
  }
}
