// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifier {
  final _modelFile = 'classifier.tflite';
  final _labelFile = 'labels.txt';

  // // maximum length of sentence
  final int _sentenceLen = 256;

  final String start = '<START>';
  final String pad = '<PAD>';
  final String unk = '<UNKNOWN>';

  late Map<String, int> _dict;

  // tensorflow lite interpreter object
  late Interpreter _interpreter;

  Classifier() {
    _loadModel();
    _loadDictionary();
  }

  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(_modelFile);
    debugPrint('Interpreter loaded successfully');
  }

  void _loadDictionary() async {
    final labels = await rootBundle.loadString('assets/$_labelFile');
    var dict = <String, int>{};
    final labelList = labels.split('\n');

    for (var label in labelList) {
      var entry = label.trim().split(' ');
      dict[entry[0]] = int.parse(entry[1]);
    }

    _dict = dict;
    debugPrint(_dict.toString());
  }

  // void classify(String rawText) {
  //   List<List<double>> input = tokenizeInputText(rawText);

  //   // output of shape [1, 2]
  //   var output = List<double>.filled(5, 0).reshape([1, 5]);

  //   // the run method will run inference and
  //   // store the resulting values in output
  //   _interpreter.run(input, output);
  //   // print(output[0][1]);
  //   // return [output[0][0], output[0][0]];
  // }

  // List<List<double>> tokenizeInputText(String text) {
  //   // whitespace tokenization
  //   final toks = text.split(' ');

  //   // create a list of length==_sentenceLen filled with the value <pad>
  //   var vec = List<double>.filled(_sentenceLen, 0);

  //   var index = 0;

  //   // for each word in sentence find corresponding index in dict
  //   for (var tok in toks) {
  //     if (index > _sentenceLen) {
  //       break;
  //     }
  //     vec[index++] = _dict[tok]!.toDouble();
  //   }
  //   // returning List<List<double>> as our interpreter input tensor expects the shape [1, 256]
  //   return [vec];
  // }
}
