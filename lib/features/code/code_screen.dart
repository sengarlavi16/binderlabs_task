import 'package:flutter/material.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  int expandedIndex = -1;

  final List<String> categories = [
    "Buyer",
    "Vendor",
    "Company Essentials",
    "Internal Purchase Order"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            decoration: _cardDecoration(),
            child: ListView(
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                final isExpanded = expandedIndex == index;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expandedIndex = isExpanded ? -1 : index;
                        });
                      },
                      child: _commonListTile(
                        categories[index],
                        isExpanded,
                      ),
                    ),

                    // 🔽 EXPAND AREA
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Column(
                        children: [
                          _subTile("Generate ${categories[index]} Code"),
                          _subTile("Existing ${categories[index]} Codes"),
                        ],
                      ),
                      secondChild: const SizedBox(),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 MAIN TILE
  Widget _commonListTile(String text, bool isExpanded) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: isExpanded ? const Color(0xFFE8461A) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded ? const Color(0xFFE8461A) : const Color(0xFFE5E7EB),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isExpanded ? Colors.white : const Color(0xFF1A1A1A),
            ),
          ),
          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: isExpanded ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }

  // 🔥 SUB TILE (OPTIONS)
  Widget _subTile(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }

  // 🔥 CARD STYLE
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withValues(alpha: 0.05),
        )
      ],
    );
  }
}
