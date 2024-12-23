// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Default theme mode
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> items = [];
  bool showInputField = false; // To toggle input field visibility
  TextEditingController textController = TextEditingController();
  ThemeMode themeMode = ThemeMode.system; // Current theme mode

  void addItem() {
    if (textController.text.isNotEmpty) {
      setState(() {
        items.add(textController.text);
        textController.clear();
        showInputField = false; // Close input field after adding
      });
    }
  }

  void toggleInputField() {
    setState(() {
      showInputField = !showInputField;
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void changeThemeMode(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: themeMode, // Apply selected theme mode
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            'Todo List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            // Main content: Display the list of items
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      children: [
                        // Background for swipe action
                        Positioned.fill(
                          child: Container(
                            color: Colors.red, // Red background for delete
                            alignment: Alignment.center,
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        // Foreground: Swipeable list tile
                        Dismissible(
                          key: Key(items[index]),
                          direction: DismissDirection
                              .horizontal, // Swipe left or right
                          onDismissed: (direction) {
                            // Automatically delete the item on swipe
                            deleteItem(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              title: Text(
                                items[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Overlay for input field
            if (showInputField)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showInputField = false; // Close the input field
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Black background
                    child: Center(
                      child: GestureDetector(
                        onTap:
                            () {}, // Prevent taps on the input area from closing it
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color:
                                Colors.white, // White background for text area
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Item',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: addItem,
                                child: Text('Add Item'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme Selection Button
            FloatingActionButton(
              heroTag: "themeButton",
              backgroundColor: Colors.grey[800],
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.light_mode),
                            title: Text('Light Mode'),
                            onTap: () {
                              changeThemeMode(ThemeMode.light);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.dark_mode),
                            title: Text('Dark Mode'),
                            onTap: () {
                              changeThemeMode(ThemeMode.dark);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.brightness_auto),
                            title: Text('System Mode'),
                            onTap: () {
                              changeThemeMode(ThemeMode.system);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.settings, color: Colors.white),
            ),
            SizedBox(height: 10),
            // Add Button
            FloatingActionButton(
              heroTag: "addButton",
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: toggleInputField,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
