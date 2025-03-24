import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, String> wordGifMap = {
   "what time is it":"whattimeisit.gif",
  "كم الساعه": "whattimeisit.gif",
  "airplane": "Airplane.gif",
  "طائره": "Airplane.gif",
  "all": "All.gif",
  "الكل": "All.gif",
  "all night": "AllNight.gif",
  "طوال الليل": "AllNight.gif",
  "awesome": "Awesome.gif",
  "رائع": "Awesome.gif",
  "baby": "Baby.gif",
  "طفل": "Baby.gif",
  "big": "Big.gif",
  "كبير": "Big.gif",
  "box office": "BoxOffice.gif",
  "شباك التذاكر": "BoxOffice.gif",
  
  "bus": "Bus.gif",
  "حافله": "Bus.gif",
  
  "car": "Car.gif",
  "سياره": "Car.gif",
  "children": "Children.gif",
  "اطفال": "Children.gif",
  "congratulations": "Award.gif",
  "مبروك": "Award.gif",
  "cool": "Cool.gif",
  "لطيف": "Cool.gif",
  "day": "Day.gif",
  "يوم": "Day.gif",
  
  "delete": "Delete.gif",
  "حذف": "Delete.gif",
  "dusk": "Dusk.gif",
  "الغسق": "Dusk.gif",
  "early": "Early.gif",
  "مبكر": "Early.gif",
  "eating": "Eating.gif",
  "تناول الطعام": "Eating.gif",
  "emergency": "Emergency.gif",
  "طارئ": "Emergency.gif",
  "empty": "Empty.gif",
  "فارغ": "Empty.gif",
  
  "evening": "Evening.gif",
  "مساء": "Evening.gif",
  "everyday": "EveryDay.gif",
  "كل يوم": "EveryDay.gif",
  "every week": "EveryWeek.gif",
  "كل اسبوع": "EveryWeek.gif",
  "facebook": "Facebook.gif",
  "فيسبوك": "Facebook.gif",
  "family": "Family.gif",
  "عائله": "Family.gif",
  "father": "Father.gif",
  "اب": "Father.gif",
  "fire": "Fire.gif",
  "حريق": "Fire.gif",
  "Friday": "Friday.gif",
  "الجمعه": "Friday.gif",
  "friend": "Friend.gif",
  "صديق": "Friend.gif",
  "fun": "Fun.gif",
  "مرح": "Fun.gif",
  "game": "Game.gif",
  "لعبه": "Game.gif",
  "انا اريد": "giphy.gif",
  "I want": "giphy.gif",
  
  
  "good evening": "Goodevening.gif",
  "مساء الخير": "Goodevening.gif",
  "good morning": "Good Morning.gif",
  "صباح الخير": "Good Morning.gif",
  "good night": "Good Night.gif",
  "تصبح على خير": "Good Night.gif",

  "grandfather": "grandFather.gif",
  "جد": "grandFather.gif",
  "grandmother": "GrandMother.gif",
  "جده": "GrandMother.gif",
  "happy": "Happy.gif",
  "سعيد": "Happy.gif",
  "#": "Hashtag.gif",
  "هاشتاج": "Hashtag.gif",
  "hello": "Hello.gif",
  "مرحبا": "Hello.gif",
  "home": "Home.gif",
  "منزل": "Home.gif",
  "our": "Hour.gif",
  "ساعه": "Hour.gif",
  "how are you": "HowAreYou.gif",
  "كيف حالك": "HowAreYou.gif",
  "how are you doing": "HowAreYouDoing.gif",
  "كيف الامور": "HowAreYouDoing.gif",
  "I don't know": "IDontKnow.gif",
  "لا اعرف": "IDontKnow.gif",
  "i don't like this": "Idon'tlike this.gif",
  "لا يعجبني هذا": "Idon'tlike this.gif",
  "I don't understand": "Idon'tunderatand.gif",
  "لا افهم": "Idon'tunderatand.gif",
  "I enjoy this": "Ienjoy this.gif",
  "استمتع بهذا": "Ienjoy this.gif",
  "I know": "IKnow.gif",
  "اعرف": "IKnow.gif",
  "I like it": "I Like It.gif",
  "اعجبني": "I Like It.gif",
  
  
  "I will help you": "I'll help you.gif",
  "ساساعدك": "I'll help you.gif",
  "I'm fine": "I'm Fine.gif",
  "اليوم التالي": "NextDay.gif",
  "next day": "NextDay.gif",
  "حجم متوسط": "MediumSizeBowl.gif",
  "medium size": "MediumSizeBowl.gif",
  "انا بخير": "I'm Fine.gif",
  "Instagram": "Instagram.gif",
  "انستقرام": "Instagram.gif",
  "internet": "Internete.gif",
  "انترنت": "Internete.gif",
  "large": "Large.gif",
  "واسع": "Large.gif",
  "late": "Late.gif",
  "متاخر": "Late.gif",
  "length": "Length.gif",
  "طول": "Length.gif",
  "love": "Love.gif",
  "حب": "Love.gif",
  "medium": "Medium.gif",
  "متوسط": "Medium.gif",
  "mother": "Mother.gif",
  "ام": "Mother.gif",
  "يعني": "Mean.gif",
  "mean": "Mean.gif",
  "motorcycle": "Motorcycle.gif",
  "دراجه ناريه": "Motorcycle.gif",
  "no": "No.gif",
  "لا": "No.gif",
  "number": "Number.gif",
  "رقم": "Number.gif",
  "parents": "Parents.gif",
  "والدين": "Parents.gif",
  "please repeat": "PleaseRepeat.gif",
  "من فضلك اعد": "PleaseRepeat.gif",
  "recording": "Recording.gif",
  "تسجيل": "Recording.gif",
  "sad": "Sad.gif",
  "حزين": "Sad.gif",
  
  
  "sister": "Sister.gif",
  "اخت": "Sister.gif",
  "sorry": "Sorry.gif",
  "اسف": "Sorry.gif",
  "time": "Time.gif",
  "وقت": "Time.gif",
  "today": "Today.gif",
  "اليوم": "Today.gif",
  "tomorrow": "Tomorrow.gif",
  "غدا": "Tomorrow.gif",
  "work": "Work.gif",
  "عمل": "Work.gif",
  "صغير": "Small.gif",
  "small": "Small.gif",
  
  "Saturday": "Saturday.gif",
  "السبت": "Saturday.gif",
  "Sunday": "Sunday.gif",
  "الاحد": "Sunday.gif",
  "quarterback": "Quarterback.gif",
  "قائد الفريق": "Quarterback.gif",
  "see the difference": "See the difference.gif",
  "هل رايت الفرق": "See the difference.gif",
  "stunned": "Stunned.gif",
  "مذهول": "Stunned.gif",
  "surprise": "Surprise.gif",
  "مفاجاه": "Surprise.gif",
  "which building": "WhichBuilding.gif",
  "اي مبنى": "WhichBuilding.gif",
  "volleyball": "voleyball.gif",
  "كره الطائره": "voleyball.gif",
  "medium mug": "medium mug.gif",
  "كوب متوسط": "medium mug.gif",
  "point": "Point.gif",
  "اشر": "Point.gif",
  "when is class finished": "when is class finished.gif",
  "متى ينتهي الفصل": "when is class finished.gif",
  "Maybe": "Maybe.gif",
  "ربما": "Maybe.gif",
  "where is the classroom": "where is the classroom.gif",
  "اين هو الفصل الدراسي": "where is the classroom.gif",
  "shy": "Shy.gif",
  "خجول": "Shy.gif",
  
  
  "it is clear": "it's clear.gif",
  "انه واضح": "it's clear.gif",
  "are you okay": "are you okay.gif",
  "هل انت بخير": "are you okay.gif",
  "it is really hard": "it is really hard.gif",
  "انه صعب للغايه": "it is really hard.gif",
   
  "Weekend": "Weekend.gif",
  "نهايه الاسبوع": "Weekend.gif",
  "Thursday": "Thursday.gif",
  "الخميس": "Thursday.gif",
  "Wednesday": "wednesday.gif",
  "الاربعاء": "wednesday.gif",
  "Tuesday": "Tuesday.gif",
  "الثلاثاء": "Tuesday.gif",
  "Monday": "monday.gif",
  "الاثنين": "monday.gif",
  "time Passage": "time passage.gif",
  "مرور الوقت": "time passage.gif",
  "soon": "Soon.gif",
  "قريبا": "Soon.gif",
  "social media": "SocialMedia.gif",
  "وسائل التواصل الاجتماعي": "SocialMedia.gif",
  "Twitter": "Twitter.gif",
  "تويتر": "Twitter.gif",
  "signing vlog": "signing vlog.gif",
  "تدوين الاشاره": "signing vlog.gif",
  "truck": "Truck.gif",
  "شاحنه": "Truck.gif",
  "ambulance": "Ambulance.gif",
  "سياره اسعاف": "Ambulance.gif",
  "police": "Police.gif",
  "شرطه": "Police.gif",
  "firefighter": "firefighter.gif",
  "رجل الاطفاء": "firefighter.gif",
  "تهجئه": "spell out .gif",
  "spell": "spell out .gif",
};

