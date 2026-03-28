import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:kesak_fe/app/home/scrollableMenu.dart';
import 'package:kesak_fe/components/CardSection.dart';
import 'package:kesak_fe/components/Colors.dart';
import 'package:kesak_fe/models/transaction_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isVisible = false;
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

      print('Total transactions loaded: ${transactions.length}');
      if (transactions.isNotEmpty) {
        print('First transaction: ${transactions[0].title}');
      }

      // Simpan semua transaksi dan ambil yang terbaru
      if (transactions.isNotEmpty) {
        setState(() {
          allTransactions = transactions;
          recentTransaction = transactions.firstWhere(
            (t) => t.status == 'completed' && t.type != 'allocation',
            orElse: () => transactions[0],
          );
          print('Recent Transaction: ${recentTransaction?.title}');
        });
      }
    } catch (e) {
      print('Error loading transactions: $e');
    }
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
      'send': Icons.send,
      'card_giftcard': Icons.card_giftcard,
      'bolt': Icons.bolt,
      'local_gas_station': Icons.local_gas_station,
      'work': Icons.work,
      'shopping_cart': Icons.shopping_cart,
      'school': Icons.school,
      'flight': Icons.flight,
      'warning': Icons.warning,
      'devices': Icons.devices,
    };
    return iconMap[iconName] ?? Icons.help;
  }

  Container banner() {
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

  Container searchActivity() {
    // Filter transactions based on search query
    List<Transaction> filteredTransactions = allTransactions
        .where((transaction) =>
            transaction.title
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            transaction.description
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();

    // Gunakan recent transaction jika tidak ada search query, atau gunakan filtered results
    Transaction? displayTransaction = searchQuery.isEmpty
        ? recentTransaction
        : (filteredTransactions.isNotEmpty ? filteredTransactions[0] : null);

    return Container(
      width: double.infinity,
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
      child: displayTransaction != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getIconData(displayTransaction.icon),
                      size: 20,
                      color: displayTransaction.type == 'income'
                          ? secondaryColor
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        displayTransaction.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${displayTransaction.type == 'income' ? '+' : '-'} Rp ${displayTransaction.amount}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: displayTransaction.type == 'income'
                            ? secondaryColor
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  displayTransaction.description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (searchQuery.isNotEmpty && filteredTransactions.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Ditemukan ${filteredTransactions.length} transaksi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ),
              ],
            )
          : Center(
              child: Text(
                searchQuery.isEmpty
                    ? 'Tidak ada transaksi'
                    : 'Tidak ada transaksi yang cocok dengan "$searchQuery"',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
    );
  }

  void showTransactionHistory() {
    // Method untuk show riwayat transaksi
    print('Showing transaction history...');
    print('Total transactions: ${allTransactions.length}');
    for (var transaction in allTransactions) {
      print(
          '${transaction.title} - Rp ${transaction.amount} (${transaction.type})');
    }
    // TODO: Navigate to history page atau show dialog/bottom sheet
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              banner(),
              const SizedBox(height: 23),
              scrollableMenu(),
              const SizedBox(height: 23),
              const CardSection(
                title: "Transaksi Terbaru",
                body: "Ini adalah transaksi terakhir anda",
              ),
              const SizedBox(height: 10),
              // Search Box
              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Cari transaksi...",
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
              const SizedBox(height: 15),
              searchActivity(),
              const SizedBox(height: 20),
              // Navigation to History
              GestureDetector(
                onTap: () {
                  showTransactionHistory();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Lihat Riwayat Transaksi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
