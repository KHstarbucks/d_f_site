import 'dart:math';

int decideAI44(bool aj32, bool ai32, bool aj39, bool ai39,
                int aj30, int ai30
               ,int ai37, int aj37 ){
  if(aj32){
    return aj30;
  }
  else if(ai32){
    return ai30;
  }
  else if(aj39){
    return aj37;
  }
  else if(ai39){
    return ai37;
  }
  else{
    return 0;
  }
}
double decideR26(int cooltime){
  if(cooltime == 1){
    return 0.02335;
  }
  else if(cooltime == 2){
    return 0.03603;
  }
  else if(cooltime == 3){
    return 0.04447;
  }
  else if(cooltime == 4){
    return 0.05512;
  }
  else if(cooltime == 5){
    return 0.07442;
  }
  else if(cooltime == 6){
    return 0.10881;
  }
  else if(cooltime == 7){
    return 0.16475;
  }
  else {
    return 0;
  }
}
int findMatch(double infi, List<int> values) {
  for (int i = 0; i < values.length; i++) {
    if (infi < values[i]) {
      return (i > 0) ? i - 1 : 0;
    }
  }
  return 0;
}

double buffCorrectionforR26(int buff, int cooltime) {
  List<int> eValues = [];
  List<int> fValues = [];
  List<int> gValues = [];
  List<double> unstablePercentage = [1, 6, 6, 6, 10, 11, 12, 12, 12, 8, 6, 5, 2, 2, 1];

  // e,f,g values 채우기
  eValues.add(0);
  fValues.add(70);
  gValues.add(0);
  for (int i = 1; i < 34; i++) {
    eValues.add(5 * i);
    if (70 + 3 * i > 115) {
      fValues.add(115);
    } else {
      fValues.add(70 + 3 * i);
    }
    gValues.add(gValues[i - 1] + fValues[i - 1] * 5);
  }

  double infiContinueTime = (buff + 100) * 0.01 * 41;

  // eValues에서 match된 인덱스 찾기
  int match = findMatch(infiContinueTime, eValues);
  
  //#16
  List<double> userSpec = List.generate(unstablePercentage.length, (index) => 0.0);
  //#30
  List<double> userMiddleLayer = List.generate(unstablePercentage.length, (index) => 0.0);
  //#44
  List<double> userSpecMiddle = List.generate(unstablePercentage.length, (index) => 0.0);
  //#58
  List<double> calculateInfi = List.filled(unstablePercentage.length, 0.0);

  double userG = 340 * 0.95 - cooltime;
  List<int> minusRate = [20,23,24,25,27,30,33,35,38,40,45,50,55,60,65];

  for (int i = 0; i < unstablePercentage.length; i++) {
    userSpec[i] = userG * (100 - minusRate[i]) / 100;

    if (userSpec[i] > 2 * infiContinueTime) {
      userMiddleLayer[i] = userSpec[i] - 2 * infiContinueTime;
    } else {
      userMiddleLayer[i] = 0;
    }
  }

  for (int i = 0; i < unstablePercentage.length; i++) {
    userSpecMiddle[i] = ((infiContinueTime - eValues[match]) * fValues[match + 1] + gValues[match]) * 2 / (2 * infiContinueTime + userMiddleLayer[i]);
  }

  double r26 = 0;
  for (int i = 0; i < unstablePercentage.length; i++) {
    calculateInfi[i] = userSpecMiddle[i] * 0.01 * unstablePercentage[i];
    r26 += calculateInfi[i];
  }

  return r26;
}

