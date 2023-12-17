import 'package:flutter/material.dart';
import 'package:community/providers/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:community/pages/login_page_2.dart';
import 'package:community/pages/union_page.dart';
import 'package:community/pages/mesopage.dart';
import 'package:community/pages/itempage.dart';


class MyDrawer extends StatelessWidget{
  final FirebaseAuth user_ = FirebaseAuth.instance;
  final Logger _logger = Logger();


  Future<void> logOut(BuildContext context) async {
    try{
      await user_.signOut();
    }catch(e){
      _logger.e(('Logout error: $e'));
    }
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      elevation: 16,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Palette.shadowColor,
                offset: Offset(0,2),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child:  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          child: Icon(Icons.account_circle_outlined,
                          color: Palette.iconColor,
                          size: 20
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              user_.currentUser?.displayName ?? '용사',
                              style: const TextStyle(
                                color: Palette.iconColor,
                                fontSize: 14,
                                fontWeight:  FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Palette.deviderColor,
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 8),
                  child: Text(
                    '사고팔고',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Palette.iconColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.money,
                    color: Palette.iconColor,
                    size:20,
                  ),
                  title: const Text(
                    '메소 거래',
                    style: TextStyle(
                      color: Palette.iconColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MesoPage())
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.star_border_outlined,
                    color: Palette.iconColor,
                    size:20,
                  ),
                  title: const Text(
                    '아이템 거래',
                    style: TextStyle(
                      color: Palette.iconColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemPage())
                    );
                  },
                ),
                const Divider(
                  thickness: 2,
                  color: Palette.deviderColor,
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 8),
                  child: Text(
                    'mobile app only',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Palette.iconColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.border_all),
                  title: const Text('유니온 배치'),
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UnionPage())
                    );
                  },
                ),
                const Divider(
                  thickness: 2,
                  color: Palette.deviderColor,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      minimumSize: const Size.fromHeight(40),
                      side: const BorderSide(color: Palette.cursorColor,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                    ),
                    onPressed: (){
                      logOut(context);
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 20,
                          color: Palette.iconColor,
                          ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Palette.iconColor,
                            fontSize:16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}