import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() => runApp(const MaterialApp(home: QuoteList()));

enum SortOption { newestFirst, oldestFirst, recentlyModified }

class QuoteList extends StatefulWidget {
  const QuoteList({Key? key}) : super(key: key);

  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(
      author: 'Pramoedya Ananta Toer',
      text: 'Kau boleh saja berpendidikan tinggi, tapi tanpa hati yang besar, kau tetap saja manusia picik',
    ),
    Quote(
      author: 'Buya Hamka',
      text: 'Kebahagiaan itu bukan karena harta yang banyak, tapi kebahagiaan itu adalah hati yang selalu merasa cukup',
    ),
    Quote(
      author: 'Chairil Anwar',
      text: 'Hidup hanya menunda kekalahan, tambah terasing dari cinta sekolah rendah, dan tahu, ada yang tetap tidak diucapkan',
    ),
    Quote(
      author: 'Soekarno',
      text: 'Bangsa yang besar adalah bangsa yang menghormati jasa pahlawannya',
    ),
    Quote(
      author: 'Andrea Hirata',
      text: 'Hidup adalah rangkaian kesempatan untuk belajar, dan setiap orang adalah guru',
    ),
    Quote(
      author: 'Dewi Lestari',
      text: 'Kadang kita harus tersesat dulu untuk menemukan jalan yang tak pernah terpikirkan',
    ),
  ];
  SortOption currentSortOption = SortOption.newestFirst;

  List<Quote> get sortedQuotes {
    switch (currentSortOption) {
      case SortOption.newestFirst:
        return quotes.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case SortOption.oldestFirst:
        return quotes.toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case SortOption.recentlyModified:
        return quotes.toList()
          ..sort((a, b) => b.editedAt.compareTo(a.editedAt));
    }
  }

  void _deleteQuote(String id) {
    setState(() {
      quotes.removeWhere((quote) => quote.id == id);
    });
  }

  void _editQuote(String id) {
    final quote = quotes.firstWhere((q) => q.id == id);
    final authorController = TextEditingController(text: quote.author);
    final textController = TextEditingController(text: quote.text);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(labelText: 'Quote'),
                maxLines: 3,
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty &&
                    authorController.text.isNotEmpty) {
                  setState(() {
                    final index = quotes.indexWhere((q) => q.id == id);
                    if (index != -1) {
                      quotes[index] = quotes[index].copyWith(
                        text: textController.text,
                        author: authorController.text,
                      );
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddQuoteDialog() {
    final authorController = TextEditingController();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(labelText: 'Quote'),
                maxLines: 3,
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty &&
                    authorController.text.isNotEmpty) {
                  setState(() {
                    quotes.add(
                      Quote(
                        author: authorController.text,
                        text: textController.text,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          DropdownButton<SortOption>(
            dropdownColor: Colors.white,
            value: currentSortOption,
            onChanged: (SortOption? newValue) {
              if (newValue != null) {
                setState(() {
                  currentSortOption = newValue;
                });
              }
            },
            items:
                SortOption.values.map((SortOption option) {
                  return DropdownMenuItem<SortOption>(
                    value: option,
                    child: Text(
                      option.toString().split('.').last,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
              sortedQuotes.map((quote) {
                return QuoteCard(
                  key: ValueKey(quote.id),
                  quote: quote,
                  delete: () => _deleteQuote(quote.id),
                  edit: () => _editQuote(quote.id),
                );
              }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddQuoteDialog,
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
