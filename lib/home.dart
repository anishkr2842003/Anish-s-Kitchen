import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kitchen_recipe/Recipe.dart';
import 'package:kitchen_recipe/model.dart';
import 'package:kitchen_recipe/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Loding then page refresh
  bool isLoading = true;

  // List of Recipe
  List<RecipeModel> recipeList = <RecipeModel>[

  ];


  // Search controller
  TextEditingController searchController = TextEditingController();


  // get recepi function
  void getRecepi(String query) async
  {
    //API food recipe
    String url = 'https://api.edamam.com/search?q=$query&app_id=b1bf59ef&app_key=1c777c1884ac368c22adccda81da9660';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    // get data from API

    data["hits"].forEach((element){
      RecipeModel recipeModel = new RecipeModel(applabel: '', appimgUrl: '', appcalories: 0, appurl: '');
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
    });

  }

  //init function

  @override
  void initState() {
    print('hello ji');
    getRecepi('ladoo');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff213A50),
                    Color(0xff071938)
                  ]
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [


                //Search Bar
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if((searchController.text).replaceAll(" ", "") == "")
                            {
                              print("Blank search");
                            }else{
                              Navigator.push(context, MaterialPageRoute(builder: (context) => search(searchController.text),));
                            }

                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Let's Cook Something!"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //Headings
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("WHAT DO YOU WANT TO COOK TODAY?", style: TextStyle(fontSize: 33, color: Colors.white),),
                      SizedBox(height: 10,),
                      Text("Let's Cook Something New!", style: TextStyle(fontSize: 20,color: Colors.white),)
                    ],
                  ),
                ),
                //List view builder
                Container(
                  child: isLoading ? CircularProgressIndicator() : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recipeList.length,
                    itemBuilder: (context, index)
                    {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Recipe(recipeList[index].appurl),));
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        elevation: 0.0,
                        child: Stack(
                          children: [
                            // Food Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(recipeList[index].appimgUrl, fit: BoxFit.cover, width: double.infinity, height: 300,)
                            ),
                            // Food Name
                            Positioned(
                              left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    )
                                  ),
                                  child: Text(recipeList[index].applabel, style: TextStyle(color: Colors.white, fontSize: 20),),
                                )
                            ),
                            // Calories data
                            Positioned(
                                right: 0,
                                height: 40,
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),

                                    )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.local_fire_department),
                                        Text(recipeList[index].appcalories.toInt().toString(), style: TextStyle(
                                          color: Colors.black
                                        ),),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    );
                  },),
                ),



              ],
            ),
          )
        ],
      ),
    );
  }
}
