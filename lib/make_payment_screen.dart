import 'package:flutter/material.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100), // Added space from the top
                // Buy Airtime Button
                ElevatedButton.icon(
                  onPressed: () {
                    _showBuyAirtimeOptions(context);
                  },
                  icon: const Icon(Icons.phone_android),
                  label: const Text("Buy Airtime"),
                  style: _buttonStyle(Colors.blue),
                ),
                const SizedBox(height: 24),

                // Buy Bundle Button
                ElevatedButton.icon(
                  onPressed: () {
                    _showBuyBundleOptions(context);
                  },
                  icon: const Icon(Icons.wifi),
                  label: const Text("Buy Bundle"),
                  style: _buttonStyle(Colors.orange),
                ),
                const SizedBox(height: 24),

                // ECG Pay Button
                ElevatedButton.icon(
                  onPressed: () {
                    _showECGOptions(context);
                  },
                  icon: const Icon(Icons.electrical_services),
                  label: const Text("ECG Pay"),
                  style: _buttonStyle(Colors.green),
                ),
                const SizedBox(height: 24),

                // Pay Fees Button
                ElevatedButton.icon(
                  onPressed: () {
                    _showPayFeesOptions(context);
                  },
                  icon: const Icon(Icons.school),
                  label: const Text("Pay Fees"),
                  style: _buttonStyle(const Color.fromARGB(255, 131, 128, 111)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white, // Text color set to white
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      shadowColor: color.withOpacity(0.4),
      elevation: 10.0,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  void _showBuyAirtimeOptions(BuildContext context) {
    _showCustomDialog(
      context,
      "Buy Airtime",
      ["Buy for Self", "Buy for Others"],
      (selectedOption) {
        if (selectedOption == "Buy for Self" ||
            selectedOption == "Buy for Others") {
          _showOptionSelector(
              context, "Select Network", ["MTN", "Telecel", "AirtelTigo"]);
        }
      },
    );
  }

  void _showBuyBundleOptions(BuildContext context) {
    _showCustomDialog(
      context,
      "Buy Bundle",
      ["Buy for Self", "Buy for Others"],
      (selectedOption) {
        if (selectedOption == "Buy for Self" ||
            selectedOption == "Buy for Others") {
          _showOptionSelector(
              context, "Select Network", ["MTN", "Telecel", "AirtelTigo"]);
        }
      },
    );
  }

  void _showECGOptions(BuildContext context) {
    _showCustomDialog(
      context,
      "ECG Pay",
      ["Prepaid", "Postpaid"],
      null,
    );
  }

  void _showPayFeesOptions(BuildContext context) {
    _showCustomDialog(
      context,
      "Pay Fees",
      ["Preparatory School", "University"],
      (selectedOption) {
        if (selectedOption == "University") {
          _showOptionSelector(context, "Select University", [
            "Valley View University",
            "Ashesi University",
            "Lancaster University",
            "University of Ghana",
            "University of Cape Coast ",
          ]);
        }
      },
    );
  }

  // Custom dialog for displaying options
  void _showCustomDialog(
    BuildContext context,
    String title,
    List<String> options,
    void Function(String)? onOptionSelected,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 16,
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal[50], // Light teal background color
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center options
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                            255, 144, 238, 144), // Custom shape color
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          if (onOptionSelected != null) {
                            onOptionSelected(option);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 150, 0, 50), // Button color
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(
                              color: Colors.white), // Text color set to white
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  // For displaying options after the main selection
  void _showOptionSelector(
      BuildContext context, String title, List<String> options) {
    _showCustomDialog(
      context,
      title,
      options,
      null,
    );
  }
}
