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
  String cacheSize = "Calculating..."; // 缓存大小 Cache size

  @override
  void initState() {
    super.initState();
    loadCacheSize(); // 加载缓存大小 Load cache size
  }

  // 计算缓存大小 Calculate cache size
  Future<void> loadCacheSize() async {
    final tempDir = await getTemporaryDirectory();
    final cacheDir = Directory('${tempDir.path}/WebView');

    if (await cacheDir.exists()) {
      int totalSize = 0;
      await for (var entity
          in cacheDir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
      setState(() {
        cacheSize = '${(totalSize / 1024 / 1024).toStringAsFixed(2)} MB';
      });
    } else {
      setState(() {
        cacheSize = '0 MB';
      });
    }
  }

  // 清除缓存 Clear cache
  Future<void> clearCache() async {
    final tempDir = await getTemporaryDirectory();
    
    // 删除临时目录下的所有内容 Delete all contents in temp directory
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
      // 重新创建临时目录 Recreate temp directory
      await tempDir.create();
    }

    setState(() {
      cacheSize = '0 MB';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Current Cache Size: // 当前缓存大小',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              cacheSize,
              style: Theme.of(context).textTheme.headlineMedium,
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
