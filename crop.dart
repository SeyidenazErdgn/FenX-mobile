import 'dart:io';
import 'package:image/image.dart';

void main() {
  final file = File('assets/images/FenXlogo2.png');
  if (!file.existsSync()) {
    print('File not found');
    return;
  }
  final image = decodeImage(file.readAsBytesSync());
  if (image == null) return;
  
  int minX = image.width;
  int minY = image.height;
  int maxX = 0;
  int maxY = 0;

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      bool isWhiteOrTransparent = (pixel.r > 240 && pixel.g > 240 && pixel.b > 240) || (pixel.a < 10);
      
      if (!isWhiteOrTransparent) {
        if (x < minX) minX = x;
        if (x > maxX) maxX = x;
        if (y < minY) minY = y;
        if (y > maxY) maxY = y;
      }
    }
  }

  if (minX <= maxX && minY <= maxY) {
    int padding = 50;
    minX = (minX - padding).clamp(0, image.width - 1);
    minY = (minY - padding).clamp(0, image.height - 1);
    maxX = (maxX + padding).clamp(0, image.width - 1);
    maxY = (maxY + padding).clamp(0, image.height - 1);

    int width = maxX - minX;
    int height = maxY - minY;
    
    // Kare oranında bir ikon yapmak 
    int size = width > height ? width : height;
    int diffX = size - width;
    int diffY = size - height;
    
    minX = (minX - diffX ~/ 2).clamp(0, image.width - 1);
    maxX = (minX + size).clamp(0, image.width - 1);
    minY = (minY - diffY ~/ 2).clamp(0, image.height - 1);
    maxY = (minY + size).clamp(0, image.height - 1);
    
    width = maxX - minX;
    height = maxY - minY;

    final cropped = copyCrop(image, x: minX, y: minY, width: width, height: height);
    File('assets/images/FenXlogo2_cropped.png').writeAsBytesSync(encodePng(cropped));
    print('Cropped successfully!');
  }
}
