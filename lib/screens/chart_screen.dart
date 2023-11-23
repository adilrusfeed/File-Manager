import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key});

  // Method to generate pie chart data based on file types
  List<_PieData> generatePieChartData(List<FileData> files) {
    Map<String, int?> fileCountMap = {
      'images': 0,
      'videos': 0,
      'audios': 0,
      'documents': 0,
    };

    var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
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
    var audioExtensions = [
      '.wav',
      '.aac',
      '.mp3',
      '.ogg',
      '.wma',
      '.flac',
      '.m4a'
    ];
    var documentExtensions = [
      '.pdf',
      '.doc',
      '.txt',
      '.ppt',
      '.docx',
      '.pptx',
      '.xlxs',
      '.xls'
    ];

    // Count the number of each file type
    files.forEach((file) {
      String extension = file.name.split('.').last.toLowerCase();

      if (imageExtensions.contains(extension)) {
        fileCountMap.update('images', (value) => (value ?? 0) + 1);
      } else if (videoExtensions.contains(extension)) {
        fileCountMap.update('videos', (value) => (value ?? 0) + 1);
      } else if (audioExtensions.contains(extension)) {
        fileCountMap.update('audios', (value) => (value ?? 0) + 1);
      } else if (documentExtensions.contains(extension)) {
        fileCountMap.update('documents', (value) => (value ?? 0) + 1);
      }
    });

    // Convert the map to a list of _PieData objects
    List<_PieData> pieDataList = fileCountMap.entries
        .map(
            (entry) => _PieData(entry.key, entry.value ?? 0, '${entry.value}%'))
        .toList();

    return pieDataList;
  }

  @override
  Widget build(BuildContext context) {
    // Replace this with the actual list of files in your app
    List<FileData> files = getFilesFromYourApp();

    // Generate pie chart data based on file types
    List<_PieData> pieData = generatePieChartData(files);

    return SfCircularChart(
      title: ChartTitle(text: 'Saved Files'),
      legend: const Legend(isVisible: true),
      series: <PieSeries<_PieData, String>>[
        PieSeries<_PieData, String>(
          explode: true,
          explodeIndex: 0,
          dataSource: pieData,
          xValueMapper: (_PieData data, _) => data.xData,
          yValueMapper: (_PieData data, _) => data.yData,
          dataLabelMapper: (_PieData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final int yData;
  final String text;
}

// Replace this with the actual data structure representing a file in your app
class FileData {
  final String name;
  final FileType type;
  FileData(this.name, this.type);
}

enum FileType { image, video, audio, document }

// Replace this with the actual method to get files from your app
List<FileData> getFilesFromYourApp() {
  // Return a list of files based on your app's logic
  // For example, you might retrieve this list from Hive or any other storage
  return [];
}
