import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class Advisor with ChangeNotifier {
  final String image;
  final String first;
  final String last;
  final String id;
  final String about;

  Advisor({
    required this.id,
    required this.first,
    required this.last,
    required this.image,
    required this.about,
  });
}

class AdvisorsProvider with ChangeNotifier {
  final List<Advisor> _advisors = [
    Advisor(
      id: 'a1',
      first: 'Jeremy',
      last: 'Mzuka',
      image:
          'https://cherrydeck-blog.b-cdn.net/blog/wp-content/uploads/2020/11/Klara-Waldberg.png',
      about: '',
    ),
    Advisor(
      id: 'a2',
      first: 'Ivan',
      last: 'Kimeu',
      image:
          'https://www.worldphoto.org/sites/default/files/default-media/Piercy.jpg',
      about: '',
    ),
    Advisor(
      id: 'a3',
      first: 'Elizabeth',
      last: 'Nafula',
      image:
          'https://i.pinimg.com/736x/a3/ac/1e/a3ac1ed5abaedffd9947face7901e14c.jpg',
      about: '',
    ),
    Advisor(
      id: 'a4',
      first: 'Justin',
      last: 'Mawira',
      image:
          'https://i.pinimg.com/550x/26/12/73/261273da88b3732c008a871d0284642b.jpg',
      about: '',
    ),
    Advisor(
      id: 'a5',
      first: 'Maureen',
      last: 'Gacheri',
      image:
          'https://dvyvvujm9h0uq.cloudfront.net/com/articles/1525891879-150444-oladimeji-odunsi-415606-unsplashjpg.jpg',
      about: '',
    ),
    Advisor(
      id: 'a6',
      first: 'Ann',
      last: 'Nkirote',
      image:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80',
      about: '',
    ),
  ];

  List get advisors {
    return [..._advisors];
  }

  Advisor findById(String id) {
    return _advisors.firstWhere((advisor) => advisor.id == id);
  }

  // Future<void> fetchAdvisors() async {
  //   http.Client client = http.Client();
  //   String baseUrl = '';

  //   try {
  //     final res = await client.get(Uri.http(baseUrl, ''));
  //     final extractedData = json.decode(res.body) as Map<String, dynamic>;
  //     final List<Advisor> loadedAdvisors = [];
  //     extractedData.forEach((advrId, advisorData) {
  //       loadedAdvisors.add(
  //         Advisor(
  //           id: advrId,
  //           first: advisorData['first'],
  //           last: advisorData['last'],
  //           image: advisorData['image'],
  //         ),
  //       );
  //     });

  //     _advisors = loadedAdvisors;
  //     notifyListeners();
  //   } catch (err) {
  //     throw err;
  //   }
  // }
}
