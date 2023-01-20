import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fractal_rich_input/fractal_rich_input.dart';
import 'package:fractal_rich_input/fractal_rich_input_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Fractal Rich Input Example'),
      );
    }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = FractalRichInputController();
  bool showBlue = false;

  @override
  void initState() {
    FractalRichInput.addFormatRegexIdentifierStyle(
      key: r"###(.*?)###",
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
            onChanged: (value) {
              setState(() {});
            },
          ),
          RichText(
            text: FractalRichInput.buildTextSpan(
              text: _controller.text,
              style: const TextStyle(
                color: Colors.black,
              ),
              linkHighlightColor: showBlue ? Colors.blue : Colors.green,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            showBlue = !showBlue;
          });
        },
        label: const Text("Toggle Color"),
      ),
    );
  }
}
