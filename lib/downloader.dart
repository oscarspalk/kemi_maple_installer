import 'dart:io';

class Downloader {
  static Future<List<int>> download(String url) async {
    HttpClientRequest elementsRequest =
        await HttpClient().getUrl(Uri.parse(url)).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw "timeout";
      },
    );
    HttpClientResponse elementsResponse = await elementsRequest.close();
    List<List<int>> bytes = await elementsResponse.toList();
    return bytes.expand((element) => element).toList();
  }

  static Future<void> saveTo(String location, List<int> bytes) async {
    File file = File(location);
    File actualFile = await file.create(recursive: true);
    await actualFile.writeAsBytes(bytes);
  }
}
