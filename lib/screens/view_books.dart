import 'package:flutter/material.dart';

// Book Model
class Book {
  final String title;
  final String author;
  final String imageUrl;

  Book({required this.title, required this.author, required this.imageUrl});
}

class ViewBooks extends StatelessWidget {
  ViewBooks({super.key});

  final List<Book> books = [
    Book(
      title: 'Period Power',
      author: 'Dr. Loretta',
      imageUrl: 'assets/images/book1.jpeg',
    ),
    Book(
      title: 'The Red Tent',
      author: 'Anita Diamant',
      imageUrl: 'assets/images/book2.png',
    ),
    Book(
      title: 'Moon Time',
      author: 'Lisa Lister',
      imageUrl: 'assets/images/book3.jpeg',
    ),
    Book(
      title: 'The Fifth Vital Sign',
      author: 'Lisa Hendrickson-Jack',
      imageUrl: 'assets/images/book4.jpeg',
    ),
    Book(
      title: 'Taking Charge of Your Fertility',
      author: 'Toni Weschler',
      imageUrl: 'assets/images/book5.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period Related Books'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            // Show total count
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.pink.shade50,
            child: ListTile(
              leading: Icon(Icons.book, size: 40, color: Colors.pinkAccent),
              title: Text(
                'Number of period-related books:',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                '${books.length}',
                style: TextStyle(fontSize: 36, color: Colors.pinkAccent),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Display all 5 books with image from network
          ...books.map(
            (book) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    book.imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 56, color: Colors.grey),
                  ),
                ),
                title: Text(
                  book.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'by ${book.author}',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
