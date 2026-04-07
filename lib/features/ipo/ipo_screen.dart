import 'package:flutter/material.dart';

class IpoScreen extends StatefulWidget {
  const IpoScreen({super.key});

  @override
  State<IpoScreen> createState() => _IpoScreenState();
}

class _IpoScreenState extends State<IpoScreen> {
  int selectedIndex = 0;

  final categories = [
    "Production",
    "Sampling",
    "Company",
  ];

  final Map<String, List<String>> data = {
    "Production": [
      "CHD/PD/102A/COTTONHANDWOVENRUGCHARCOAL&SILVER-2117/1",
      "CHD/PD/101A/ELDRIDGE/1",
      "CHD/PD/101A/ALPHA/1",
    ],
    "Sampling": [
      "CHD/SAM/102A/COTTONWOVENRUG-2121/1",
    ],
    "Company": [],
  };

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedIndex];
    final items = data[selectedCategory]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 🔥 LEFT PANEL
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("IPO Issued",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const Divider(height: 20),
                    ...List.generate(categories.length, (index) {
                      final isActive = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFFE8461A)
                                : const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isActive
                                  ? const Color(0xFFE8461A)
                                  : const Color(0xFFE5E7EB),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isActive ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),

            const SizedBox(width: 16),

            // 🔥 RIGHT PANEL
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedCategory,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const Divider(height: 20),
                    if (items.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: const Text(
                          "No IPOs",
                          style: TextStyle(color: Color(0xFF6B7280)),
                        ),
                      )
                    else
                      ...items.map((e) => _listTile(e))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 LIST TILE
  Widget _listTile(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(text)),
          const Icon(Icons.arrow_forward_ios, size: 16)
        ],
      ),
    );
  }

  // 🔥 CARD DECORATION
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
