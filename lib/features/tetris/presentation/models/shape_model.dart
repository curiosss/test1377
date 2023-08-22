class ShapeModel {
  final int width;
  final int height;
  final int color;
  int posX; //bottomLeftX
  int posY; //bottomLeftY coordinates
  final List<List> coordnts;

  ShapeModel({
    required this.width,
    required this.height,
    this.color = 1,
    this.posX = 0,
    this.posY = 0,
    required this.coordnts,
  });
}
