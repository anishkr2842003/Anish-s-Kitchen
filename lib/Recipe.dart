import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Recipe extends StatefulWidget {

  // For get url
  String url;
  Recipe(this.url);

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  //http & https
  late String finalUrl;

  // Controller
   late WebViewController controller;

   @override
  void initState() {
    if(widget.url.toString().contains("http://"))
    {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    }
    else
    {
      finalUrl = widget.url;
    }
    String myStringurl = finalUrl;
    Uri myfinalUrl = Uri.parse(myStringurl);
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(myfinalUrl as Uri);
  }
   
   
   
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe page'),
      ),
      body: Container(
        child: WebViewWidget(
            controller: controller,
        )
      ),
    );
  }
}
