import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final _randomWordPairs = <WordPair>[]; // Random word pairs
  final _savedWordPairs = <WordPair>{}; // Saved word pairs

  void pushSaved(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: const TextStyle(fontSize: 18),
          ),
        );
      });

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved WordPairs'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => pushSaved(context), // Push to saved list
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "WordPair Generator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return const Divider();
                }

                final int wordIndex = index ~/ 2;

                if (wordIndex >= _randomWordPairs.length) {
                  _randomWordPairs.addAll(generateWordPairs().take(10));
                }

                final alreadySaved = _savedWordPairs.contains(_randomWordPairs[wordIndex]);

                return ListTile(
                  title: Text(
                    _randomWordPairs[wordIndex].asPascalCase,
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null,
                  ),
                  onTap: () {
                    setState(() {
                      if (alreadySaved) {
                        _savedWordPairs.remove(_randomWordPairs[wordIndex]);
                      } else {
                        _savedWordPairs.add(_randomWordPairs[wordIndex]);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => pushSaved(context), // Navigate to saved list
              child: const Text("View Saved WordPairs"),
            ),
          ),
        ],
      ),
    );
  }
}
