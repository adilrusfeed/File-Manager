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
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final num yData;
  final String text;
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

    pieData = [
      _PieData('Images', imageCount, 'images\n$imageCount,\nfiles'),
      _PieData('Videos', videoCount, 'videos\n$videoCount,\nfiles'),
      _PieData('Audios', audioCount, 'audios\n$audioCount,\nfiles'),
      _PieData('Documents', documentCount, 'documents\n$documentCount,\nfiles'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
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
    );
  }

  @override
  void dispose() {
    // Remove the listener to avoid memory leaks
    FileNotifier.removeListener(() {});
    super.dispose();
  }
}