class TextInputScreen extends StatefulWidget {
  const TextInputScreen({Key? key}) : super(key: key);

  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final TextEditingController _textController = TextEditingController();
  String _searchQuery = '';
  String _selectedLanguage = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deaf_App".tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  250.0, // Show left for English
                  100.0, // Vertical position remains the same
                  _selectedLanguage == 'en'
                      ? 0.0
                      : 250.0, // Show right for Arabic
                  0.0, // Horizontal offset remains the same
                ),
                items: [
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Text('English'),
                  ),
                  PopupMenuItem<String>(
                    value: 'ar',
                    child: Text('Arabic'),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value == 'en' ? 'English' : 'Arabic';
                    Get.updateLocale(Locale(value)); // Update the locale
                  });
                }
              });
            },
            icon: Icon(Icons.change_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                color: const Color(0xFF002244), // Background color of the Card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter your text...',
                      hintStyle: const TextStyle(
                          color: Colors.white70), // Hint text color
                      filled: true,
                      fillColor: const Color(
                          0xFF002244), // Background color of the TextField
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color:
                              Colors.white, // White border color when enabled
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color:
                              Colors.white, // White border color when focused
                          width:
                              2.0, // Optional: Thickness of the focused border
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.red, // Red border color for errors
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors
                              .red, // Red border color when focused in error state
                          width: 2.0, // Optional: Thickness of the error border
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white), // Text color
                    maxLines: 3, // Allows up to 3 lines of input
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Close the keyboard
                  FocusScope.of(context).requestFocus(FocusNode());

                  setState(() {
                    _searchQuery = _textController.text;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Convert to Sign'.tr,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              if (_searchQuery.isNotEmpty) ...[
                SizedBox(height: 15),
                Container(
                  child: Image.asset(
                    "assets/${wordGifMap[_searchQuery] ?? "default.gif"}",
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Sign language GIF not found!'.tr);
                    },
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
