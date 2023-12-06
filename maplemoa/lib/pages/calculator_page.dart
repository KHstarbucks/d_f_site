import'package:flutter/material.dart';
import 'package:community/providers/palette.dart';
import 'package:community/providers/spec_cal.dart';

class CalculatorPage extends StatefulWidget{
  const CalculatorPage({Key? key}) : super(key:key);
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();


}
class _CalculatorPageState extends State<CalculatorPage>{

  final TextEditingController _levelController = TextEditingController();
  //전투력
  final TextEditingController _combatController = TextEditingController();
  //마력
  final TextEditingController _spellController = TextEditingController();
  //공마퍼
  final TextEditingController _percentageController = TextEditingController();
  //방무
  final TextEditingController _armorbreakController = TextEditingController();
  //벞지
  final TextEditingController _buffController = TextEditingController();
  //쿨감
  final TextEditingController _cooltimeController = TextEditingController();
  //해방여부
  bool isReleased = false;
  //총데미지
  final TextEditingController _totaldamageController = TextEditingController();
  //크뎀
  final TextEditingController _criticalController = TextEditingController();

  int result = -1;
  String printResult = '';

  int? parseInt(String num){
    try{
      return int.tryParse(num);
    }catch(e){
      return null;
    }
  }

  double? parseDouble(String num){
    try{
      return double.tryParse(num);
    }catch(e){
      return null;
    }
  }
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('환산 계산기',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor:Palette.mainColor,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child:Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 570,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Palette.shadowColor,
                  offset: Offset(0,2),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Align(
              alignment: const AlignmentDirectional(0,0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'ArchMage(fire,poison)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isReleased, 
                          onChanged: (value){
                            setState(() {
                              isReleased = value!;
                            });
                          }
                        ),
                        const Text('해방',
                          style: TextStyle(
                            fontSize:16,
                          ),
                        ),
                      ],
                    ),
                    //레벨
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _levelController,
                          autofillHints: const ['Level'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: 'Level',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //전투력
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _combatController,
                          autofillHints: const ['전투력'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '전투력 (만단위입력)',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //마력
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _spellController,
                          autofillHints: const ['마력'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '마력',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //마력퍼
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _percentageController,
                          autofillHints: const ['총마력퍼'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '총마력퍼',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //방무
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _armorbreakController,
                          autofillHints: const ['방무'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '방무',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //벞지
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _buffController,
                          autofillHints: const ['버프지속시간'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '버프지속시간',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //쿨감
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _cooltimeController,
                          autofillHints: const ['쿨감'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '쿨감',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //크뎀
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _criticalController,
                          autofillHints: const ['크뎀'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '크뎀',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    //총 보뎀
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _totaldamageController,
                          autofillHints: const ['보공+데미지'],
                          obscureText: false,
                          cursorColor: Palette.cursorColor,
                          decoration: InputDecoration(
                            labelText: '보공+데미지',
                            labelStyle: const TextStyle(
                              color: Palette.cursorColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Palette.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Palette.borderColor,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.mainColor,
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          minimumSize: const Size.fromHeight(44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Text('calculate'),
                        onPressed: () async{
                          String _level = _levelController.text;
                          String _combat = _combatController.text;
                          String _spell = _spellController.text;
                          String _percentage = _percentageController.text;
                          String _armorbreak = _armorbreakController.text;
                          String _buff = _buffController.text;
                          String _cooltime = _cooltimeController.text;
                          String _totaldamage = _totaldamageController.text;
                          String _critical = _criticalController.text;
                          int? level = parseInt(_level);
                          int? combat = parseInt(_combat);
                          int? spell = parseInt(_spell);
                          int? percentage = parseInt(_percentage);
                          double? armorbreak = parseDouble(_armorbreak);
                          int? buff = parseInt(_buff);
                          int? cooltime = parseInt(_cooltime);
                          int? totaldamage = parseInt(_totaldamage);
                          double? critical = parseDouble(_critical);

                          setState(() {
                            result = calculateSpec(isReleased, level!, combat!*10000, spell!, percentage!,
                          armorbreak!, critical!, cooltime!, buff!, totaldamage!);
                            if(result != -1){
                              printResult = result.toString();
                            }
                            else{
                              printResult = 'Invalid input.';
                            }
                          });
                          
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Palette.mainColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(printResult,
                      style: const TextStyle(
                        color: Palette.cursorColor,
                        fontSize: 16,
                      )),
                    ),
                  ],
                ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}