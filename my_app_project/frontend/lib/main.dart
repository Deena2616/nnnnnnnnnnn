import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum ElementType {
  heading, paragraph, button, list, video, card, icon, imageSlider, submitButton, nextButton, backButton, loginButton, image, logo, radioGroup, checkbox, bottomBar, cardRow2, cardRow3, appBar, textField
}

// Video Player Widget Implementation
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  
  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);
  
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  
  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }
  
  void _initializeVideo() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          _controller.play();
          _controller.setLooping(true);
        }
      });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: _isInitialized
          ? VideoPlayer(_controller)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

// Image Slider Widget Implementation
class ImageSliderWidget extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  
  const ImageSliderWidget({Key? key, required this.imageUrls, required this.height}) : super(key: key);
  
  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Center(child: Text('Error loading image')),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imageUrls.length, (index) => 
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Page Data
final Map<String, dynamic> pageData = {
  'name': 'Page 1',
  'backgroundColor': '#FFFFFF',
  'elements': [
    {
      'type': ElementType.textField,
      'text': '',
      'color': '#000000',
      'size': 20,
      'padding': {
        'left': 8,
        'top': 8,
        'right': 8,
        'bottom': 8,
      },
      'margin': {
        'left': 4,
        'top': 4,
        'right': 4,
        'bottom': 4,
      },
      'width': Infinity,
      'height': null,
      'listStyle': 'disc',
      'videoUrl': '',
      'imageUrls': [
      ],
      'icon': 'star',
      'bold': false,
      'italic': false,
      'underline': false,
      'backgroundColor': '#00000000',
      'borderRadius': 0,
      'borderWidth': 0,
      'borderColor': '#00000000',
      'alignment': 'left',
      'fontFamily': 'Poppins',
      'shadow': {
        'elevation': 0,
        'blurRadius': 0,
      },
      'opacity': 1,
      'textShadow': {
        'dx': 0,
        'dy': 0,
        'blurRadius': 0,
        'color': '#00000000',
      },
      'buttonStyle': null,
      'isSubmitButton': false,
      'fieldId': 'field_1756104821789',
      'label': 'Label',
      'hint': 'Enter text',
      'inputType': 'text',
    },
    {
      'type': ElementType.textField,
      'text': '',
      'color': '#000000',
      'size': 20,
      'padding': {
        'left': 8,
        'top': 8,
        'right': 8,
        'bottom': 8,
      },
      'margin': {
        'left': 4,
        'top': 4,
        'right': 4,
        'bottom': 4,
      },
      'width': Infinity,
      'height': null,
      'listStyle': 'disc',
      'videoUrl': '',
      'imageUrls': [
      ],
      'icon': 'star',
      'bold': false,
      'italic': false,
      'underline': false,
      'backgroundColor': '#00000000',
      'borderRadius': 0,
      'borderWidth': 0,
      'borderColor': '#00000000',
      'alignment': 'left',
      'fontFamily': 'Poppins',
      'shadow': {
        'elevation': 0,
        'blurRadius': 0,
      },
      'opacity': 1,
      'textShadow': {
        'dx': 0,
        'dy': 0,
        'blurRadius': 0,
        'color': '#00000000',
      },
      'buttonStyle': null,
      'isSubmitButton': false,
      'fieldId': 'field_1756104822870',
      'label': 'Label',
      'hint': 'Enter text',
      'inputType': 'password',
    },
    {
      'type': ElementType.submitButton,
      'text': 'Submit',
      'color': '#000000',
      'size': 20,
      'padding': {
        'left': 8,
        'top': 8,
        'right': 8,
        'bottom': 8,
      },
      'margin': {
        'left': 4,
        'top': 4,
        'right': 4,
        'bottom': 4,
      },
      'width': Infinity,
      'height': null,
      'listStyle': 'disc',
      'videoUrl': '',
      'imageUrls': [
      ],
      'icon': 'star',
      'bold': false,
      'italic': false,
      'underline': false,
      'backgroundColor': '#00000000',
      'borderRadius': 0,
      'borderWidth': 0,
      'borderColor': '#00000000',
      'alignment': 'left',
      'fontFamily': 'Poppins',
      'shadow': {
        'elevation': 0,
        'blurRadius': 0,
      },
      'opacity': 1,
      'textShadow': {
        'dx': 0,
        'dy': 0,
        'blurRadius': 0,
        'color': '#00000000',
      },
      'buttonStyle': 'filled',
      'isSubmitButton': true,
      'fieldId': null,
    },
  ]
};

class GeneratedPage extends StatefulWidget {
  const GeneratedPage({super.key});

  @override
  _GeneratedPageState createState() => _GeneratedPageState();
}

class _GeneratedPageState extends State<GeneratedPage> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    for (var el in pageData['elements']) {
      if (el['type'] == ElementType.textField) {
        _controllers[el['fieldId']] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitForm() async {
    final Map<String, dynamic> formData = {};
    for (var el in pageData['elements']) {
      if (el['type'] == ElementType.textField) {
        formData[el['label']] = _controllers[el['fieldId']]?.text ?? '';
      }
    }

    // Submit to backend
    try {
      final response = await http.post('
http://localhost:3000/submit-form',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFFF),
        child: ListView(
          children: [
            Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Container(
              margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0x00000000),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Opacity(
                opacity: 1,
                child: TextField(
                  controller: _controllers['field_1756104821789'],
                  decoration: InputDecoration(
                    labelText: 'Label',
                    hintText: 'Enter text',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ),

            Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Container(
              margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0x00000000),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Opacity(
                opacity: 1,
                child: TextField(
                  controller: _controllers['field_1756104822870'],
                  decoration: InputDecoration(
                    labelText: 'Label',
                    hintText: 'Enter text',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
              ),
            ),
          ),

            Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Container(
              margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0x00000000),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Opacity(
                opacity: 1,
                child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0x00000000),
                      foregroundColor: Color(0x000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.getFont(
  'Poppins',
  fontSize: 20,
  color: Color(0x000000),
)
,
                    ),
                  ),
              ),
            ),
          ),

          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const GeneratedPage(),
    );
  }
}
