class ShapeModel {
  int width;
  int height;
  int color;
  int posX; //bottomLeftX
  int posY; //bottomLeftY coordinates
  List<List> coordnts;

  ShapeModel({
    required this.width,
    required this.height,
    this.color = 1,
    this.posX = 0,
    this.posY = 0,
    required this.coordnts,
  });

  applyColor(int color) {
    for (int i = 0; i < coordnts.length; i++) {
      for (int j = 0; j < coordnts[i].length; j++) {
        if (coordnts[i][j] > 0) {
          coordnts[i][j] = color;
        }
      }
    }
  }

  rotate() {
    List<List<int>> newCoord = [];
    for (int i = 0; i < width; i++) {
      newCoord.add([]);
      for (int j = 0; j < height; j++) {
        newCoord[i].add(0);
      }
    }
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        if (coordnts[i][j] > 0) {
          newCoord[j][height - 1 - i] = coordnts[i][j];
        }
      }
    }
    int temp = width;
    width = height;
    height = temp;
    coordnts = newCoord;
  }
}
