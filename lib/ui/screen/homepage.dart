import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/ui/cubit/homepage_cubit.dart';
import 'package:to_do_app/ui/screen/not_detay_sayfa.dart';
import 'package:to_do_app/ui/screen/not_ekle_sayfa.dart';

import '../../data/entity/notlar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool aramaAktifMi = false;
  bool yapildi = false;
  bool yapilmadi = false;
  @override
  void initState() {
    super.initState();
    context.read<HomepageCubit>().notlariGetir();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaAktifMi
            ? TextField(
                style: const TextStyle(fontSize: 23,color: Colors.white54,fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: "Not Ara",hintStyle: TextStyle(fontSize: 20,color: Colors.white54,
                ), border: InputBorder.none),
                onChanged: (aramaSonucu) {
                  context.read<HomepageCubit>().ara(aramaSonucu);
                },
              )
            : const Text(
                "To Do",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(-0.5, 0.5))] ),
              ),
        actions: [
          aramaAktifMi
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaAktifMi = false;
                    });
                    context.read<HomepageCubit>().notlariGetir();
                  }, icon: const Icon(Icons.exit_to_app))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaAktifMi = true;
                    });
                    context.read<HomepageCubit>().notlariGetir();
                  }, icon: const Icon(Icons.search_rounded)),
        ],
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              SizedBox(
                height: 200,
                child: BlocBuilder<HomepageCubit,List<Notlar>>(
                  builder: (context,notListesi){
                    if(notListesi.isNotEmpty){
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: notListesi.length,
                          itemBuilder:(context,indeks){
                            var notErisimNesnesi = notListesi[indeks];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotDetaySayfa(not: notErisimNesnesi)));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 190,
                                      width: 220,
                                      margin: const EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade200,
                                        image: const DecorationImage(image: AssetImage("assets/gradient2.png"),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                                        ),
                                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 4, offset: const Offset(1, 1)),],
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        padding: const EdgeInsets.symmetric(vertical: 80),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: Wrap(
                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                children: [
                                                  Text("${notErisimNesnesi.name}",style: const TextStyle(
                                                      fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14,
                                                      overflow: TextOverflow.visible,
                                                      shadows: [Shadow(color: Colors.black54, blurRadius: 4, offset: Offset(-0.5, 0.5))] ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 8.0), //silme butonu kordinaat
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: IconButton(onPressed: (){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("${notErisimNesnesi.name}.. notu silinsin mi ?"),
                                              action: SnackBarAction(label: "Evet", onPressed: (){
                                                context.read<HomepageCubit>().sil(notErisimNesnesi.id);
                                              },),),
                                          );
                                        },
                                          color: Colors.white,
                                          iconSize: 16,
                                          padding: const EdgeInsets.symmetric(vertical: 0.5,horizontal: 0.5),
                                          icon: const Icon(Icons.remove_circle_outline_sharp),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    else {return const Center();}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const NotEkleSayfa()))
      .then((value) {
        context.read<HomepageCubit>().notlariGetir();
      });
      },
        backgroundColor: Colors.green.shade800,
      child: const Icon(Icons.note_add),
      ),
    );
  }
}



/*SizedBox(
                                                    child: CheckboxListTile(value: yapildi,
                                                        title: Text("Yapıldı"),
                                                        controlAffinity: ListTileControlAffinity.leading,
                                                        checkColor: Colors.white,
                                                        activeColor: Colors.red,
                                                        onChanged: (bool? veri){
                                                          setState(() {
                                                            yapildi = veri!;
                                                          });
                                                        }),
                                                  ),*/