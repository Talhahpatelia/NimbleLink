class Orders {
  String typeOfProduct = '';
  String dateNeededBy = '';
  String dateCurrently = '';
  int quantityOfProduct = 0;
  int donationsRand = 0;
  String productPosasion = '';
  String productId = '';

  Orders(
      {this.typeOfProduct,
      this.dateNeededBy,
      this.dateCurrently,
      this.quantityOfProduct,
      this.donationsRand,
      this.productPosasion,
      this.productId
      });
}
