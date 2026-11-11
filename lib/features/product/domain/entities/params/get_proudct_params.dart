
class GetProductParams{
  int page;

  GetProductParams({
    required this.page,
  });

  static GetProductParams get sample{
    return GetProductParams(page: 1);
  }

  Map<String,dynamic> toJson(){
    return {
      "page" : page
    };
  }
}