int calculateSpec(bool isreleased, int level, int combat, int spell,int percentage, double armorbreak,
  double critical, int cooltime, int buff, int damage){
  
  int leveldiv20 = level~/20;
  int ai30 = ((spell - leveldiv20) / (1 + percentage/100)).floor();
  int aj30 = ai30 +1;
  int ai31 = (ai30 * (1+percentage /100)).floor() + leveldiv20;
  int aj31 = ((percentage / 100 + 1) * aj30).floor() + leveldiv20;
  bool ai32 = ai31 == spell;
  bool aj32 = aj31 == spell;
  bool ai33 = ai32 || aj32;
  int ai37 = spell ~/ (1 + percentage / 100);
  int aj37 = ai37 + 1;
  int ai38 = ai37 * (1 + percentage / 100).floor();
  int aj38 = aj37 * (1 + percentage / 100).floor();
  bool ai39 = ai38 == spell;
  bool aj39 = aj38 == spell;
  bool ai40 = ai39 || aj39 || ai33;
  if(ai40 == false){
    return -1;
  }

  int ai44 = decideAI44(aj32, ai32, aj39, ai39, aj30,ai30, ai37, aj37);
  int aj44 = isreleased ? 340:308;
  
  int ak44 = ai44-aj44;
  
  //전투력 보정 공
  int ai51 = (ak44*(1+percentage/100)).floor() + leveldiv20;

  double releasedDamage = isreleased? 1.1 : 1.0;
  double ai64 = combat / ai51 / (1 + (damage - 81) / 100) / (1.35+ (critical - 25) / 100) / releasedDamage;
  ai64 = double.parse(ai64.toStringAsFixed(2));

  // 스탯 상수
  double stat = pow(ai64, 2) * (-0.00000557) + ai64 * (1.112862) + 18.955436;
  stat = double.parse(stat.toStringAsFixed(5));

  // 크뎀 상수
  double cridam = (135 + critical + 35) / 100 + 0.08;
  // 최종뎀 상수
  double r26 = 0.995 * (1+decideR26(cooltime))*(100+buffCorrectionforR26(buff,cooltime))/100;
  double c8 = isreleased ? (1.54 * r26 - 1) * 100 : (1.4 * r26 - 1) * 100;
  double damageCorrection = 1 + c8 / 100;
  // 방무 상수
  double r92 = (1 - (1 - armorbreak * 0.01) * 0.91 * 0.765 * 0.85) * 100;
  double breakArmor = (100 - (300 - 300 * r92 / 100)) / 100;
  // 벞지 보정 
  double i17 = 10 * (1 + buff / 100) + 2;
  double p17 = (i17 > 30) ? 27 : 2 * i17 - 33;
  double r17 = (i17 > 30) ? (i17 - 30) * 2 : 0;
  double buffCorrection = 45*(0.35 + min(i17,18)/18 * 0.15 + p17 / 27 * 0.15+r17/58.5 * 0.35);
  // 보총뎀 상수,상추뎀 포함
  double bossCorrection = 1.1 + (6 + buffCorrection + damage + 52.2 + 95 + 112 + 57.7075) / 100;
  //공퍼 상수
  double percentageCorrection = 1.22+ percentage/100;
  // am103
  double am103 = percentageCorrection* 1.2 * 0.98 * cridam * stat * (ai44 + 225) * breakArmor * damageCorrection * bossCorrection;
  // d158
  double d158 = am103;

  double e158 = d158 /pow(10,12);
  double m110 = 0.000006675964316;
  double m111 = 0.00003266455515;
  double n110 = -0.000008832634204;
  double n111 = -0.0006361316834;
  double o110= 0.0000541668126;
  double o111 = 0.004689175204;
  double p110 = 0.0000006150109436;
  double p111 = -0.01055543888;

  double q114 = (pow(7.1844,3)*m111 + pow(7.1844,2)*n111 + 7.1844*o111+p111)*pow(10,12);

  double g158 = d158 > q114 ? m111 : m110;
  double h158 = d158 > q114 ? n111 : n110;
  double i158 = d158 > q114 ? o111 : o110;
  double j158 = d158 > q114 ? p111 : p110;
  double k158 = h158/g158;
  double l158 = i158/g158;
  double m158 = (j158-e158)/g158;
  double n158 = (l158 - pow(k158,2)/3)/3;
  double o158 = -(m158 +(2*pow(k158,3) - 9*k158*l158)/27)/2;
  double p158 = (pow(n158,3) + pow(o158,2)).toDouble();
  
  //복소수 변환
  Complex complexO = Complex(o158,0);
  Complex complexP = Complex(p158,0);
  
  Complex complexQ = complexO.add(complexP.comSqrt());
  Complex complexR = complexO.sub(complexP.comSqrt());

  Complex complexT = Complex(pow(complexQ.real.abs(),1/3).toDouble(),0);
  Complex complexU = Complex(-pow(complexR.real.abs(),1/3).toDouble(),0);

  Complex complexV = complexT.add(complexU);

  int result = ((complexV.real - k158/3) * 10000).floor();

  return result;
}


//복소수 계산을 위한 class
class Complex {
  double real;
  double imaginary;

  Complex(this.real, this.imaginary);

  // 두 복소수의 합을 계산하는 함수
  Complex add(Complex other) {
    return Complex(real + other.real, imaginary + other.imaginary);
  }
  //차
  Complex sub(Complex other){
    return Complex(real - other.real, imaginary - other.imaginary);
  }
  //절대값
  Complex abs(){
    return Complex(real.abs(), imaginary.abs());
  }

  // 복소수의 제곱근을 계산하는 함수
  Complex comSqrt() {
    double r = sqrt(real * real + imaginary * imaginary);
    double theta = atan2(imaginary, real) / 2.0;
    double newReal = sqrt(r) * cos(theta);
    double newImaginary = sqrt(r) * sin(theta);
    return Complex(newReal, newImaginary);
  }
}
