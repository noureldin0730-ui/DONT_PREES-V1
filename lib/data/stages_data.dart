class Stage {
  final int id;
  final String title;
  final String brief;
  final int maxAttempts;
  final String whisper;
  const Stage({
    required this.id,
    required this.title,
    required this.brief,
    required this.maxAttempts,
    required this.whisper,
  });
}

const List<Stage> kStages = [
  Stage(id: 1, title: 'لا تضغط 20 مرة', brief: 'الزر بيتحرك. الحق اضغط 20 ضغطة في 20 ثانية.', maxAttempts: 3, whisper: 'سمعت صوت؟ ... يمكن مفيش حاجة.'),
  Stage(id: 2, title: 'الزر الصح', brief: '3 أزرار. واحد بس هو الصح.', maxAttempts: 3, whisper: 'الزر عارف إنك بتفكر.'),
  Stage(id: 3, title: 'الصمت', brief: 'متضغطش خالص لمدة 5 ثواني.', maxAttempts: 3, whisper: 'الصمت بيوجع أكتر من الضغط.'),
  Stage(id: 4, title: 'الترتيب', brief: '4 أزرار. احفظ الترتيب واضغطه صح.', maxAttempts: 3, whisper: 'الترتيب دا كان في مكان تاني.'),
  Stage(id: 5, title: 'الكود السري', brief: '3 أرقام هتظهر لحظة. احفظهم وأدخلهم.', maxAttempts: 3, whisper: 'الأرقام دي مألوفة؟'),
  Stage(id: 6, title: 'لا تنظر', brief: 'الشاشة هتعتم. اضغط من غير ما تشوف.', maxAttempts: 3, whisper: 'مين اللي بيضغط؟ إنت ولا الزر؟'),
  Stage(id: 7, title: 'المتحرك', brief: '5 أزرار. واحد بس بيتحرك. اضغطه.', maxAttempts: 3, whisper: 'الزر بيهرب منك.'),
  Stage(id: 8, title: 'العد التنازلي', brief: 'اضغط قبل ما الوقت يخلص.', maxAttempts: 3, whisper: 'الوقت مش دايم في صفك.'),
  Stage(id: 9, title: 'الاختيار', brief: 'همسة تقول: "افتح الباب."', maxAttempts: 3, whisper: 'الباب اللي جواك.'),
  Stage(id: 10, title: 'الحقيقة', brief: 'الزر الأخير. اضغطه لو تجرؤ.', maxAttempts: 3, whisper: 'مفيش رجوع بعد كده.'),
  Stage(id: 11, title: 'المرايا', brief: '3 أزرار. واحد بس أصلي. الباقي انعكاس.', maxAttempts: 3, whisper: 'شوف كويس مين إنت.'),
  Stage(id: 12, title: 'الهمس', brief: 'كلمة هتظهر لحظة. اكتبها صح.', maxAttempts: 3, whisper: 'الكلمة دي هتفضل معاك.'),
  Stage(id: 13, title: 'الظل', brief: 'ظل بيتحرك. اضغطه قبل ما يختفي.', maxAttempts: 3, whisper: 'الظل بيعرف اسمك.'),
  Stage(id: 14, title: 'المتاهة', brief: 'الهدف بيتغير كل ثانية. اجمع 3 إصابات.', maxAttempts: 3, whisper: 'التوهان جزء من اللعبة.'),
  Stage(id: 15, title: 'المقلوب', brief: 'اقرأ بعكس ما تشوف.', maxAttempts: 3, whisper: 'الحقيقة معكوسة.'),
  Stage(id: 16, title: 'الذاكرة', brief: '5 رموز تظهر بالترتيب. كررها.', maxAttempts: 3, whisper: 'اللي هتنساه هيفضل يفتكرك.'),
  Stage(id: 17, title: 'الصبر', brief: '10 ثواني بدون لمس. الفخ بيستفزك.', maxAttempts: 3, whisper: 'الزر بيكلمك. اسمعه.'),
  Stage(id: 18, title: 'الارتباك', brief: '8 أزرار. واحد بس بيتحرك.', maxAttempts: 3, whisper: 'كلهم بيتحركوا لو بصيت كفاية.'),
  Stage(id: 19, title: 'القرار الأخير', brief: '3 أزرار. واحد بس بيكمل.', maxAttempts: 3, whisper: 'آخر قرار.'),
  Stage(id: 20, title: 'الباب', brief: 'اضغط 5 ثواني بدون رفع صباعك.', maxAttempts: 3, whisper: 'افتح الباب.'),
  Stage(id: 21, title: 'الظلام', brief: 'الزر مخفي في الضلمة. حس بيه.', maxAttempts: 3, whisper: 'عينك مش هتساعدك هنا.'),
  Stage(id: 22, title: 'التوأم', brief: 'زرين متطابقين. اضغطهم في نفس الوقت.', maxAttempts: 3, whisper: 'الاتنين واحد. أو مش واحد.'),
  Stage(id: 23, title: 'الدوار', brief: 'الزر بيلف حوالين الشاشة. اضغطه 3 مرات.', maxAttempts: 3, whisper: 'مش هتقدر تلحق.'),
  Stage(id: 24, title: 'الصوت', brief: 'الشاشة هتسكت. اعتمد على الإحساس بس.', maxAttempts: 3, whisper: 'حس بالإيد اللي مش شايفها.'),
  Stage(id: 25, title: 'العد التنازلي للفشل', brief: 'كل ثانية بتقربك من الفشل. اضغط بسرعة.', maxAttempts: 3, whisper: 'الوقت بيجري منك.'),
  Stage(id: 26, title: 'المرايا المتعددة', brief: '5 أزرار. واحد بس بيتحرك ببطء.', maxAttempts: 3, whisper: 'واحد بس بيعرف الطريق.'),
  Stage(id: 27, title: 'الكمين', brief: '5 ضغطات صح ورا بعض. أي غلطة بتفشل.', maxAttempts: 3, whisper: 'الغلطة الواحدة بتكلف.'),
  Stage(id: 28, title: 'الحبل', brief: 'الشاشة بتتقطع. اضغط قبل ما تختفي خالص.', maxAttempts: 3, whisper: 'الخيط بيقطع.'),
  Stage(id: 29, title: 'الاسم', brief: 'اكتب اسمك. بعدين اضغط الزر اللي فيه اسمك.', maxAttempts: 3, whisper: 'إنت مين؟'),
  Stage(id: 30, title: 'الباب الأخير', brief: 'اضغط الزر 3 مرات. المرة التالتة بتفتح الحقيقة.', maxAttempts: 3, whisper: 'خلاص. ما فيش بعد كده.'),
];