// LIST ITEMS SidMenu
import 'package:emschool_dashboard/models/user_response.dart';
import 'package:emschool_dashboard/ui/class_rooms_screen/class_rooms_screen.dart';
import 'package:emschool_dashboard/ui/dashboard_screen/dashboard_screen.dart';
import 'package:emschool_dashboard/ui/entertainment_screen/entertainment_screen.dart';
import 'package:emschool_dashboard/ui/events_screen/events_screen.dart';
import 'package:emschool_dashboard/ui/lessons_screen/lessons_screen.dart';
import 'package:emschool_dashboard/ui/news_screen/news_screen.dart';
import 'package:emschool_dashboard/ui/notificationns_screen/notificationns_screen.dart';
import 'package:emschool_dashboard/ui/schedules_screen/schedules_screen.dart';
import 'package:emschool_dashboard/ui/stages_screen/stages_screen.dart';
import 'package:emschool_dashboard/ui/subjects_screen/subjects_screen.dart';
import 'package:emschool_dashboard/ui/type_educations_screen/type_educations_screen.dart';
import 'package:emschool_dashboard/ui/users_screen/parents_screen.dart';
import 'package:emschool_dashboard/ui/users_screen/teachers_screen.dart';
import 'package:emschool_dashboard/ui/users_screen/users_screen.dart';
import 'package:flutter/material.dart';

import '../../models/response_data_for_login.dart';

ResponseDataForLogin? responseDataForLogin;
UserResponse? currentUser;

List<dynamic> listItems = [
  {'id': 0, 'name': "الرئيسية ", "icon": Icons.home},
  {'id': 1, 'name': "انواع التعليم", "icon": Icons.table_chart_sharp},
  {'id': 2, 'name': "المراحل التعليمية", "icon": Icons.storage},
  {'id': 3, 'name': "الصفوف الدراسية", "icon": Icons.call_missed_outlined},
  {'id': 4, 'name': "المواد الدراسية", "icon": Icons.calculate_sharp},
  {'id': 5, 'name': "الدروس", "icon": Icons.play_lesson},
  {'id': 6, 'name': "الطلاب", "icon": Icons.group_sharp},
  {'id': 7, 'name': "المعلمين", "icon": Icons.person_3_sharp},
   {'id': 8, 'name': "آولياء الآمور", "icon": Icons.circle_notifications},
  {'id': 9, 'name': "الفعاليات", "icon": Icons.event},
  {'id': 10, 'name': "الترفية", "icon": Icons.bookmarks_rounded},
  {'id': 11, 'name': "الجداول", "icon": Icons.table_chart_outlined},
  {'id': 12, 'name': "الاشعارات", "icon": Icons.notifications_active},

   {'id': 13, 'name': "الأخبار", "icon": Icons.newspaper},
  // {'id': 8, 'name': "المادة العلمية ", "icon": Icons.layers_sharp},
];

List<Widget> screens = [
  const DashboardScreen(),
  const TypeEducationsScreen(),
  const StagesScreen(),
  const ClassRoomsScreen(),
  const SubbjectsScreen(),
  const LessonsScreen(),
  const UsersScreen(),
  const TeachersScreen(),
  const ParentssScreen(),
  const EventsScreen(),
  const EntertainmentScreen(),
  const SchedulesScreen(),
  const NotificationsScreen(),
 const NewsScreen()
];

