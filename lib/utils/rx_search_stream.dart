import 'package:flutter/cupertino.dart';
import 'package:rxdart/subjects.dart';

class RxSearchStream{

  static Stream<String> fromView(TextEditingController searchController) {
    final PublishSubject<String> publishSubject = PublishSubject<String>();
    void listener() {
      publishSubject.add(searchController.text);
    }
    searchController.addListener(listener);
    publishSubject.onCancel = () {
      searchController.removeListener(listener);
      publishSubject.close();
    };
    return publishSubject.stream;
  }

}