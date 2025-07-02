import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/address_request_entity.dart';
import '../models/address_model.dart';
import '../models/address_request_model.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> addAddress(AddressRequestEntity address);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final ApiService apiService;

  AddressRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await apiService.get(ApiConstants.addressEndpoint);
      final List<dynamic> addressData = response['data'];
      return addressData.map((json) => AddressModel.fromJson(json)).toList();
    } on ServerException {
      throw ServerException('Failed to get addresses');
    }
  }

  @override
  Future<AddressModel> addAddress(AddressRequestEntity address) async {
    try {
      final requestModel = AddressRequestModel(
        title: address.title,
        address: address.address,
        contact: address.contact,
        latitude: address.latitude,
        longitude: address.longitude,
        active: address.active,
        tag: address.tag,
      );

      final response = await apiService.post(
        ApiConstants.addressEndpoint,
        body: requestModel.toJson(),
      );

      return AddressModel.fromJson(response['data']);
    } on ServerException {
      throw ServerException('Failed to add address');
    }
  }

  // @override
  // Future<AddressModel> addAddress(AddressRequestEntity address) async {
  //   try {
  //     final response = await apiService.post(
  //       ApiConstants.addressEndpoint,
  //       body: AddressRequestModel.fromEntity(address).toJson(),
  //     );
  //
  //     // Add null checks
  //     if (response == null) {
  //       throw ServerException('Server returned null response');
  //     }
  //
  //     if (response['data'] == null) {
  //       throw ServerException('No data in server response');
  //     }
  //
  //     return AddressModel.fromJson(response['data'] as Map<String, dynamic>);
  //   } on ServerException {
  //     rethrow;
  //   } catch (e) {
  //     throw ServerException('Failed to parse server response: $e');
  //   }
  // }
}