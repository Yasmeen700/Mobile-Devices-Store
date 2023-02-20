import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:meta_gate_test/constants/end_point.dart';
import 'package:meta_gate_test/presenters/presenter.dart';

void main() {

  test('DeviceController calculateNewPrice test', () async {
    final deviceController = DevicesController();

    var price = deviceController.calculateNewPrice(null, 30);
    expect(price, 0);

    var price1 = deviceController.calculateNewPrice(3000, null);
    expect(price1, 3000);

    var price2 = deviceController.calculateNewPrice(1000, 30);
    expect(price2, 700);
  });

  test('get product endpoint test', () async {
    Response response = await get(Uri.parse(EndPoints.getAllProducts));

    expect(response.statusCode, 200);
  });

  test('get product search result endpoint test', () async {
    Response response = await get(Uri.parse(EndPoints.searchForProducts+'Phone'));

    expect(response.statusCode, 200);
  });
}
