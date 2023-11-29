// ignore_for_file: prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path/path.dart' as path;

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _PieData {
  _PieData(this.xData, this.yData, this.text, this.percentage);

  final String xData;
  final num yData;
  final String text;
  final double percentage;
}

bool isImageFile(String fileName) {
  var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
  var extension = path.extension(fileName).toLowerCase();
  return imageExtensions.contains(extension);
}

bool isVideoFile(String fileName) {
  var videoExtensions = [
    '.mkv',
    '.mp4',
    '.avi',
    '.flv',
    '.wmv',
    '.mov',
    '.3gp',
    '.webm'
  ];
  var extension = path.extension(fileName).toLowerCase();
  return videoExtensions.contains(extension);
}

bool isAudioFile(String fileName) {
  var audioExtensions = [
    '.wav',
    '.aac',
    '.mp3',
    '.ogg',
    '.wma',
    '.flac',
    '.m4a',
    '.opus'
  ];
  var extension = path.extension(fileName).toLowerCase();
  return audioExtensions.contains(extension);
}

bool isDocumentFile(String fileName) {
  var documentExtensions = [
    '.pdf',
    '.doc',
    '.txt',
    '.ppt',
    '.docx',
    '.pptx',
    '.xlxs',
    '.xls',
    '.html'
  ];
  var extension = path.extension(fileName).toLowerCase();
  return documentExtensions.contains(extension);
}

class _ChartScreenState extends State<ChartScreen> {
  late List<_PieData> pieData;

  @override
  void initState() {
    super.initState();
    updateChartData();

    FileNotifier.addListener(() {
      updateChartData();

      if (mounted) {
        setState(() {});
      }
    });
  }

  void updateChartData() {
    int imageCount =
        FileNotifier.value.where((file) => isImageFile(file.fileName)).length;
    int videoCount =
        FileNotifier.value.where((file) => isVideoFile(file.fileName)).length;
    int audioCount =
        FileNotifier.value.where((file) => isAudioFile(file.fileName)).length;
    int documentCount = FileNotifier.value
        .where((file) => isDocumentFile(file.fileName))
        .length;

    int totalCount = imageCount + videoCount + audioCount + documentCount;
    double imagePercentage = (imageCount / totalCount) * 100;
    double videoPercentage = (videoCount / totalCount) * 100;
    double audioPercentage = (audioCount / totalCount) * 100;
    double documentPercentage = (documentCount / totalCount) * 100;

    pieData = [
      _PieData(
          'Images',
          imageCount,
          '$imageCount\n${imagePercentage.toStringAsFixed(2)}%',
          imagePercentage),
      _PieData(
          'Videos',
          videoCount,
          '$videoCount\n${videoPercentage.toStringAsFixed(2)}%',
          videoPercentage),
      _PieData(
          'Audios',
          audioCount,
          '$audioCount\n${audioPercentage.toStringAsFixed(2)}',
          audioPercentage),
      _PieData(
          'Documents',
          documentCount,
          '$documentCount\n${documentPercentage.toStringAsFixed(2)}',
          documentPercentage),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int totalCount =
        pieData.map((data) => data.yData.toInt()).reduce((a, b) => a + b);

    return Stack(children: [
      SfCircularChart(
        title: ChartTitle(
            text: 'Analyze the files',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        legend: const Legend(isVisible: true),
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
            explode: true,
            explodeIndex: 0,
            dataSource: pieData,
            xValueMapper: (_PieData data, z_) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            dataLabelMapper: (_PieData data, _) => data.text,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Total Files:$totalCount',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    ]);
  }
}
