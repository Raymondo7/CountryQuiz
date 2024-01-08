import 'dart:math';

import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pays-cap.dart';

import 'constants.dart';
import 'final_page.dart';

class VuePaysCap extends StatefulWidget {
  const VuePaysCap({Key? key, required this.categorie, required this.nbreTotal}) : super(key: key);
  final String categorie;
  final int nbreTotal;

  @override
  State<VuePaysCap> createState() => _VuePaysCapState();
}

class _VuePaysCapState extends State<VuePaysCap> {
  late final int indexHasard;
  late List<String> reponsesMelangees;
  Color checkColor = Colors.red;
  bool isTrue = false;
  bool isCLicked0 = false;
  bool isCLicked1 = false;
  bool isCLicked2 = false;
  bool isCLicked3 = false;
  late List paysCap;

  @override
  void initState() {
    super.initState();
    switch(widget.categorie){
      case 'Afrique':
        paysCap = Afrique;
        break;
      case 'Asie':
        paysCap = Asie;
        break;
      case 'Amerique':
        paysCap = Amerique;
        break;
      case 'Europe':
        paysCap = Europe;
        break;
      case 'Oceanie':
        paysCap = Oceanie;
        break;
      default :
        paysCap = Tout;
        break;
    }
    indexHasard = Random().nextInt(paysCap.length);
    if (indexHasard >= 0 && indexHasard < paysCap.length) {
      final reponses = paysCap[indexHasard]['reponses'] as List<String>?;

      if (reponses != null) {
        // Mélangez la liste de réponses
        reponsesMelangees = List<String>.from(reponses)..shuffle();
      }
    }
    for (int i = 10; i <= 250; i += 10) {
      if (totalVrai == i && vie < 7) {
        vie += 1;
        break;
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (vie <= 0 || totalParties == widget.nbreTotal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (_, __, ___) => FinalPage(category: widget.categorie, nbreTotal: widget.nbreTotal,)), (route) => false);
      });
    }
  }

  Widget buildAnswerContainer(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            checkAnswer(index);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor),
              color: getContainerColor(index),
            ),
            height: 100,
            width: MediaQuery.of(context).size.width / 2.5,
            child: Center(child: Text(reponsesMelangees[index], textAlign: TextAlign.center, style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: police
            ),)),
          ),
        ),
      ],
    );
  }

  void checkAnswer(int index) async {
    if (reponsesMelangees[index] == paysCap[indexHasard]['capitale']) {
      setState(() {
        isTrue = true;
        totalVrai += 1;
      });
    } else {
      setState(() {
        vie -= 1;
        totalFaux += 1;
      });
    }

    setState(() {
      totalParties +=1;
      setClickedState(index);
      checkColor = isTrue ? Colors.green : Colors.red;
    });

    await Future.delayed(const Duration(milliseconds: 200)); // Adjust the duration as needed

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (_, __, ___) => VuePaysCap(categorie: widget.categorie, nbreTotal: widget.nbreTotal,)),
          (route) => false,
    );
  }


  void setClickedState(int index) {
    switch (index) {
      case 0:
        isCLicked0 = true;
        break;
      case 1:
        isCLicked1 = true;
        break;
      case 2:
        isCLicked2 = true;
        break;
      case 3:
        isCLicked3 = true;
        break;
    }
  }

  Color? getContainerColor(int index) {
    return getClickedState(index) ? checkColor : null;
  }

  bool getClickedState(int index) {
    switch (index) {
      case 0:
        return isCLicked0;
      case 1:
        return isCLicked1;
      case 2:
        return isCLicked2;
      case 3:
        return isCLicked3;
      default:
        return false;
    }
  }

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
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                vie.toString(),
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.favorite_rounded,
                color: Colors.red,
                size: 28,
              ),
            ]),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      primaryColor,
                      Colors.white,
                      primaryColor,
                      Colors.white
                    ],
                  ),
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                ),
                height: 50,
                child: Center(
                  child: Text(
                    widget.categorie.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: police,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Quelle est la capitale de :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: police,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (paysCap != null &&
                        indexHasard >= 0 &&
                        indexHasard < paysCap.length)
                      Flag.fromString(
                          paysCap[indexHasard]['code'] as String ?? '',
                          height: 150,
                          width: 200,
                          fit: BoxFit.fill),
                    const SizedBox(
                      height: 10,
                    ),
                    if (paysCap != null &&
                        indexHasard >= 0 &&
                        indexHasard < paysCap.length)
                      Text(
                        paysCap[indexHasard]['pays'] as String ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: police,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                        ),
                      ),
                     const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildAnswerContainer(0),
                              buildAnswerContainer(1),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildAnswerContainer(2),
                              buildAnswerContainer(3),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    reponsesMelangees = reponsesMelangees..shuffle();
                                  });
                                },
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: primaryColor),
                                    color: primaryColor
                                  ),
                                    child: const Icon(Icons.shuffle, size: 50,color: whiteColor,),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
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
