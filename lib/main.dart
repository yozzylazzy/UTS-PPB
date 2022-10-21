import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(),
        body: FormStateful(),
      ),
    );
  }
}

class FormStateful extends StatefulWidget {
  const FormStateful({Key? key}) : super(key: key);

  @override
  State<FormStateful> createState() => _FormStatefulState();
}

class _FormStatefulState extends State<FormStateful> {
  final GlobalKey<FormFieldState> _resetkeydropdown = GlobalKey<FormFieldState>();
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController nohp = TextEditingController();
  TextEditingController tglberangkat = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  String tujuan = '';
  String? pilihan = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        child: Container(
          margin: EdgeInsets.all(40),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _keyform,
            child: Column(
              children: [
                TextFormField(
                  controller: nama,
                  validator: (value){
                    bool isName = RegExp(r'[!@#<>?":_`~;[\]\\//|=+)(*&^%0-9]').hasMatch(value.toString());
                    if(value==null||value.isEmpty){
                      return 'Nama Masih Kosong!!!';
                    } else if (isName){
                      return 'Nama Belum Benar!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Nama',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                    ),
                    //prefixIcon: Icon(Icons.home),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SeparatorBox(0, 20),
                TextFormField(
                  controller: nohp,
                  validator: (value){
                   bool phoneValidator = RegExp(r'(^(?:[+0]9)?[0-9]{9,14}$)').hasMatch(value.toString());
                  if(value==null || value.isEmpty ){
                  return 'Mohon Isikan Nomor Handphone!!!';
                  } else if (!phoneValidator){
                    return 'Nomor Handphone Tidak Valid!';
                  }
                  return null;
                  },
                  decoration: InputDecoration(
                    hintText: '0878xxxxxxxx',
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Nomor Handphone',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                    ),
                    //prefixIcon: Icon(Icons.home),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SeparatorBox(0, 20),
                TextFormField(
                  validator: (value){
                    if(value==null|| value.isEmpty || value==''){
                      return 'Tanggal Keberangkatan Belum Dipilih!!!';
                    }
                    return null;
                  },
                  controller: tglberangkat,
                  readOnly: true,
                  onTap: () async{
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year-100),
                        lastDate: DateTime(DateTime.now().year+100));
                    if(pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        tglberangkat.text = formattedDate;
                      });
                    }
                  },
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      labelText: 'Tanggal Keberangkatan',
                      suffixIcon: IconButton(
                        icon : Icon(Icons.cancel),
                        onPressed: (){
                          setState(() {
                            tglberangkat.text = '';
                          });
                        },
                      ),
                      //prefixIcon: Icon(Icons.ac_unit),
                      hoverColor: Colors.deepPurple,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: Colors.deepPurple,
                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),
                SeparatorBox(0, 20),
                DropdownButtonFormField(
                  key: _resetkeydropdown,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_pin),
                      labelText: 'Tujuan',
                      labelStyle: TextStyle(
                        color: Colors.deepPurple,
                      ),
                      //prefixIcon: Icon(Icons.home),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    isExpanded: true,
                    validator: (value) => value ==null?"Tujuan Wajib Diisi!!!" : null,
                    items: <String>['Blora','Sarinah','Blok-M'].map((String value){
                      return DropdownMenuItem<String>(
                          value:value,
                          child: Text(value));
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        value = value!;
                        tujuan = value!;
                      });
                    }),
                SeparatorBox(0, 20),
                TextFormField(
                  validator: (value){
                    bool isIntg = RegExp(r'[a-zA-Z,.,-,$,%,!,@,#,^,&,*,(,),{,}]').hasMatch(value.toString());
                    if(value==null|| value.isEmpty || value==''){
                      return 'Mohon Isikan Jumlah Tiket!!!';
                    } else if (isIntg){
                      return 'Jumlah Tiket Tidak Valid!';
                    }
                    return null;
                  },
                  controller: jumlah,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.numbers_outlined),
                    labelText: 'Jumlah Tiket',
                    labelStyle: TextStyle(
                      color: Colors.deepPurple,
                    ),
                    //prefixIcon: Icon(Icons.home),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SeparatorBox(0, 20),
                Pilihan(),
                SeparatorBox(0, 20),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:  ElevatedButton(
                            onPressed: (){
                         if(_keyform.currentState!.validate()){
                            if(pilihan==null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Tolong Pilih Menu Pilihan")));
                            } else {
                              //Tambah Diskon, Harga, dan Total Harga (jumlah * hargatiket - diskon)
                              //Mahasiswa dapat diskon 10.000/tiket
                              //B : 100, S : 120, BM : 130
                              int jumtiket = int.parse(jumlah.text);
                              int diskon=0, harga=0,total=0;
                              if(tujuan=="Blora"){
                                harga = 100000;
                              } else if (tujuan=="Sarinah"){
                                harga=120000;
                              } else {
                                harga = 130000;
                              }

                              if(pilihan=="Mahasiswa"){
                                diskon = 10000*jumtiket;
                              } else {
                                diskon = 0;
                              }

                              total = (jumtiket*harga)-diskon;

                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                    title: const Text('Informasi Pemesanan!!!'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Nama Pemesan : ${nama.text}"),
                                        Text("No HP : ${nohp.text}"),
                                        Text("Tanggal Berangkat : ${tglberangkat
                                            .text}"),
                                        Text("Tujuan : ${tujuan}"),
                                        Text("Jumlah Tiket : ${jumlah.text}"),
                                        Text("Pilihan : ${pilihan}"),
                                        Text("Harga Tiket : ${harga.toString()}"),
                                        Text("Diskon : ${diskon.toString()}"),
                                        Text("Total Harga : ${total}"),
                                      ],));
                              });
                            }
                         } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Data Pemesanan Belum Lengkap....."))
                          );
                          }
                        }, child:
                        Text('Pesan'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              fixedSize: Size(150.0, 50.0),
                              shadowColor: Colors.deepPurple,
                            ),),),
                        SizedBox(width: 20,),
                        Expanded(child: ElevatedButton(
                            onPressed: (){
                          setState(() {
                            nama.clear();
                            nohp.clear();
                            pilihan = '';
                            tglberangkat.clear();
                            tujuan = '';
                            jumlah.clear();
                            _resetkeydropdown.currentState?.reset();
                          });
                        }, child:
                        Text('Clear'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            fixedSize: Size(150.0, 50.0),
                            shadowColor: Colors.deepPurple,
                          ),)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Pilihan() {
    return Row(
      children: [
        Flexible(
          child: RadioListTile(
            value: 'Mahasiswa',
            groupValue: pilihan,
            onChanged: (String? value) {
              setState(() {
                pilihan = value;
              });
            },
            title: const Text("Mahasiswa"),
          ),
        ),
        Flexible(child: RadioListTile(
          value: 'Umum',
          groupValue: pilihan,
          onChanged: (String? value) {
            setState(() {
              pilihan = value;
            });
          },
          title: const Text("Umum"),
        )),
      ],
    );
  }
  Widget SeparatorBox(double width, double height){
    return SizedBox(
      width: width,
      height: height,
    );
  }
}

