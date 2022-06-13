import 'package:flutter/material.dart';
import 'package:techcareer_odev_7/entity/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isSearchActive = false;
  var todoList = <Todo>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchActive ?
        TextField(
          decoration: const InputDecoration(
            hintText: "Ara",
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (aramaSonucu){
            context.read<AnasayfaCubit>().kisileriAra(aramaSonucu);
          },
        )
            : const Text("Kişiler"),
        actions: [
              (){
            if(isSearchActive){
              return IconButton(onPressed: (){
                setState((){
                  isSearchActive = false;
                  context.read<AnasayfaCubit>().kisileriGetir();
                });
              }, icon:const Icon(Icons.clear));
            }else{
              return IconButton(onPressed: (){
                setState((){
                  isSearchActive = true;
                });
              }, icon:const Icon(Icons.search));
            }
          }()

        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Kisi>>(
        builder: (context,kisiler){
          if(kisiler.isNotEmpty){
            return ListView.builder(
              itemCount: kisiler.length ,
              itemBuilder: (context,index){
                var kisi = kisiler[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetaySayfa(kisi)))
                        .then((_) => {
                      context.read<AnasayfaCubit>().kisileriGetir()
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text("${kisi.kisi_ad} - ${kisi.kisi_tel}"),
                          Spacer(),
                          IconButton(
                              onPressed: (){
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                    SnackBar(
                                      content: Text("${kisi.kisi_ad} silinsin mi?"),
                                      action: SnackBarAction(
                                        label: "Evet",
                                        onPressed: (){
                                          context.read<AnasayfaCubit>().kisiSil(kisi.kisi_id);
                                          context.read<AnasayfaCubit>().kisileriGetir();
                                        },
                                      ),
                                    )
                                );
                              },
                              icon: const Icon(Icons.delete_outline)
                          ),
                        ],
                      ),
                    ),

                  ),
                );
              },
            );
          }else{
            return const Center(
              child: Text("Liste boş"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        label: const Text("Kayıt"),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> KisiKayitSayfa()))
              .then((_) => {
            context.read<AnasayfaCubit>().kisileriGetir()
          });
        },
      ),
    );
  }
}