// يشار إلى منصة هاتلي على أنها الطرف الأول وهي منصة تتيح للطرف الثاني النشر الإلكتروني التجاري عليها وفق الأنظمة في المملكه العربية السعودية ومقرها الرياض ومسجلة باسم مؤسسة هاتلي للتوصيل الطرود  سجل تجاري رقم /  ١٠١٠٨٧٧٣٣٠
// ويشار لطرف الثاني على انه الناشر وهو التاجر .
// كما أن جميع النزاعات القانونية تقام داخل اروقة المحاكم السعودية فقط
// تجدر الإشارة أن استعمالك لمنصة هاتلي يعني الموافقة القانونية على جميع الشروط والأحكام الخاصة بالمنصة .
String privacy = """
<div>
 <h1> شروط الاستخدام </h1>
 <p>مقدمه : </p>
 <p> 
 
 </p>


 <h3>المادة الأولى :</h3>
<ol>شروط استعمال منصة ( هاتلي)


  <li>اختيار القسم الصحيح بمنتاجاتك ومراجعته جيداً</li>
  <li>رفع صور جيدة تعكس جودة منتجاتك</li>
  <li> عدم التلاعب بالاسعار مما يضر بالمستهلك والسوق</li>
  <li> عدم نشر المنتجات الممنوعة بنظام المملكه العربية السعودية
( راجع السلع الممنوعه بالأسفل )
</li>
  <li>عدم استعمال منصة هاتلي إذا كنت غير مؤهل شرعاً كالحجر آو الجنون إلى آخره</li>
  <li>٦-عدم تقمص دور منشأة أو جهة بدون علمها والترويج لمنتجاتها على هاتلي</li>
  <li>عدم انتهاك أنظمة حماية البيئة والحياة الفطرية</li>
  <li>عدم استعمال المنصة للعبث أو محاولات السبام أو الطلبات العشوائية أو محاولة الاغراق أو الاختراق إلى آخره.</li>
  <li> غير مسموح قطعاً التواصل مع التجار أو الأشخاص بإسم منصة هاتلي مهما كان السبب و المبرر</li>
  <li> عدم التحايل على العملاء سواء بالأسعار أو المنتجات أو أي طريقة كانت</li>
</ol>



 <h3> البند الثاني</h3>
<ol>السلع الممنوعة في منصة هاتلي


  <li>يمنع الترويج للممنوعات والكحول نهائيا</li>
  <li>منع الترويج لجميع الأجهزة الممنوعة مثل . أجهزة التنصت والتشويش و الليزر وغيرها</li>
<li>يمنع بيع الماركات المقلدة بجميع أنواعها وأشكالها</li>
<li>يمنع بيع وترويج أي مواد مقرصنة وتنتهك الحقوق الفكرية والأدبية وحقوق النسخ</li>
<li>منع الترويج للحيوانات المهددة بالانقراض أو مخالفة نظام الحياة الفطرية
</li>
<li>يمنع الترويج للأسلحة والذخائر وما يدخل في تركيبتها وتصنيعها</li>
<li>يمنع الترويج للأجهزة أو السلع المسروقة</li>
<li>يمنع منعاً باتاً الترويج للأجهزة الحكومية أو الأوسمة والأنواط  أو أي ممتلكات حكومية</li>
<li>منع أي سلعة ممنوعة حسب النظام  في المملكة العربية السعودية</li>

</ol>

 <h3> البند الثالث :</h3>
<ol>
أخلاقيات البيع ( خاصة بالبائع )

  <li>عدم التطفيف في الكيل بالنقص من الوزن مهما كان قليلا</li>
  <li>التعاون مع العميل والصبر عليه والأخذ بالمثل القائل( العميل على حق وأن كان مخطئاً )</li>
<li>أجعل لك سياسية مرنة بالإرجاع والتعاون وأكسب العملاء بحسن تعاونك</li>
<li>لا تتذمر من طلبات العملاء فهذا باب رزق يجب عليك الحمد عليه</li>
<li>اختيار الاسعار المناسبة للبيع وجذب العملاء بها وتذكر أن الكسب السريع لايدوم</li>
<li>إذا كنت تبيع الأكل يجب عليك الاهتمام بالأكل وجودة المواد وتذكر أنه يأكل منه الأطفال والمرضى وكبار السن</li>
<li>إذا كنت تعرض السلع المستعملة يجب عليك شرعا وقانوناً أن تبين مدة أستعمالها ومدى نظافتها وأي ملاحظة على السلعة أن وجدت</li>
<li>عدم زيادة بالسعر لأجل التعويض قيمة التوصيل لأن التوصيل من مهامك ومجاناً مقابل بيع وترويج منتجاتك على نطاق واسع من حولك </li>

</ol>

<hr>
<ol>
أخلاقيات الشراء ( خاصة بالمشتري )


  <li>الشراء والتسوق متعة فلا تعكر مزاجك بأشياء صغيرة مثل تأخير الطلب البسيط أو التغليف إذا كان منتجك بخير</li>
<li>استشعر أن التاجر إنسان ويقع منه الخطأ والنسيان مهما كان حريص يجب تفهم ذلك</li>
<li>تأكد من توفر المال معك قبل اتمام الطلب سواء كاش أو بحسابك البنكي</li>
<li>تقييمك مهم للتاجر يجب مراعاة هذا الأمر بجدية وتذكر أنك محاسب على تقييمك أمام الله</li>
<li>-البيع والشراء من الأمور الجدية بالحياة يجب الابتعاد عن الطلبات الغير جادة التي تضيع وقت وجهد التاجر في تجهيز طلبات وهمية</li>
<li>تذكر أن التاجر يعمل لكسب رزقه وهو موجود على المنصة لخدمتك حاول قدر المستطاع أن تكون له عونا وسندا لتطوير نفسه والكسب الحلال من خلال تكرار الطلب منه وقت حاجتك</li>
</ol>

</div>
 """;

