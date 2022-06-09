class api_urls{
  static const String baseUrl = 'http://ishaqhassan.com:2000';
  static const String signin = baseUrl + '/user/signin';
  static const String signup = baseUrl + '/user';
  static const String signout = baseUrl + '/user/signout';

  static const String getallcategories = baseUrl + '/category';
  static const String getcategorybyid = baseUrl + '/category/';

  static const String getallproducts = baseUrl + '/product';
  static const String getallproductsbycategoryid = baseUrl + '/product/';
  static const String getproductbytitle = baseUrl + '/product/search?q=';

  static const String getallorders = baseUrl + '/order';
  static const String getorderbyid = baseUrl + '/order/';
  static const String getordersofcurrentuser = baseUrl + '/order/';
  static const String createorder = baseUrl + '/order';
  static const String deleteorderbyid = baseUrl + '/order/';

}