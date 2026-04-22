import 'dart:io';
import 'package:image/image.dart';

void main() {
  final file = File('assets/images/logo_final.png');
  if (!file.existsSync()) { 
    print('File not found'); 
    return; 
  }
  final original = decodeImage(file.readAsBytesSync());
  if (original == null) return;
  
  // 1. Resmin en altındaki o istenmeyen "FenX" yazısını yok etmek için
  // resmin alttan %16'lık kısmını tamamen kesip atıyoruz (Kitap kısmı korunur).
  int cropHeight = (original.height * 0.84).toInt();
  final cropped = copyCrop(original, x: 0, y: 0, width: original.width, height: cropHeight);
  
  // 2. Resmin sahip olduğu mor arka plan rengini (sağ üst köşeden) alıyoruz.
  final bgColor = original.getPixel(original.width - 1, 0);

  // 3. Adaptive Icon maskesinin kitabın kenarlarını yememesi (Sticker gibi durması) için
  // resmin etrafına %40 oranında kendi renginden kocaman bir tampon bölge (Padding) ekliyoruz.
  int padX = (cropped.width * 0.15).toInt();
  int padY = (cropped.height * 0.15).toInt();
  int newWidth = cropped.width + padX * 2;
  int newHeight = cropped.height + padY * 2;
  
  Image newImage = Image(width: newWidth, height: newHeight);
  
  for (int y = 0; y < newHeight; y++) {
    for (int x = 0; x < newWidth; x++) {
      newImage.setPixel(x, y, bgColor);
    }
  }
  
  // Kitabı tam ortaya yerleştiriyoruz.
  compositeImage(newImage, cropped, dstX: padX, dstY: padY);
  
  // 4. İkonun kusursuz ölçeklenmesi için kare bir tuvale oturtuyoruz.
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
  
  File('assets/images/logo_final_perfect.png').writeAsBytesSync(encodePng(squareImage));
  print('Fixed successfully');
}
