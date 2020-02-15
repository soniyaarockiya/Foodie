class ItemModel {
  String itemName;
  String itemPrice;
  String itemImage;
  String itemStatus;
  String address;
  String userID;
  String orderId;

  ItemModel();

  ItemModel.items({this.itemName, this.itemPrice, this.itemImage});

  ItemModel.status({this.itemName,
    this.itemPrice,
    this.itemImage,
    this.itemStatus,
    this.address,
    this.userID,
    this.orderId});
}
