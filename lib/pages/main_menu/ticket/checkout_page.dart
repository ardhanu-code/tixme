import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: AppColor.textColor)),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.textColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.textColor),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 145,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColor.accentColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.movie, color: Colors.white),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Planet of the Apes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor,
                          ),
                        ),
                        Text(
                          'Genre: Action, Adventure, Sci-Fi',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Nama: Sakti Ardhanu',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.textColor,
                          ),
                        ),
                        Text(
                          'Tanggal: 08 - 11 - 2025',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.textColor,
                          ),
                        ),
                        Text(
                          'Jam: 10:00 - 12:00',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.textColor,
                          ),
                        ),
                        Text(
                          'Jumlah Tiket: 1',
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
                        SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.accentColor,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(color: AppColor.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
