import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Higo Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      locale: const Locale('ar', 'SA'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const ChatListScreen();
        }
        return const LoginScreen();
      },
    );
  }
}

// ===== صفحة تسجيل الدخول =====
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ: ${e.toString()}')));
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.chat_bubble, size: 100, color: Colors.blue),
              const SizedBox(height: 32),
              const Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),

              // حقل البريد الإلكتروني
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              const SizedBox(height: 16),

              // حقل كلمة المرور
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  obscureText: true,
                ),
              ),

              const SizedBox(height: 32),

              // زر الدخول
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('دخول', style: TextStyle(fontSize: 18)),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
                child: const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== صفحة التسجيل =====
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() => _isLoading = true);
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ: ${e.toString()}')));
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              // حقل الاسم
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // حقل البريد الإلكتروني
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              const SizedBox(height: 16),

              // حقل كلمة المرور
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'كلمة المرور',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  obscureText: true,
                ),
              ),

              const SizedBox(height: 32),

              // زر إنشاء الحساب
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'إنشاء حساب',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== صفحة قائمة المحادثات =====
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثات'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('users', arrayContains: currentUser.uid)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!.docs;

          if (chats.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chat, size: 100, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('لا توجد محادثات', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UsersListScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('بدء محادثة جديدة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index].data() as Map<String, dynamic>;
              final otherUserId = (chat['users'] as List).firstWhere(
                (id) => id != currentUser.uid,
              );

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUserId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)),
                      title: Text('جاري التحميل...'),
                    );
                  }

                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        userData['name'][0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(userData['name']),
                    subtitle: Text(chat['lastMessage'] ?? ''),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          chatId: chats[index].id,
                          otherUserId: otherUserId,
                          otherUserName: userData['name'],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UsersListScreen()),
        ),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ===== صفحة قائمة المستخدمين =====
class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  Future<void> _startChat(
    BuildContext context,
    String otherUserId,
    String otherUserName,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final users = [currentUser.uid, otherUserId]..sort();
    final chatId = '${users[0]}_${users[1]}';

    await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
      'users': users,
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            chatId: chatId,
            otherUserId: otherUserId,
            otherUserName: otherUserName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر مستخدم'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs
              .where((doc) => doc.id != currentUser.uid)
              .toList();

          if (users.isEmpty) {
            return const Center(
              child: Text(
                'لا يوجد مستخدمون آخرون',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    user['name'][0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () => _startChat(context, users[index].id, user['name']),
              );
            },
          );
        },
      ),
    );
  }
}

// ===== صفحة الدردشة =====
class ChatScreen extends StatefulWidget {
  final String chatId;
  final String otherUserId;
  final String otherUserName;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final currentUser = FirebaseAuth.instance.currentUser!;
    final message = _messageController.text.trim();
    _messageController.clear();

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .add({
          'text': message,
          'senderId': currentUser.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .update({
          'lastMessage': message,
          'lastMessageTime': FieldValue.serverTimestamp(),
        });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUserName),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'ابدأ المحادثة!',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messages[index].data() as Map<String, dynamic>;
                    final isMe = message['senderId'] == currentUser.uid;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'اكتب رسالة...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
