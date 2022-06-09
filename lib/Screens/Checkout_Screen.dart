import 'package:bigcart_ecommerce_app/Providers/order_provider.dart';
import 'package:bigcart_ecommerce_app/Providers/user_provider.dart';
import 'package:bigcart_ecommerce_app/Screens/OrderSuccess_Screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/OrderModel.dart';
import '../Providers/cart_provider.dart';
import '../Utility/Validator.dart';
import '../Widgets/RaisedGradientButton.dart';
import '../Widgets/custom_textfield.dart';

class Checkout_Screen extends StatefulWidget {
  const Checkout_Screen({Key? key}) : super(key: key);

  @override
  State<Checkout_Screen> createState() => _Checkout_ScreenState();
}

class _Checkout_ScreenState extends State<Checkout_Screen> {
  final checkoutfromkey = GlobalKey<FormState>();
  String? _name, _email, _phonenumber, _address, _zipcode, _city, _country;
  bool isLoading = false;
  final List<String> _countrysList = [
    'Pakistan',
    'Turkey',
    'SaudiArabia',
    'Qatar'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F9),
      appBar: AppBar(
        leading: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => onback(context),
                child: const Icon(Icons.west, color: Colors.black))),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Checkout"),
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: checkoutfromkey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.042),
              custom_textfield(
                inputDecoration: const InputDecoration(
                    prefixIcon: Image(
                        image: AssetImage('assets/images/person_icon.png'),
                        height: 24,
                        width: 24),
                    hintText: "Name",
                    hintStyle: TextStyle(
                        color: Color(0xFF868889),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5),
                    border: InputBorder.none),
                txtfield_padding: 5,
                txt_input_type: TextInputType.name,
                fieldValidator: (value) =>
                    validateRequiredFields(value: value, fieldName: "Name"),
                onsaved: (newValue) => _name = newValue,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              custom_textfield(
                  inputDecoration: const InputDecoration(
                      prefixIcon: Image(
                          image: AssetImage('assets/images/email_icon.png'),
                          height: 24,
                          width: 24),
                      hintText: "Email address",
                      hintStyle: TextStyle(
                          color: Color(0xFF868889),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5),
                      border: InputBorder.none),
                  txtfield_padding: 5,
                  txt_input_type: TextInputType.emailAddress,
                  fieldValidator: (value) => validateEmail(value),
                  onsaved: (newValue) => _email = newValue),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              custom_textfield(
                inputDecoration: const InputDecoration(
                    prefixIcon: Image(
                        image: AssetImage('assets/images/telephone_icon.png'),
                        height: 24,
                        width: 24),
                    hintText: "Phone number",
                    hintStyle: TextStyle(
                        color: Color(0xFF868889),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5),
                    border: InputBorder.none),
                txtfield_padding: 5,
                txt_input_type: TextInputType.phone,
                fieldValidator: (value) => validatePhoneNumber(value),
                onsaved: (newValue) => _phonenumber = newValue,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              custom_textfield(
                  inputDecoration: const InputDecoration(
                      prefixIcon: Image(
                          image: AssetImage('assets/images/location_icon.png'),
                          height: 24,
                          width: 24),
                      hintText: "Address",
                      hintStyle: TextStyle(
                          color: Color(0xFF868889),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5),
                      border: InputBorder.none),
                  txtfield_padding: 5,
                  txt_input_type: TextInputType.multiline,
                  fieldValidator: (value) => validateRequiredFields(
                      value: value, fieldName: "Address"),
                  onsaved: (newValue) => _address = newValue),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              custom_textfield(
                  inputDecoration: const InputDecoration(
                      prefixIcon: Image(
                          image: AssetImage('assets/images/zipcode_icon.png'),
                          height: 24,
                          width: 24),
                      hintText: "Zip code",
                      hintStyle: TextStyle(
                          color: Color(0xFF868889),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5),
                      border: InputBorder.none),
                  txtfield_padding: 5,
                  txt_input_type: TextInputType.number,
                  fieldValidator: (value) => validateRequiredFields(
                      value: value, fieldName: "Zip code"),
                  onsaved: (newValue) => _zipcode = newValue),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              custom_textfield(
                  inputDecoration: const InputDecoration(
                      prefixIcon: Image(
                          image: AssetImage('assets/images/map_icon.png'),
                          height: 24,
                          width: 24),
                      hintText: "City",
                      hintStyle: TextStyle(
                          color: Color(0xFF868889),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5),
                      border: InputBorder.none),
                  txtfield_padding: 5,
                  txt_input_type: TextInputType.text,
                  fieldValidator: (value) =>
                      validateRequiredFields(value: value, fieldName: "City"),
                  onsaved: (newValue) => _city = newValue),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                margin: const EdgeInsets.only(left: 17, right: 17),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonFormField2(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Image(
                        image: AssetImage('assets/images/world_icon.png'),
                        height: 24,
                        width: 24),
                  ),
                  hint: const Text(
                    'Select Your Country',
                    style: TextStyle(
                        color: Color(0xFF868889),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF868889),
                  ),
                  iconSize: 30,
                  buttonHeight: 40,
                  buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  items: _countrysList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                      .toList(),
                  validator: (value) => validateDropDownField(value.toString()),
                  onChanged: (value) {},
                  onSaved: (value) => _country = value.toString(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).primaryColorDark)
                  : RaisedGradientButton(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin_left: 17,
                      margin_right: 17,
                      child: const Text("Next",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1)),
                      gradient: const LinearGradient(
                        colors: <Color>[Color(0xffAEDC81), Color(0xff6CC51D)],
                      ),
                      onPressed: () => onNextPress(context),
                    )
            ],
          ),
        ),
      ),
    );
  }

  onback(BuildContext context) {
    Navigator.of(context).pop();
  }

  onNextPress(BuildContext context) {
    final form = checkoutfromkey.currentState!;
    Cart_Provider cartProvider =
        Provider.of<Cart_Provider>(context, listen: false);
    User_Provider userProvider =
        Provider.of<User_Provider>(context, listen: false);
    Order_Provider orderProvider =
        Provider.of<Order_Provider>(context, listen: false);
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      List<Items> item = [];
      cartProvider.cartProductList
          .where((element) => element.qty > 0)
          .forEach((element) {
        item.add(Items(
            id: element.productId,
            catId: element.categoryId,
            color: element.color,
            image: element.image,
            title: element.title,
            price: element.price,
            qty: element.qty,
            stockAvailable: element.stock,
            unit: element.unit));
      });
      OrderModel orderModel = OrderModel(
          name: _name,
          email: _email,
          address: _address,
          city: _city,
          country: _country,
          phoneNumber: _phonenumber,
          zip: _zipcode,
          items: item);
      print(orderModel.items);

      final Future<Map<String, dynamic>> orderResponse =
          orderProvider.placeOrder(
              accessToken: userProvider.userModel.accessToken!,
              orderModel: orderModel);

      orderResponse.then((value) {
        if (value['IsOrderPlaced']) {
          form.reset();
          //item.forEach((element)=>cartProvider.removeProduct(element.id!));
          item.forEach((element) {
            int index = cartProvider.getItemIndex(element.id!);
            cartProvider.cartProductList[index].qty = 0;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value['Message'])));
          Future.delayed(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const OrderSuccess_Screen())));
          setState(() {
            isLoading = false;
          });
        } else if (value['IsOrderPlaced'] == false) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value['Message'])));
          setState(() {
            isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value['Message'])));
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }
  /* Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderSuccess_Screen()));*/
}
