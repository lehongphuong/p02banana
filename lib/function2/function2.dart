import 'dart:io';
// import 'package:flutter_html/flutter_html.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Function2Page extends StatefulWidget {
  Function2Page({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _Function2PageState createState() => _Function2PageState();
}

class _Function2PageState extends State<Function2Page> {
  File? _image;
  final picker = ImagePicker();
  Image? _imageWidget;
  img.Image? fox;
  int index = 57;
  var recognitions;

  List<String> bananaResults = [
    'không bọc cùi bảo quản ở 6°C, độ ẩm 53%;21.64;1.05;1.92;0.19;5 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;25.06;0.8;1.9;0.21;5 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;22.45;0.8;1.92;0.22;14 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;22.17;1;1.95;0.19;14 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;24.8;1;1.93;0.19;14 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;24.47;1;1.92;0.2;14 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;25.73;1;1.94;0.19;14 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;26.85;1;1.92;0.19;14 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 6°C, độ ẩm 53%;22.36;2.5;1.95;0.22;3 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;25.04;3;1.92;0.22;3 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;22.74;2.5;1.94;0.19;12 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;23.42;2.5;2.06;0.22;12 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;25.59;2.5;2;0.23;12 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;25.17;2;1.93;0.18;12 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;24.11;44318;1.71;0.21;12 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;24.55;3;1.82;0.21;12 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 6°C độ ẩm 53%;21.81;5.2;1.87;0.27;1 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;26.71;5;1.81;0.24;1 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;21.05;5;1.85;0.25;10 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;24.32;5;1.96;0.29;10 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;25.98;5.5;1.98;0.27;10 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;24.53;4;1.64;0.32;10 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;23.87;6;1.66;0.36;10 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;23.91;5.7;1.72;0.35;10 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 6°C, độ ẩm 53%;22.56;6;1.81;0.38;0 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;26.11;6;1.73;0.38;0 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;21.1;6;1.87;0.42;8 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;23.77;6;1.73;0.48;8 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;23.75;7.3;1.32;0.51;8 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;24.76;6;1.69;0.51;8 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;22.84;14;1.32;0.64;8 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;23.06;10;1.41;0.64;8 ngày;Có thể giúp ngăn ngừa hoặc làm chậm quá trình “scurvy xương”, gây yếu xương. Hàm lượng tanin cao giúp kháng viêm, hạ huyết áp, ngừa ung thư dạ dạy. Có khả năng điều trị tiêu chảy. Cung cấp nhiều khoáng chất giúp khoẻ xương',
    'không bọc cùi bảo quản ở 6°C, độ ẩm 53%;21.22;4.5;1.35;0.48;0 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;25.23;4;1.62;0.4;0 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;21.21;4;0.85;0.47;6 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;23.89;5;0.85;0.54;6 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;16.01;11;0.42;0.7;6 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;21.25;5.5;0.69;0.51;6 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;14.12;19;0.9;0.7;6 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;15.48;14;0.9;0.64;6 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 6°C, độ ẩm 53%;21.88;3.5;1.35;0.45;0 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;24.22;3;1.38;0.44;0 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;21.08;4;0.21;0.54;4 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;17.37;7;0.21;0.6;4 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;15.2;13.5;0.48;0.67;4 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;16.16;10;0.48;0.85;4 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;10.94;14.5;0.28;0.62;4 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;14.01;17;0.21;0.61;4 ngày;Giàu tinh bột, giúp phòng tránh và hỗ trợ điều trị tiểu đường, cải thiện độ nhạy cảm insulin. Hỗ trợ quá trình giảm cân (tăng cảm giác no). Dễ gây đầy hơi, nặng bụng.',
    'không bọc cùi bảo quản ở 6°C, độ ẩm 53%;22.81;3;1.28;0.45;0 ngày;Tăng lượng đường nên người tiểu đường không nên dùng. Hỗ trợ quá trình tiêu hoá, giúp ruột hấp thu dinh dưỡng nhanh hơn. Nâng cao tâm trạng và duy trì sự cân bằng tâmtrangj lành mạnh',
    'bọc cùi bảo quản ở 6°C, độ ẩm 53%;25.93;2.8;1.24;0.45;0 ngày;Tăng lượng đường nên người tiểu đường không nên dùng. Hỗ trợ quá trình tiêu hoá, giúp ruột hấp thu dinh dưỡng nhanh hơn. Nâng cao tâm trạng và duy trì sự cân bằng tâmtrangj lành mạnh',
    'không bọc cùi bảo quản ở 15°C, độ ẩm 58%;19.73;5;0.07;0.62;2 ngày;Tăng lượng đường nên người tiểu đường không nên dùng. Hỗ trợ quá trình tiêu hoá, giúp ruột hấp thu dinh dưỡng nhanh hơn. Nâng cao tâm trạng và duy trì sự cân bằng tâmtrangj lành mạnh',
    'bọc cùi bảo quản ở 15°C, độ ẩm 58%;16.13;10;0.21;0.83;2 ngày;Tăng lượng đường nên người tiểu đường không nên dùng. Hỗ trợ quá trình tiêu hoá, giúp ruột hấp thu dinh dưỡng nhanh hơn. Nâng cao tâm trạng và duy trì sự cân bằng tâmtrangj lành mạnh',
    'không bọc cùi bảo quản ở 28°C, độ ẩm 82%;14.72;13;0;0.7;2 ngày;Tăng năng lượng, tăng lượng đường nên người tiểu đường không nên dùng, Chất chống ôxi hoá tăng giúp tăng hệ thống miễn dịch, Ngăn chặn tổn thương té bào, Ngừa thiếu máu.',
    'bọc cùi bảo quản ở 28°C, độ ẩm 82%;16.07;9.5;0;0.9;2 ngày;Tăng năng lượng, tăng lượng đường nên người tiểu đường không nên dùng, Chất chống ôxi hoá tăng giúp tăng hệ thống miễn dịch, Ngăn chặn tổn thương té bào, Ngừa thiếu máu.',
    'không bọc cùi bảo quản ở 38°C, độ ẩm 75%;10.57;15.5;0;0.86;2 ngày;Tăng năng lượng, tăng lượng đường nên người tiểu đường không nên dùng, Chất chống ôxi hoá tăng giúp tăng hệ thống miễn dịch, Ngăn chặn tổn thương té bào, Ngừa thiếu máu.',
    'bọc cùi bảo quản ở 38°C, độ ẩm 75%;11.16;15.5;0;0.7;2 ngày;Tăng năng lượng, tăng lượng đường nên người tiểu đường không nên dùng, Chất chống ôxi hoá tăng giúp tăng hệ thống miễn dịch, Ngăn chặn tổn thương té bào, Ngừa thiếu máu.',
    'Không tìm thấy kết quả',
    '',
  ];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    await Tflite.loadModel(
            model: "assets/function2_quantized.tflite",
            labels: "assets/function2_labels.txt",
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
    print('dang du doan');
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
      index = 56;
      if (recognitions!.length > 0) {
        index = recognitions[0]['index'];
      }
    });

    print('phuong ${recognitions}');
    print('phuong ${index}');
    print('phuong ${bananaResults[index]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Phân Tích Thành Phần', style: TextStyle(color: Colors.white)),
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
                index < 56
                    ? 'Độ chính xác: ${(double.parse(recognitions[0]['confidence'].toString()) * 100).toStringAsFixed(2)}%'
                    : '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              // hiển thị kết quả
              index < 56
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // phuong phap bao quan
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.ac_unit),
                              ),
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[0],
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Hàm lượng tinh bột
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('Hàm lượng tinh bột',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[1] + '%',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Chất khô hòa tan
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('Chất khô hòa tan',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[2] + '%',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tanin
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('Tanin',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[3] + '%',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Axit hưu cơ
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('Axit hưu cơ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[4] + '%',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Thời hạn bảo quản còn lại
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('Thời hạn bảo quản còn lại',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[5],
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Khuyên dùng
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('Khuyên dùng',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                        // Khuyên dùng
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  bananaResults[index].split(';')[6],
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Text('')
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
