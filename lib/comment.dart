import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Mask the email to show the first 3 letters and domain
  String maskEmail(String email) {
    String masked = email.substring(0, 3); // First 3 letters
    String domain = email.split('@').last; // The domain part (e.g., gmail.com)
    return '$masked****@$domain'; // Masking the middle part
  }

  // Function to add a comment to Firestore
  Future<void> addComment(String email, String comment) async {
    await FirebaseFirestore.instance.collection('comments').add({
      'email': email,
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Function to submit the comment
  void _submitComment() {
    final String email = _emailController.text;
    final String comment = _commentController.text;

    if (email.isNotEmpty && comment.isNotEmpty) {
      addComment(email, comment);
      _emailController.clear();
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title:Text(
          'Comments',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        )

      ),
      body: Container(
        color: const Color(0xFF7d786b),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    filled: true, // Enables background color
                    fillColor: Colors.blue.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  ),
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email'),
              ),
              SizedBox(
                height: 20),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                    filled: true, // Enables background color
                    fillColor: Colors.blue.shade100,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  ),
                    prefixIcon: Icon(Icons.comment),
                    labelText: 'Comment'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitComment,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Increase the button size
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Submit Comment',style: TextStyle(fontSize: 15),),
              ),

              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('comments')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    final comments = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final commentData = comments[index];
                        final email = commentData['email'];
                        final comment = commentData['comment'];

                        return ListTile(
                          title: Text(maskEmail(email)),
                          subtitle: Text(comment),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
