import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled31/Porivder.dart';
import 'package:untitled31/main.dart';
import 'HomePage.dart';

class CalculatePage extends StatefulWidget {
  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  String? selectedPerson = 'Erkek';
  bool hesaplaButonPressed = false;
  double? protein;
  double? karbonhidrat;
  double? yag;

  final kiloController = TextEditingController();
  final boyController = TextEditingController();

  final List<String> cinsiyet = ['Erkek', 'Kadın'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makro Hesaplayıcı'),
        backgroundColor: Colors.purple.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Button for gender selection
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: selectedPerson,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedPerson = newValue;
                    });
                  }
                },
                isExpanded: true,
                underline: SizedBox(),
                dropdownColor: Colors.purple.shade100,
                items: cinsiyet.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),

            // Kilo input field
            _buildTextField(
              controller: kiloController,
              hintText: 'Kilonuzu Giriniz',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Boy input field
            _buildTextField(
              controller: boyController,
              hintText: 'Boyunuzu Giriniz',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),

            // Hesapla button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  hesaplaa();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Hesapla',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Makro değerlerini göster
            if (hesaplaButonPressed)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 35.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.purple.withOpacity(0.1),
                        offset: Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Almanız Gereken Makro Değerler:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Protein: ${protein?.toStringAsFixed(2) ?? "0.00"} g',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Karbonhidrat: ${karbonhidrat?.toStringAsFixed(2) ?? "0.00"} g',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Yağ: ${yag?.toStringAsFixed(2) ?? "0.00"} g',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'İlerle',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void hesaplaa() {
    setState(() {
      hesaplaButonPressed = true;

      // Kilonuz ve boyunuzdan temel verileri alarak hesaplamayı yapın.
      double kilo = double.tryParse(kiloController.text) ?? 0.0;
      double boy = double.tryParse(boyController.text) ?? 0.0;

      // Eğer kilo ve boy geçersizse, çıkma işlemi yapın
      if (kilo <= 0 || boy <= 0) {
        // Uyarı verin veya hata mesajı gösterin
        return;
      }

      // Burada örnek olarak bir BMR (Bazal Metabolizma Hızı) hesaplayabiliriz:
      double bmr = 10 * kilo + 6.25 * boy - 5 * 25 + 5; // Bu hesaplamada yaş ve cinsiyet gibi verileri de dikkate alabilirsiniz.

      // Makrolar için örnek oranlar:
      protein = bmr * 0.3 / 4; // %30 protein
      karbonhidrat = bmr * 0.4 / 4; // %40 karbonhidrat
      yag = bmr * 0.3 / 9; // %30 yağ

      // Değerlerin null olmaması için kontrol edin
      if (protein != null && karbonhidrat != null && yag != null) {
        context.read<UserProivder>().alinanMakrolar(protein!, karbonhidrat!, yag!);
      }
    });
  }

  // TextField widget'ı
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.purple.shade800, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
    );
  }
}
