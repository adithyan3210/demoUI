// import 'package:flutter/material.dart';

// class EditScreen extends StatefulWidget {
//   final String? clientName;
//   final String? clientNumber1;
//   final String? clientNumber2;
//   final String? clientWhatsappNumber;
//   final String? clientEmail;

//   EditScreen(
//       {super.key,
//       this.clientName,
//       this.clientNumber1,
//       this.clientNumber2,
//       this.clientWhatsappNumber,
//       this.clientEmail});

//   @override
//   _EditScreenState createState() => _EditScreenState();
// }

// class _EditScreenState extends State<EditScreen> {
//   TextEditingController clientNameController = TextEditingController();
//   TextEditingController clientNumber1Controller = TextEditingController();
//   TextEditingController clientNumber2Controller = TextEditingController();
//   TextEditingController whatsAppNumberController = TextEditingController();
//   TextEditingController clientEmailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     clientNameController.text = widget.clientName ?? '';
//     clientNumber1Controller.text = widget.clientNumber1 ?? '';
//     clientNumber2Controller.text = widget.clientNumber2 ?? '';
//     whatsAppNumberController.text = widget.clientWhatsappNumber ?? '';
//     clientEmailController.text = widget.clientEmail ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Client'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: clientNameController,
//               decoration: InputDecoration(labelText: ' Name'),
//             ),
//             TextFormField(
//               controller: clientNumber1Controller,
//               decoration: InputDecoration(labelText: ' Number'),
//             ),
//             TextFormField(
//               controller: clientNumber2Controller,
//               decoration: InputDecoration(labelText: ' Number2'),
//             ),
//             TextFormField(
//               controller: whatsAppNumberController,
//               decoration: InputDecoration(labelText: ' whatsapp'),
//             ),
//             TextFormField(
//               controller: clientEmailController,
//               decoration: InputDecoration(labelText: ' email'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
