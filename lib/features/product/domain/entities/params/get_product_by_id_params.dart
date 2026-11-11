
class GetProductByIdParams{
  int productId;

  GetProductByIdParams({
    required this.productId,
  });

  static GetProductByIdParams get sample{
    return GetProductByIdParams(productId: 1);
  }

  Map<String,dynamic> toJson(){
    return {
      "product_id" : productId
    };
  }
}