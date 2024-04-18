class Category {
  String thumbnail;
  String name;
  //int noOfCourses;

  Category({
    required this.name,
    //required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Rent Tools',
    //noOfCourses: 55,
    thumbnail: 'assets/icons/Tools.jpg',
  ),
  Category(
    name: 'Sell Crops',
    // noOfCourses: 20,
    thumbnail: 'assets/icons/crop.jpg',
  ),
  Category(
    name: 'Disease Detection',
    // noOfCourses: 16,
    thumbnail: 'assets/icons/disease.jpg',
  ),
  Category(
    name: 'Crop Recommendation',
    // noOfCourses: 25,
    thumbnail: 'assets/icons/design.jpg',
  ),
];
