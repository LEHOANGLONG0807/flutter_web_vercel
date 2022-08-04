

extension ImagesExtension on String {
  String get assetImagePath => 'assets/images/$this';
  String get assetImagesPathPNG => 'assets/images/$this.png';
}
