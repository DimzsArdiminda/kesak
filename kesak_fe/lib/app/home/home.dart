import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kesak_fe/app/history/history.dart';
import 'dart:convert';
import 'package:kesak_fe/app/home/scrollableMenu.dart';
import 'package:kesak_fe/components/CardSection.dart';
import 'package:kesak_fe/components/Colors.dart';
import 'package:kesak_fe/components/LoadingOverlay.dart';
import 'package:kesak_fe/models/transaction_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isVisible = false;
  bool isLoading = false;
  Transaction? recentTransaction;
  Tabungan? recentTabungan;
  String searchQuery = '';
  final searchController = TextEditingController();
  List<Transaction> allTransactions = [];

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadTransactions() async {
    try {
      final String jsonString =
          await rootBundle.loadString('lib/data/data_transaksi.json');
      final jsonData = jsonDecode(jsonString);
      final transactions = (jsonData['transactions'] as List)
          .map((item) => Transaction.fromJson(item))
          .toList();

      if (transactions.isNotEmpty) {
        setState(() {
          allTransactions = transactions;
          recentTransaction = transactions.firstWhere(
            (t) => t.status == 'completed' && t.type != 'allocation',
            orElse: () => transactions[0],
          );
        });
      }
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      isLoading = true;
    });
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Reload transactions
    await loadTransactions();
    setState(() {
      isLoading = false;
    });
  }

  void toggoleVisibilty() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  String greetings() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Selamat Pagi";
    } else if (hour >= 12 && hour < 15) {
      return "Selamat Siang";
    } else if (hour >= 15 && hour < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }

  IconData _getIconData(String iconName) {
    final iconMap = {
      'account_balance_wallet': Icons.account_balance_wallet,
      'restaurant': Icons.restaurant,
      'shopping_cart': Icons.shopping_cart,
      'send': Icons.send,
      'attach_money': Icons.attach_money,
      'card_giftcard': Icons.card_giftcard,
      'local_mall': Icons.local_mall,
      'local_taxi': Icons.local_taxi,
      'medical_services': Icons.medical_services,
      'movie': Icons.movie,
      'flight': Icons.flight,
      'help': Icons.help,
    };
    return iconMap[iconName] ?? Icons.help;
  }

  Container _banner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryColor, secondaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            left: -50,
            bottom: -50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: textColorW.withOpacity(0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "total saldo anda",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: textColorW,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    isVisible ? "Rp 98.888.227.654,22" : "Rp ********",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  // const Spacer(),
                  IconButton(
                    onPressed: () => toggoleVisibilty(),
                    icon: Icon(
                      isVisible
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: primaryColor,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "dari 6 tabungan yang \nanda miliki",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_circle_right_rounded,
                      color: primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _lastTransaksi(BuildContext context) {
    // Get 2 most recent transactions
    List<Transaction> recentTransactions = allTransactions.take(2).toList();

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: textColorW,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Transaksi Terakhir",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColorB,
              )),
          Text(
              "Berikut adalah daftar transaksi terakhir yang telah anda lakukan",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: textColorB.withOpacity(0.6),
              )),
          const SizedBox(height: 20),
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Cari transaksi...",
              hoverColor: primaryColor.withOpacity(0.1),
              prefixIcon: const Icon(Icons.search),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: primaryColor.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          Divider(
            height: 30,
          ),
          // Display recent transactions
          recentTransactions.isNotEmpty
              ? Column(
                  children: [
                    for (int i = 0; i < recentTransactions.length; i++)
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: recentTransactions[i].type == 'income'
                                      ? secondaryColor.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                ),
                                child: Icon(
                                  recentTransactions[i].type == 'income'
                                      ? Icons.arrow_downward_rounded
                                      : Icons.arrow_upward_rounded,
                                  color: recentTransactions[i].type == 'income'
                                      ? secondaryColor
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recentTransactions[i].title,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      "${recentTransactions[i].date} | ${recentTransactions[i].category}",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${recentTransactions[i].type == 'income' ? '+' : '-'}Rp ${recentTransactions[i].amount}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        recentTransactions[i].type == 'income'
                                            ? secondaryColor
                                            : Colors.red),
                              ),
                            ],
                          ),
                          if (i < recentTransactions.length - 1)
                            const SizedBox(height: 20),
                        ],
                      ),
                  ],
                )
              : const Center(
                  child: Text('Tidak ada transaksi'),
                ),
          Divider(
            height: 30,
          ),
          TextButton(
              iconAlignment: IconAlignment.end,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => History())),
              child: Text("Lihat Semua Transaksi",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi, ${greetings()}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_3_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: onRefresh,
            color: Colors.transparent,
            backgroundColor: Colors.transparent,
            strokeWidth: 0,
            displacement: 0,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: [
                    _banner(),
                    const SizedBox(height: 23),
                    scrollableMenu(),
                    const SizedBox(height: 23),
                    _lastTransaksi(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          // Lottie loading animation overlay
          LoadingOverlay(isLoading: isLoading),
        ],
      ),
    );
  }
}
