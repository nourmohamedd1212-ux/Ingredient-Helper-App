import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> ingredients = [];
  List<String> suggestions = [];

  // Generate meal suggestions based on ingredients
  void generateSuggestions() {
    List<String> normalized =
        ingredients.map((e) => e.trim().toLowerCase()).toList();

    suggestions.clear();

    // Full combination matches first
    if (normalized.contains("egg") && normalized.contains("bread")) {
      suggestions.addAll(["French Toast", "Egg Sandwich"]);
    }
    if (normalized.contains("chicken") && normalized.contains("rice")) {
      suggestions.addAll(["Chicken Fried Rice", "Chicken Rice Bowl"]);
    }
    if (normalized.contains("pasta") && normalized.contains("tomato")) {
      suggestions.addAll(["Tomato Pasta", "Italian Marinara Pasta"]);
    }

    // Single ingredient matches (avoid duplicates)
    if (normalized.contains("egg") && !suggestions.contains("Egg Sandwich")) {
      suggestions.add("Egg Sandwich");
    }
    if (normalized.contains("bread")) {
      if (!suggestions.contains("French Toast")) suggestions.add("French Toast");
      if (!suggestions.contains("Egg Sandwich")) suggestions.add("Egg Sandwich");
    }
    if (normalized.contains("chicken")) {
      if (!suggestions.contains("Chicken Fried Rice")) suggestions.add("Chicken Fried Rice");
      if (!suggestions.contains("Chicken Rice Bowl")) suggestions.add("Chicken Rice Bowl");
    }
    if (normalized.contains("rice")) {
      if (!suggestions.contains("Chicken Fried Rice")) suggestions.add("Chicken Fried Rice");
      if (!suggestions.contains("Chicken Rice Bowl")) suggestions.add("Chicken Rice Bowl");
    }
    if (normalized.contains("pasta")) {
      if (!suggestions.contains("Tomato Pasta")) suggestions.add("Tomato Pasta");
      if (!suggestions.contains("Italian Marinara Pasta")) suggestions.add("Italian Marinara Pasta");
    }
    if (normalized.contains("tomato")) {
      if (!suggestions.contains("Tomato Pasta")) suggestions.add("Tomato Pasta");
      if (!suggestions.contains("Italian Marinara Pasta")) suggestions.add("Italian Marinara Pasta");
    }

    // If nothing matched
    if (suggestions.isEmpty) {
      suggestions.add("No exact match – try adding more ingredients");
    }

    setState(() {});
  }

  // Map meal names to images
  Widget getImageForMeal(String meal) {
    switch (meal) {
      case "French Toast":
        return Image.asset("assets/images/french_toast.jpg", height: 120);
      case "Egg Sandwich":
        return Image.asset("assets/images/egg_sandwich.jpg", height: 120);
      case "Chicken Fried Rice":
        return Image.asset("assets/images/chicken_fried_rice.jpg", height: 120);
      case "Chicken Rice Bowl":
        return Image.asset("assets/images/chicken_rice_bowl.jpg", height: 120);
      case "Tomato Pasta":
        return Image.asset("assets/images/tomato_pasta.jpg", height: 120);
      case "Italian Marinara Pasta":
        return Image.asset("assets/images/italian_marinarapasta.jpg", height: 120);
      default:
        return SizedBox(); // No image for unknown meal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/recipe_bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Color(0xFFF5EAD6).withOpacity(0.85),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Your Ingredients",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800]),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Add ingredient",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[700],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14)),
                          onPressed: () {
                            final text = _controller.text.trim();
                            if (text.isNotEmpty) {
                              ingredients.add(text);
                              _controller.clear();
                              setState(() {});
                            }
                          },
                          child: Text("Add Ingredient"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[700],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14)),
                          onPressed: () {
                            ingredients.clear();
                            suggestions.clear();
                            _controller.clear();
                            setState(() {});
                          },
                          child: Text("Clear Ingredients"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ingredients
                        .map((item) => Chip(
                              label: Text(item,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.brown[400],
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[800],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14)),
                    onPressed: generateSuggestions,
                    child: Text("Show Meal Suggestions"),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: suggestions
                          .map((s) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "• $s",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown[800]),
                                    ),
                                    SizedBox(height: 10),
                                    getImageForMeal(s),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
