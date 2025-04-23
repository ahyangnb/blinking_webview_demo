import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///缓存大小
  double cache = 0;

  String cacheStr = "0.00B";

  @override
  void initState() {
    super.initState();
    loadCacheSize(); // 加载缓存大小 Load cache size
  }


  Future<double> getCurrentTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File && file.existsSync()) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      List currentChildren = file.listSync();
      double currentTotalCache = 0;
      if (currentChildren.isNotEmpty)
        for (final FileSystemEntity child in currentChildren) {
          currentTotalCache += await getCurrentTotalSizeOfFilesInDir(child);
        }
      return currentTotalCache;
    }
    return 0.0;
  }

  // 计算缓存大小 Calculate cache size
  Future<void> loadCacheSize() async {
      /// 获取文件夹
    Directory currentAppDirectory = await getTemporaryDirectory();

    /// 获取缓存大小
    double cacheValueSize =
        await getCurrentTotalSizeOfFilesInDir(currentAppDirectory);
    cache = cacheValueSize;
    cacheStr = formatAppCacheSize(cache);
    if(mounted){
      setState(() {});
    }
  }

  //格式化文件大小
  String formatAppCacheSize(cache) {
    if (cache == null) {
      return '0.0';
    }
    List<String> arrayUnit = []
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (cache > 1024) {
      index++;
      cache = cache / 1024;
    }
    String currentAppSize = cache.toStringAsFixed(2);
    return currentAppSize + arrayUnit[index];
  }
  // 清除缓存 Clear cache
  clearCache() async {
    Directory cacheDir = await getTemporaryDirectory();
    cacheStr = "0.00B";
    if (cacheDir.existsSync()) {
      // cacheDir.deleteSync(recursive: true);
      deleteCurrentAppDirectory(cacheDir);
    }
    if(mounted){
      setState(() {});
    }
    // encounterPrint("缓存目录已删除");
    //删除缓存目录
    // await deleteCurrentAppDirectory(currentAppDirectory);
    // loadApplicationCache();
  }

  /// 递归方式删除目录
  deleteCurrentAppDirectory(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteCurrentAppDirectory(child);
      }
    }
    await file.delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Flutter WebView Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 显示缓存大小 Display cache size
            Text(
              'Current Cache Size:',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.red.withAlpha(170)),
            ),
            Text(
              cacheStr,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.red.withAlpha(170)),
            ),
            const SizedBox(height: 20),
            // 清除缓存按钮 Clear cache button
            ElevatedButton(
              onPressed: clearCache,
              child: const Text('Clear Cache // 清除缓存'),
            ),
            const SizedBox(height: 20),
            // 打开WebView按钮 Open WebView button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewScreen(),
                  ),
                );
              },
              child: const Text('Open Flutter Website // 打开Flutter官网'),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Official Website'),
        actions: [
          // 返回主页的按钮 Button to return to home page
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            ),
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
