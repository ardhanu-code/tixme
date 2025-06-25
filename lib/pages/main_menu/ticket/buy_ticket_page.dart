import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/main_menu/ticket/checkout_page.dart';

class BuyTicketPage extends StatelessWidget {
  const BuyTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        foregroundColor: Colors.white,

        title: const Text('Buy Ticket', style: TextStyle(fontSize: 18)),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: AppColor.accentColor,
                prefixIcon: Icon(Icons.search, color: AppColor.textColor),
                hintText: 'Cari nama film...',
                hintStyle: TextStyle(color: AppColor.textColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColor.accentColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColor.accentColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColor.accentColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Tiket Tersedia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),

                    color: AppColor.accentColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColor.accentColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(Icons.movie, color: AppColor.textColor),
                      ),
                      title: Text(
                        'Movie Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jam Tayang: 10:00 - 12:00',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textColor,
                            ),
                          ),
                          Text(
                            'Total Harga: Rp. 100.000',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textColor,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialogBuyTicket(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.textColor,
                          size: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showDialogBuyTicket(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('Detail Tiket', style: TextStyle(fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColor.accentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(Icons.movie, color: AppColor.textColor),
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Movie Title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Jam Tayang: 10:00 - 12:00',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  Text('Total Harga', style: TextStyle(fontSize: 18)),
                  Text('Rp. 100.000', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Beli Tiket',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.accentColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove,
                                color: AppColor.textColor,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Text('1', style: TextStyle(fontSize: 14)),
                      SizedBox(width: 8),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.accentColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: AppColor.textColor,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
  );
}
