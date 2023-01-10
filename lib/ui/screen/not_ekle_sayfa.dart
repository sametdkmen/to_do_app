import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/cubit/not_ekle_cubit.dart';
import 'package:to_do_app/ui/screen/homepage.dart';

class NotEkleSayfa extends StatefulWidget {
  const NotEkleSayfa({Key? key}) : super(key: key);

  @override
  State<NotEkleSayfa> createState() => _NotEkleSayfaState();
}

class _NotEkleSayfaState extends State<NotEkleSayfa> {
  var tfNot = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Not Ekle"),
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
                      decoration:  const InputDecoration(
                        border: InputBorder.none,
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
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      if(tfNot.text.isEmpty)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text("Boş not ekleyemezsiniz"),
                            action: SnackBarAction(label: "Tamam", onPressed: (){
                            },),),
                        );
                      }
                      else{
                        context.read<NotEkleCubit>().ekle(tfNot.text);
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                            width: 3,
                            color: Colors.black54.withAlpha(50)
                        ),
                      ),
                      child: const Text("Ekle",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        shadows: [Shadow(color: Colors.grey, blurRadius: 4, offset: Offset(-0.2, 0.3))],
                    ),
                    ),
                    ),
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
