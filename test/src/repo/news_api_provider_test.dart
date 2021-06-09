import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/bloc/repo/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main () {
  test("sum of 2 integers", () {
    final sum =2+2;
    expect(sum, 4);

  });

  test("fetch top ids indeed returns a list of ids", () async{
   final data ="[ 9127232, 9128437, 9130049, 9130144, 9130064, 9130028, 9129409 ]";

   final apiProvider = NewsApiProvider();

    apiProvider.client = MockClient((request)async{
    // MockClient((request)async{
      return Response(data,200);
    });
    final ids = await apiProvider.fetchTopIds();
    expect(ids, [ 9127232, 9128437, 9130049, 9130144, 9130064, 9130028, 9129409 ]);
  });

}
