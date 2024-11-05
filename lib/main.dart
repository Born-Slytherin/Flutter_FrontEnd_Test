import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class Transaction {
  String? title;
  String? type;
  String? category;
  double? amount;
  DateTime? date;

  Transaction({
    required this.title,
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BudgetPage(),
    );
  }
}

class BudgetPage extends StatelessWidget {
  BudgetPage({super.key});

  final List<Transaction> allTransactions = [
    Transaction(
      title: 'GTR 5',
      type: 'Revenue',
      category: 'Gadget & Gear',
      amount: 160.00,
      date: DateTime.now(),
    ),
    Transaction(
      title: 'Polo Shirt',
      type: "Expenses",
      category: 'XL fashions',
      amount: 20.00,
      date: DateTime.now(),
    ),
    Transaction(
        title: 'Biriyani',
        type: 'Expenses',
        category: 'Hajir Biriyani',
        amount: 1500,
        date: DateTime.now()),
    Transaction(
      title: 'Taxi Fare',
      type: 'Revenue',
      category: 'Uber',
      amount: 500,
      date: DateTime.now(),
    ),
    Transaction(
      title: 'Keyboard',
      type: 'Expenses',
      category: 'Gadget & Gear',
      amount: 500,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BudgetSection(),
            SizedBox(height: 20),
            TransactionSectionTitle(),
            SizedBox(height: 20),
            IncomeOutcomeRow(),
            SizedBox(height: 20),
            FilterButtons(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

// Widget for Budget section
class BudgetSection extends StatelessWidget {
  const BudgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Budget",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 25),
        Text(
          '4973/-',
          style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 28,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

// Widget for "Transactions" title section
class TransactionSectionTitle extends StatelessWidget {
  const TransactionSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Transactions",
      style: TextStyle(
        color: Color.fromARGB(129, 0, 0, 0),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Widget for Income and Outcome Cards
class IncomeOutcomeRow extends StatelessWidget {
  const IncomeOutcomeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TransactionCard(
            title: "Income",
            amount: 400,
            color: Color.fromARGB(255, 56, 49, 179),
          ),
          TransactionCard(
            title: "Outcome",
            amount: 200,
            color: Color.fromARGB(255, 68, 170, 243),
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String title;
  final int amount;
  final Color color;

  const TransactionCard({
    required this.title,
    required this.amount,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: double.infinity,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Color.fromARGB(187, 255, 255, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "\$",
                    style: TextStyle(
                        color: Color.fromARGB(187, 255, 255, 255),
                        fontSize: 20),
                  ),
                  Text(
                    "$amount",
                    style: const TextStyle(
                        color: Color.fromARGB(187, 255, 255, 255),
                        fontSize: 50,
                        height: 0.9),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/diagonal-arrow.svg',
                        semanticsLabel: 'diagonal arrow',
                        height: 20,
                        width: 20,
                      ),
                      const Text("10%",
                          style: TextStyle(
                            color: Color.fromARGB(187, 255, 255, 255),
                            fontSize: 15,
                          )),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(122, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/right-arrow.svg',
                        width: 10,
                        height: 10,
                        semanticsLabel: 'right arrow',
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Filter Buttons
class FilterButtons extends StatefulWidget {
  const FilterButtons({super.key});

  @override
  _FilterButtonsState createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  final List<String> filters = ["All", "Revenue", "Expenses"];
  String selectedFilter = "All"; // Default selection

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: filters.map((filter) {
        bool isSelected = filter == selectedFilter;
        return Container(
          margin: const EdgeInsets.only(right: 12),
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: Text(
              filter,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration:
                    isSelected ? TextDecoration.underline : TextDecoration.none,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Widget for Transaction List
class _TransactionList extends StatefulWidget {
  const _TransactionList({super.key});

  @override
  State<_TransactionList> createState() => __TransactionListState();
}

class __TransactionListState extends State<_TransactionList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Widget for Bottom Navigation Bar
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 224, 224, 224),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            "assets/images/home.svg",
            width: 25,
            height: 25,
          ),
          SvgPicture.asset(
            "assets/images/bulb.svg",
            width: 25,
            height: 25,
          ),
          SvgPicture.asset(
            "assets/images/archery.svg",
            width: 25,
            height: 25,
          ),
          SvgPicture.asset(
            "assets/images/user.svg",
            width: 25,
            height: 25,
          ),
        ],
      ),
    );
  }
}
