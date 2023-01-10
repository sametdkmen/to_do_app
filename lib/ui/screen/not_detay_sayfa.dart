import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/cubit/homepage_cubit.dart';
import 'package:to_do_app/ui/cubit/not_detay_cubit.dart';
import '../../data/entity/notlar.dart';

class NotDetaySayfa extends StatefulWidget {
  Notlar not;
  NotDetaySayfa({required this.not});

  @override
  State<NotDetaySayfa> createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {

  var tfNot = TextEditingController();

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfNot.text = not.name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Not Detay"),
        leading: IconButton(onPressed: (){
          Navigator.of(context).popUntil((route) => route.isFirst);
        }, icon: const Icon(Icons.keyboard_backspace_sharp)),
        backgroundColor: Colors.green.shade800,
      ),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(image: AssetImage("assets/gradient2.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  ),
                  boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.withOpacity(0.5),offset: const Offset(1, 1)),],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: tfNot,
                        keyboardType: TextInputType.name,
                        maxLines: 8,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration:  const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.white),
                          ),
                        ),),
                    ),
                    ElevatedButton(onPressed: (){
                     context.read<NotDetayCubit>().guncelle(widget.not.id, tfNot.text)
                     .then((value) {
                       context.read<HomepageCubit>().notlariGetir();
                     });
                     Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: BorderSide(
                            width: 3,
                            color: Colors.black54.withAlpha(70)
                          ),
                        ),
                        child: const Text("Güncelle",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      shadows: [Shadow(color: Colors.grey, blurRadius: 4, offset: Offset(-0.2, 0.3))],
                    ),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
