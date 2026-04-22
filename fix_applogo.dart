import 'dart:io';
import 'package:image/image.dart';

void main() {
  final file = File('assets/images/FenX_applogo.png');
  if (!file.existsSync()) { 
    print('File not found'); 
    return; 
  }
  final original = decodeImage(file.readAsBytesSync());
  if (original == null) return;
  
  // Crop bottom 16% to remove FenX text
  int cropHeight = (original.height * 0.84).toInt();
  final cropped = copyCrop(original, x: 0, y: 0, width: original.width, height: cropHeight);
  
  final bgColor = original.getPixel(original.width - 1, 0);

  // Add 25% pad to make it a sticker without being too tiny, keeping the book fully in the circle
  int padX = (cropped.width * 0.25).toInt();
  int padY = (cropped.height * 0.25).toInt();
  int newWidth = cropped.width + padX * 2;
  int newHeight = cropped.height + padY * 2;
  
  Image newImage = Image(width: newWidth, height: newHeight);
  
  for (int y = 0; y < newHeight; y++) {
    for (int x = 0; x < newWidth; x++) {
      newImage.setPixel(x, y, bgColor);
    }
  }
  
  compositeImage(newImage, cropped, dstX: padX, dstY: padY);
  
  int size = newWidth > newHeight ? newWidth : newHeight;
  Image squareImage = Image(width: size, height: size);
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      squareImage.setPixel(x, y, bgColor);
    }
  }
  
  int startX = (size - newWidth) ~/ 2;
  int startY = (size - newHeight) ~/ 2;
  compositeImage(squareImage, newImage, dstX: startX, dstY: startY);
  
  File('assets/images/FenX_applogo_perfect.png').writeAsBytesSync(encodePng(squareImage));
  print('App logo fixed successfully');
}
