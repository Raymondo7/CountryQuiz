import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/homepage.dart';
import 'package:quiz/vue_pays_cap.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key, required this.category, required this.nbreTotal});
  final String category;
  final int nbreTotal;

  @override
  State<FinalPage> createState() => _FinalPageState();
}


class _FinalPageState extends State<FinalPage> {
  final pourcentage = totalVrai/totalParties ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
              appName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: police, fontSize: 30),
            ),
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
            centerTitle: true,
            elevation: 8.0,
            toolbarHeight: 75,
        )
        ,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryColor),
          ),
          child: Column(
            children: [
              Image.asset('assets/images/finish.png',
              width: 135,),
              const SizedBox(height: 20,),
              const Text('Quiz Terminé !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: police,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              CircularPercentIndicator(
                radius: 75.0,
                animation: true,
                animationDuration: 1200,
                reverse: true,
                lineWidth: 15.0,
                percent: pourcentage,
                center: Text(
                  '${(pourcentage*100).toStringAsFixed(2)}%',
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.red,
                progressColor: Colors.green,
              ),
              const SizedBox(height: 20,),
              Card(
                elevation: 10.0,
                surfaceTintColor: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 100,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/all.png',
                          width: 40,
                          ),
                          Text(totalParties.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: police,
                            color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 100,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/check.png',
                          width: 40,
                          ),
                          Text(totalVrai.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: police,
                              color: Colors.green
                          ),)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 100,
                      height: 80,
                      child: Column(
                        children: [
                          Image.asset('assets/images/error.png',
                          width: 40,
                          ),
                          Text(totalFaux.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: police,
                              color: Colors.red
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 80),
                      backgroundColor: primaryColor,
                      foregroundColor: whiteColor,
                    ),
                      onPressed: (){
                        setState(() {
                          vie = 3;
                          totalVrai = 0;
                          totalFaux = 0;
                          totalParties = 0;
                        });
                      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (_,__,___) => const HomePage()), (route) => false);
                      },
                      child: const Text('Accueil',
                      style: TextStyle(
                        fontFamily: police,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 80),
                        backgroundColor: Colors.amber,
                        foregroundColor: whiteColor,
                      ),
                      onPressed: (){
                        setState(() {
                          vie = 3;
                          totalVrai = 0;
                          totalFaux = 0;
                          totalParties = 0;
                        });
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_,__,___) => VuePaysCap(categorie: widget.category, nbreTotal: widget.nbreTotal,))
                        );
                      },
                      child: const Text('Nouvelle \n partie',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: police,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
