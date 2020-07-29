import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  static final _templateSheetID = "1K-dQCCMpV3UimiGH-DUf5eEAMTDUkNsiT3a8m3-Zk9A";
  static final Map<String, String> _appServiceAccountCreds = {
    "type": "service_account",
    "project_id": "juma-ee630f",
    "private_key_id": "35164a8b64fb00ef3f1f93fed09021397d862f20",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCOriByERBo1Cd1\nb/ypa9gny2BbmNFWN/K7J7jRErBFHu2cIXuURuReKiXeU3UOuP97WYulxn4Oa/v6\n97TR0CvxYxLw4ck94vdz4qlBoVAoQIlbT/Q3Ggsd4HAdJUuxWL01MfLFZIE6GTbt\nZqWj4X5KeBN2cl5w6umw4+4aLNUuS9Q+K0hLgyFtTZegrqIohQf0gY52S/Jl5+bP\nPXMGUY6g8jlt5boFWzd65COgZrmKAwsBkulyUyQG8SWMZQ8/3AszEV/XP8bmhD36\nLJG97mdXMJAlMjS1XzhChdlRL9Imo7JOF+A+QoIyN5hUFIZO2AbIz5beRtYMhAQa\n+XIIqrVFAgMBAAECggEAFrEc2eda28E6EVRhM7TCKPoQdiDk0jiNszRLEX1OaX/U\nvGsa02c+9LbxVN2jFVdY0o5YRmI+NB76cVyp9mCMTJS8M3FFZ0FMp7KZxqVYMT6q\nWcpqhcTvla3XRttioW8CkI5EFR656rqN4M3ddCXtxvw35DOmT4Ec75QgjysoMHeE\nFjx2vlnvGPc97/e9FIRtRxhLlS3AT9gO1F4urwWPmVGdg8pEAY8bPB+tdSyVyKOO\nR0mKV5nlyfdmEFVV5JxF2u39+tu0jek/xHSRjpckps6l9QskFzBPTF5x1zbRJ+y7\noBSB/NNwwX6cV77rRc+9AImQ9LYWj8Qov30VFg4m9QKBgQDEf0i4O+BvH3XV6m5Y\nOmay4/ly8r9cBizVWrhJ205LlNDK5jbcg86rtjStA7mIRcHQqDsxx2nxjVp+xJKr\nuSmP1Ype+aIjT1jPDJHRzpHgceeZpnZymKudUMidJTBxqCW2wNMoDZ4lvPvxriVb\nUZMbko4SLNoD2Cj1/sHVn9VQYwKBgQC54uDFMPLBKn2325eHTU4Cpj3qmeQ72g9x\nhxA/tcbZ2vQ+VMxFFZmw8rcJ1a6FEEAsgBq9ze3arCe1WhK7s6POuHsRpQKfvmxO\nlqZqe6+pAx6NO+A0HdJRtgmdZJg8ZUuR3sI/223e1GXssAW9NT5dlge2ynOkc2kq\nRA837ULQNwKBgD81mtT5HfdhLWzE3v4uuz6sq1/Yysn1ipKPflzz2TnjA09hwyAo\nnmEKWeOWISa/GdvfYjtfJKt5hzTkUzI+fCoyzTJEJ24oZi8kofvV8YM74P7CV7QB\nfKM8i2xRvEWzi35AhSyLROZq5rkWBhpcIXBrMpySJQe7j2GitAPeSKZ1AoGAEXu5\nUFKuQmTQtj49HkizEaS5JhubT9XOpgriCFv8e/kQB9zJ6aWCcxYhCRfD9lf08TqL\nSVbZDDws7+2s3WKkAYlwadRvTr8GSM36kQFZIDhe40HCcKRtZ6oLdXZEq0mLtgiR\nlJf62X54p65Wm9kqKHs39oVMIyeHuKX2GHiEVDkCgYBPUncTHixxmBerXhECv6sv\nYaIun3Eli4XQX6pIVdKAiaiZOgR0aA2UcYZOyNV04E8lzDd8klj3gHgG953i/JfW\nQR2ngLa3KA1YTugWsQ/0hMhggRo+Yq4mCpbI+Bxlm3zp+OO9Cdb2lzGEgvxmR2Kd\nMHdwetd4oMDaOGP0iXLG8Q==\n-----END PRIVATE KEY-----\n",
    "client_email": "juma-ee630f@appspot.gserviceaccount.com",
    "client_id": "113915598180992681075",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/juma-ee630f%40appspot.gserviceaccount.com"
  };

  final GSheets _gsheets = GSheets(_appServiceAccountCreds);

  Future<void> createSpreadsheet(String email, {String title}) async {
    // TODO email should end in @gmail.com

    title ??= 'Created By Juma ${DateTime.now()}';
    try {
      var sheetsClient = await _gsheets.client;
      // get template
      var templateSheet = await _gsheets.spreadsheet(_templateSheetID);
      if (templateSheet == null) return;
      var newSheet = await _gsheets.createSpreadsheet(title);

      for (Worksheet ws in templateSheet.sheets) {
        var res = await sheetsClient.post('https://sheets.googleapis.com/v4/spreadsheets/${templateSheet.id}/sheets/${ws.id}:copyTo', body: {"destinationSpreadsheetId": "${newSheet.id}"});

        if (res.statusCode != 200) {
          // TODO handling error for copying worksheet
        }
      }

      await newSheet.refresh();
      var sheet1 = newSheet.worksheetByTitle("Sheet1");
      if (sheet1 != null) {
        await newSheet.deleteWorksheet(sheet1);
        await newSheet.refresh();
      }
      
      for (int i=0; i<newSheet.sheets.length; i++) {
        Worksheet ws = newSheet.worksheetByIndex(i);
        if (ws.title.contains("Copy of")) {
          await ws.updateTitle(ws.title.replaceAll("Copy of ", ''));
        }
      }
      
      await newSheet.share(email, type: PermType.user, role: PermRole.owner);
      await newSheet.share(_appServiceAccountCreds['client_email'], type: PermType.user, role: PermRole.writer);
    }
    catch (e) {
      print(e);
    }
  }
}