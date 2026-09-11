import 'package:flutter/material.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  final TextEditingController _unitsController = TextEditingController();

  double totalBill = 0.0;
  double unitsConsumed = 0.0;
  bool isCalculated = false;
  
  void calculateBill(){
    double units = double.tryParse(_unitsController.text) ?? 0.0;

    if(units<= 0){
      setState(() {
        totalBill = 0.0;
        unitsConsumed = 0.0;
        isCalculated = false;
      });
      return;
    }

    double bill = 0.0;
    double remainingUnits = units;

    if (remainingUnits > 100) {
      bill += 100 * 3.00;
      remainingUnits -= 100;
    }else{
      bill += remainingUnits * 3.00;
      remainingUnits = 0;
    }

    if (remainingUnits > 0){
      if (remainingUnits > 100){
        bill += 100 * 4.50;
        remainingUnits -= 100;
      }else{
        bill +=remainingUnits * 4.50;
        remainingUnits = 0;
      }
    }
    
    if (remainingUnits > 0){
      if (remainingUnits > 100){
        bill += 100 * 6.00;
        remainingUnits -= 100;
      }else{
        bill += remainingUnits * 6.00;
        remainingUnits = 0;
      }
    } 

    if (remainingUnits > 0){
      bill += remainingUnits * 8.00;
    }

    setState((){
      unitsConsumed = units;
      totalBill = bill;
      isCalculated = true;
    });

    FocusScope.of(context).unfocus();
  }

  void resetFields(){
    setState(() {
      _unitsController.clear();
      totalBill = 0.0;
      unitsConsumed = 0.0;
      isCalculated = false;
    });
  } 

  @override
  void dispose(){
    _unitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity Bill Calculator'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _unitsController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Enter Units Consumed',
                        hintText: 'e.g. 150',
                        prefixIcon: Icon(Icons.bolt),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: calculateBill,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text(
                              'Calculate Bill',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: resetFields,
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isCalculated)
              Card(
                color: Colors.blue.shade50,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Total Bill Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        totalBill.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Units Billed:'),
                          Text(
                            '${unitsConsumed.toStringAsFixed(2)} units',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const[
                      Text(
                        'Consumption Slab Rates:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text("'. 0 - 100 units: ₹3.00 / unit"),
                      Text("'. 101 - 200 units: ₹4.50 / unit"),
                      Text("'. 201 - 300 units: ₹6.00 / unit"),
                      Text("'. Above 300 units: ₹8.00 / unit"),
                    ],
                  )
                )
              )
          ],
        ),
      ),
    );
  }
}