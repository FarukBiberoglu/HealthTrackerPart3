import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:untitled31/Porivder.dart';
import 'package:untitled31/desing.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map<String, int> makroDegerler = {
    'Protein': 0,
    'Karbonhidrat': 0,
    'Yağ': 0,
  };

  String selectedMakro = 'Protein';
  TextEditingController degerController = TextEditingController();

  bool get tumDegerlerGirildiMi =>
      makroDegerler.values.every((value) => value > 0);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProivder>();

    // Alınan verileri userProvider'dan alın.
    final protein = userProvider.protein;
    final karbonhidrat = userProvider.karbonhidrat;
    final yag = userProvider.yag;

    // Pie chart için verileri hazırlayın.
    Map<String, double> pieChartData = {
      'Protein': protein.toDouble(),
      'Karbonhidrat': karbonhidrat.toDouble(),
      'Yağ': yag.toDouble(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Tracker',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 22,
            backgroundColor: Colors.white54,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // BesinDeğer widget'ları buradaki tasarımın bozulmaması için olduğu gibi kalacak.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: makroDegerler.entries.map((entry) {
                  return BesinDeger(makro: entry.key, deger: entry.value);
                }).toList(),
              ),
              const SizedBox(height: 30),
              // Girilen değerler tamamlandıysa PieChart'ı göster.
              if (tumDegerlerGirildiMi) ...[
                Text(
                  "Günlük Alınan Makro Değerler",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    dataMap: makroDegerler.map(
                          (key, value) => MapEntry(key, value.toDouble()),
                    ),
                    chartType: ChartType.disc,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: [Colors.blue, Colors.red, Colors.green],
                    legendOptions: LegendOptions(
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                      chartValueStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else
                Center(
                  child: Text(
                    "Lütfen tüm makro değerlerinizi giriniz.",
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
              const SizedBox(height: 30),
              // CalculatePage'den alınan verilerin PieChart'ı
              if (tumDegerlerGirildiMi && (protein > 0 || karbonhidrat > 0 || yag > 0)) ...[
                Text(
                  "Günlük Alınan Makro Değerler (CalculatePage)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    dataMap: pieChartData,
                    chartType: ChartType.disc,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3,
                    colorList: [Colors.blue, Colors.red, Colors.green],
                    legendOptions: LegendOptions(
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesOutside: true,
                      decimalPlaces: 1,
                      chartValueStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else
                Center(
                  child: Text(
                    "Lütfen CalculatePage'den alınan verileri giriniz.",
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: const Text("Makro Giriniz"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: selectedMakro,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setDialogState(() {
                                selectedMakro = newValue;
                              });
                            }
                          },
                          items: ['Protein', 'Karbonhidrat', 'Yağ']
                              .map<DropdownMenuItem<String>>((String oge) {
                            return DropdownMenuItem<String>(value: oge, child: Text(oge));
                          }).toList(),
                        ),
                        TextField(
                          controller: degerController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Değer giriniz",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (degerController.text.isNotEmpty) {
                            setState(() {
                              makroDegerler[selectedMakro] =
                                  int.parse(degerController.text);
                            });
                          }
                          degerController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Ekle"),
                      ),
                      TextButton(
                        onPressed: () {
                          degerController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("İptal"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.purple),
      ),
    );
  }
}
