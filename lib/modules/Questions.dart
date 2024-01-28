class Questions {
  late List<String> arabicQuestions=[];
  late List<String> englishQuestions=[];
  Questions(){
    arabicQuestions.add("هل طفلك يتواصل بصريا عند التحدث إليه؟");
    englishQuestions.add("Does your child maintain eye contact while talking to him?");
    arabicQuestions.add("هل يلتفت طفلك عند مناداته باسمه؟");
    englishQuestions.add("Does your child respond to you calling out his name?");
    arabicQuestions.add("هل يلتفت طفلك للمثيرات الحسية أو البصرية من حولك؟");
    englishQuestions.add("Does your child react to sensory or visual stimuli around them?");
    arabicQuestions.add("هل يتفاعل طفلك مع من حوله من الأطفال؟");
    englishQuestions.add("Does your child interact with other children around them?");
    arabicQuestions.add("هل يتفاعل طفلك مع من حوله من البالغين؟");
    englishQuestions.add("Does your child interact with adults around them?");
    arabicQuestions.add("هل تلاحظ وجود حركات نمطية لدى طفلك كالرفرفة و تحريك الأيدي؟");
    englishQuestions.add("Have you noticed any repetitive movements in your child, such as flapping or hand movements?");
    arabicQuestions.add("هل لطفلك سلوكيات روتينية؟");
    englishQuestions.add("Does your child have any routine behaviors?");
    arabicQuestions.add("هل يميز طفلك الأخطار المحيطة به؟");
    englishQuestions.add("Does your child recognize the dangers around them?");
    arabicQuestions.add("هل طفلك قادر على امساك أشياء و قطع صغيرة الحجم؟");
    englishQuestions.add("Is your child able to grasp things and handle small objects?");
    arabicQuestions.add("طفلك لديه نظرة دقيقة للتفاصيل؛ فالأشياء التي عادة ما تفوت انتباه الآخرين، غالبًا ما تلفت انتباهه");
    englishQuestions.add("Your child has a strong eye for details; things that usually goes unnoticed to other people often catches their attention?");
    arabicQuestions.add("طفلك يستمتع بالقيام بالأشياء مع الآخرين بدلاً من القيام بها بمفرده");
    englishQuestions.add("Your child enjoys to do stuffs with others rather than just by themselves");
    arabicQuestions.add("هل ينزعج طفلك من الأصوات الصاخبة من حوله؟");
    englishQuestions.add("Does your child get annoyed with loud sounds around them?");
    arabicQuestions.add("هل طفلك قادر على التعبير عن احتياجاته و رغباته و مشاعره؟");
    englishQuestions.add("Can your child express their needs, desires, and feelings?");
    arabicQuestions.add("هل يعاني طفلك من كلام محدود (غير لفظي أو يتحدث فقط بعبارات قصيرة)؟");
    englishQuestions.add("Does your child have limited speech (non-verbal or speaks in only short phrases)?");
    arabicQuestions.add("هل لدى طفلك اهتمامات ملحوظة بشكل مفرط؟");
    englishQuestions.add("Does your child have obsessive interests?");
    arabicQuestions.add("هل يعاني طفلك من حساسية زائدة أو نقصان في استشعار الروائح، النكهات، أو اللمس؟");
    englishQuestions.add("Is your child over or under-sensitive to smells, tastes, or touch?");
    arabicQuestions.add("هل تساءلت يومًا عما إذا كان طفلك قد يكون أصمًا؟");
    englishQuestions.add("Have you ever wondered if your child might be deaf?");
    arabicQuestions.add("هل يمشي طفلك على أطراف قدميه؟");
    englishQuestions.add("Does your child tippy toe?");
    arabicQuestions.add("هل يحاول طفلك تقليد ما تفعله أنت؟");
    englishQuestions.add("Does your child try to copy what you do?");
    arabicQuestions.add("هل يظهر لدى طفلك ذاكرة غير عادية للتفاصيل؟");
    englishQuestions.add("Does your child appear to have an unusual memory for details?");
    arabicQuestions.add("هل طفلك قادر على الجلوس لأكثر من دقيقتان");
    englishQuestions.add("Is your child able to sit still for more than 2 mintues?");
  }
  int calculateAutismLevel(List<double> answers) {
    double totalScore = answers.reduce((value, element) => value + element);

    double level1Threshold = 30; // Adjust threshold values as needed
    double level2Threshold = 50;
    double level3Threshold = 70;// Adjust threshold values as needed

    if (totalScore < level1Threshold) {
      return 0; // No significant autism traits
    } else if (totalScore < level2Threshold) {
      return 1; // Level 1: Mild autism traits
    } else if(totalScore < level3Threshold){
      return 2; // Level 2: Moderate to severe autism traits
    }
      return 3;
  }
}