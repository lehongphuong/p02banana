import 'dart:io';
import 'package:flutter_html/flutter_html.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'function1_results_map.dart';

class Function1Page extends StatefulWidget {
  Function1Page({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Function1PageState createState() => _Function1PageState();
}

class _Function1PageState extends State<Function1Page> {
  File? _image;
  final picker = ImagePicker();
  Image? _imageWidget;
  img.Image? fox;
  int index = 12;
  var recognitions;

  List<String> bananaName = [
    'Chuối bơm',
    'Chuối cau',
    'Chuối hột',
    'Chuối laba',
    'Chuối lùn',
    'Chuối già Nam Mỹ (Cavendish)',
    'Chuối ngự',
    'Chuối sứ',
    'Chuối táo quạ',
    'Chuối thanh tiêu Huế',
    'Chuối tiêu hồng',
    'Không tìm thấy',
    '',
  ];

  List<String> bananaDetail = [
    Function1ResultMap.chuoi_bom,
    Function1ResultMap.chuoi_cau,
    Function1ResultMap.chuoi_hot,
    Function1ResultMap.chuoi_laba,
    Function1ResultMap.chuoi_lun,
    Function1ResultMap.chuoi_gia_nam_my,
    Function1ResultMap.chuoi_ngu,
    Function1ResultMap.chuoi_su,
    Function1ResultMap.chuoi_tao_qua,
    Function1ResultMap.chuoi_thanh_tieu_hue,
    Function1ResultMap.chuoi_tieu_hong,
    '<h1>Không tìm thấy</h1>',
    '',
  ];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    await Tflite.loadModel(
            model: "assets/function1_quantized.tflite",
            labels: "assets/function1_labels.txt",
            numThreads: 1, // defaults to 1
            isAsset:
                true, // defaults to true, set to false to load resources outside assets
            useGpuDelegate:
                false // defaults to false, set to true to use GPU delegate
            )
        .then((value) {});
  }

  Future getImage() async {
    // final pickedFile = await picker.getImage(source: ImageSource.camera);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);
    });

    // dự đoán
    _predict();
  }

  void _predict() async {
    var temp = await Tflite.runModelOnImage(
        path: _image!.path, // required
        imageMean: 127.5, // defaults to 117.0
        imageStd: 127.5, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.5, // defaults to 0.1
        asynch: true // defaults to true
        );

    setState(() {
      recognitions = temp;
      index = 11;
      if (recognitions!.length > 0) {
        index = recognitions[0]['index'];
      }
    });

    print('phuong ${recognitions}');
    print('phuong ${index}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phân Loại Chuối', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            children: <Widget>[
              Center(
                child: _image == null
                    ? Text('Vui lòng chọn hình.')
                    : GestureDetector(
                        onTap: getImage,
                        child: Container(
                          constraints: BoxConstraints(
                              // minHeight: MediaQuery.of(context).size.height / 3,
                              maxHeight:
                                  MediaQuery.of(context).size.height / 2),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: _imageWidget,
                        ),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                bananaName[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                index < 11
                    ? 'Độ chính xác: ${(double.parse(recognitions[0]['confidence'].toString()) * 100).toStringAsFixed(2)}%'
                    : '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Html(
                      data: bananaDetail[index],
                      style: {
                        "table": Style(
                          backgroundColor:
                              Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        "tr": Style(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey)),
                        ),
                        "th": Style(
                          padding: EdgeInsets.all(6),
                          backgroundColor: Colors.grey,
                        ),
                        "td": Style(
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.topLeft,
                        ),
                        'h5': Style(
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis),
                      },
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
