import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/address_request_entity.dart';
import '../models/address_model.dart';
import '../models/address_request_model.dart';

// abstract class AddressRemoteDataSource {
//   Future<List<AddressModel>> getAddresses();
//   Future<AddressModel> addAddress(AddressRequestEntity address);
// }

// class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
//   final ApiService apiService;
//
//   AddressRemoteDataSourceImpl({required this.apiService});
//
//   @override
//   Future<List<AddressModel>> getAddresses() async {
//     try {
//       print('Calling API: ${ApiConstants.baseUrl}${ApiConstants.addressEndpoint}');
//       final response = await apiService.get(ApiConstants.addressEndpoint);
//       print('API Response for getAddresses: $response'); // Keep this for debugging
//
//       // --- IMPORTANT CHANGE HERE ---
//       final List<dynamic>? addressData = response['data'];
//
//       if (addressData == null) {
//         // If 'data' is null, assume it means no addresses found and return an empty list.
//         // This is a common pattern for APIs returning no results.
//         print('Address data is null in response, returning empty list.');
//         return [];
//       }
//
//       // If 'data' is not null, proceed to map it.
//       return addressData.map((json) => AddressModel.fromJson(json)).toList();
//     } on ServerException catch (e) {
//       print('ServerException during getAddresses: ${e.message}');
//       // Propagate original server failure messages if it's a true server error
//       throw e; // Re-throw the original exception to maintain context
//     } catch (e, stacktrace) {
//       print('Unexpected error during getAddresses: $e');
//       print('Stacktrace: $stacktrace');
//       // For any other unexpected errors, still treat as a server-side problem
//       throw ServerException('An unexpected error occurred while fetching addresses: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<AddressModel> addAddress(AddressRequestEntity address) async {
//     try {
//       final requestModel = AddressRequestModel(
//         title: address.title,
//         address: address.address,
//         contact: address.contact,
//         latitude: address.latitude,
//         longitude: address.longitude,
//         active: address.active,
//         tag: address.tag,
//       );
//
//       print('Sending to API: ${ApiConstants.baseUrl}${ApiConstants.addressEndpoint} with body: ${requestModel.toJson()}');
//       final response = await apiService.post(
//         ApiConstants.addressEndpoint,
//         body: requestModel.toJson(),
//       );
//       print('API Response for addAddress: $response'); // Keep this for debugging
//
//       final dynamic responseData = response['data'];
//       if (responseData == null) {
//         // If addAddress returns null for 'data' on success, it might indicate
//         // a different problem or an empty success response.
//         // For now, if the API truly returns null for data on success of adding,
//         // you might need to adjust how your bloc handles the returned AddressEntity.
//         // For typical "add" operations, a non-null data object representing the added item is expected.
//         // If your API returns null here, you might need to re-fetch the list,
//         // or ensure the API returns the created address object.
//         print('Added address data is null or missing in response for ADD address.');
//         // For robust handling, you might consider throwing an exception here if a
//         // successful add *must* return the data.
//         throw ServerException('Failed to add address: Server did not return the added address data.');
//       }
//       return AddressModel.fromJson(responseData);
//     } on ServerException catch (e) {
//       print('ServerException during addAddress: ${e.message}');
//       throw e;
//     } catch (e, stacktrace) {
//       print('Unexpected error during addAddress: $e');
//       print('Stacktrace: $stacktrace');
//       throw ServerException('An unexpected error occurred while adding address: ${e.toString()}');
//     }
//   }
// }
// components/address/data/datasources/address_remote_data_source.dart

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses(); // Abstract method declaration
  Future<AddressModel> addAddress(AddressRequestEntity address);
  Future<void> deleteAddress(String id); // --- TAMBAHKAN INI ---
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final ApiService apiService;

  AddressRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      print('Calling API: ${ApiConstants.baseUrl}${ApiConstants.addressEndpoint}');
      final response = await apiService.get(ApiConstants.addressEndpoint);
      print('API Response for getAddresses: $response');

      final List<dynamic>? addressData = response['data'];

      if (addressData == null) {
        // If 'data' is null, assume it means no addresses found and return an empty list.
        print('Address data is null in response, returning empty list.');
        return [];
      }

      // If 'data' is not null, proceed to map it.
      return addressData.map((json) => AddressModel.fromJson(json)).toList();
    } on ServerException catch (e) {
      print('ServerException during getAddresses: ${e.message}');
      throw e;
    } catch (e, stacktrace) {
      print('Unexpected error during getAddresses: $e');
      print('Stacktrace: $stacktrace');
      throw ServerException('An unexpected error occurred while fetching addresses: ${e.toString()}');
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

      print('Sending to API: ${ApiConstants.baseUrl}${ApiConstants.addressEndpoint} with body: ${requestModel.toJson()}');
      final response = await apiService.post(
        ApiConstants.addressEndpoint,
        body: requestModel.toJson(),
      );
      print('API Response for addAddress: $response');

      final dynamic responseData = response['data'];

      if (responseData == null) {
        print('Warning: Add Address API did not return specific data. Returning a placeholder.');
        return AddressModel(
          id: 'temp_placeholder_id_${DateTime.now().millisecondsSinceEpoch}',
          title: address.title,
          address: address.address,
          contact: address.contact,
          latitude: address.latitude,
          longitudes: address.longitude,
          active: address.active,
          tag: address.tag ?? '',
        );
      } else {
        return AddressModel.fromJson(responseData);
      }
    } on ServerException catch (e) {
      print('ServerException during addAddress: ${e.message}');
      rethrow;
    } catch (e, stacktrace) {
      print('Unexpected error during addAddress: $e');
      print('Stacktrace: $stacktrace');
      throw ServerException('An unexpected error occurred while adding address: ${e.toString()}');
    }
  }
  @override
  Future<void> deleteAddress(String id) async { // --- TAMBAHKAN IMPLEMENTASI INI ---
    try {
      await apiService.delete('${ApiConstants.addressEndpoint}/$id');
      // Tidak perlu mengembalikan data karena ini operasi delete
    } on ServerException catch (e) {
      print('ServerException during deleteAddress: ${e.message}');
      throw e;
    } catch (e, stacktrace) {
      print('Unexpected error during deleteAddress: $e');
      print('Stacktrace: $stacktrace');
      throw ServerException('An unexpected error occurred while deleting address: ${e.toString()}');
    }
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