String quiz = """
<div>
 <h1> الأسئلة الشائعة : </h1>
 <h3>
 من الذي يحق له التسجيل بمنصة هاتلي ؟
 </h3>
 <p>
 التسجيل متاح للجميع بكل الفئات سواءً أفراد أو مؤسسات وكذلك مقيم أو مواطن
 </p>

  <h3>
  من الذي يحق له البيع على هاتلي ؟
 </h3>
 <p>
 الجميع مرحب به سواء أفراد أو مؤسسات لبيع منتجاته على منصة هاتلي
 </p>





  <h3>
  كيف يتم تفعيل الحساب ؟
 </h3>
 <p>
 حساب المشترين يتم تفعيلها تلقائيا برقم الجوال الصحيح والدخول للحساب والشراء بكل سهولة
حساب المؤسسات يتم مراجعة الأوراق من قبل الموظف بشكل روتيني ويتم التفعيل بالعادة بغضون ساعة إلى ٢٤ ساعة بخلاف يوم الجمعة
 </p>


 <h3>
 حسابي لم يتم تفعيله ماذا أفعل ؟
 </h3>
 <p>
 إذا كان حسابك مشتري يتم بالعادة التفعيل بدون تدخل للمنصة عليك التأكد من رقم الجوال المدخل حتى تتمكن من ادخال الرمز المرسل لك في حال لم يصل الرمز تواصل مع خدمة العملاء ( وآتساب ) على الرقم التالي : 0557755462
أما إذا كان الحساب للبائع تأكد من أدخال جميع الأوراق كاملة وواضحة القراءة مع إدراج رقم جوال صحيح في حال لم يتم التفعيل  بعد مضي ٢٤ ساعة يمكنك التواصل مع خدمة العملاء ( وآتساب ) على الرقم التالي: 0557755462
 </p>


  <h3>
  كيف يتم الشراء والدفع ؟
 </h3>
 <p>
 يستطيع كل شخص شراء أي منتج يحتاجه ويقوم التاجر بتوصيل الطلب لباب المنزل
برسوم ثابتة ٢ ريال فقط مهما كان حجم الطلب أو سعره
كما انه متاح الدفع الإلكتروني والدفع الكاش عند الاستلام بدون رسوم إضافية
 </p>


  <h3>
  لماذا قيمة التوصيل منخفضة مقارنة بالتطبيقات الأخرى؟
 </h3>
 <p>
 لاننا اتفقنا مع صاحب المنتج نفسه ان يقوم بالتوصيل وليس شركات طرف ثالث تأخذ مبالغ كبيرة على خدمة التوصيل وتأخذ نسب من قيمة المنتجات أيضاً وهذا مايميز منصة هاتلي عن باقي المنصات  الأخرى
 </p>

   <h3>
   كم نسبة منصة هاتلي من قيمة المبيعات ؟
 </h3>
 <p>
 لايوجد نسبة ( مجاناً )
 </p>


   <h3>
   كم سعر التوصيل ؟
 </h3>
 <p>
 هناك رسم رمزي ثابت لكل شحنة توصيل ٢ ريال فقط مهما كانت قيمة الشحنة ووزنها وعددها
 </p>


</div>

""";
