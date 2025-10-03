import 'package:gaia_nutrition_plans/features/user_feature/data_layer/data_sources/remote_data_sources/abstract_remote_data_sources/user_abstract_remote_data_source.dart';
import 'package:gaia_nutrition_plans/features/user_feature/data_layer/mappers/remote_mappers/supabase_mappers/user_supabase_mapper.dart';
import 'package:gaia_nutrition_plans/features/user_feature/data_layer/models/remote_models/supabase_models/user_supabase_model.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSupabaseDataSource implements UserAbstractRemoteDataSources {
  final SupabaseClient supabaseClient;
  final Client httpClient;
  UserSupabaseDataSource({
    required this.supabaseClient,
    required this.httpClient,
  });

  @override
  Future<void> changePassword() async {
    final User? user = supabaseClient.auth.currentUser;
    await supabaseClient.auth.resetPasswordForEmail(user!.email!);
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await supabaseClient.functions.invoke(
        'delete-account',
        body: {'userId': supabaseClient.auth.currentUser!.id},
      );
    } catch (e) {
      throw Exception('Error deleting account: $e');
    }
  }

  @override
  Future<String?> getClientSecret() async {
    const int amount = 1000;
    const String currency = 'usd';
    final String userId = supabaseClient.auth.currentUser!.id;

    final response = await supabaseClient.functions.invoke(
      'create-payment-intent',
      body: {'amount': amount, 'currency': currency, 'user_id': userId},
    );
    if (response.status == 200) {
      final data = response.data;
      if (data != null && data['client_secret'] != null) {
        return data['client_secret'] as String;
      } else {
        throw Exception('client_secret not found in response: $data');
      }
    } else {
      throw Exception('Failed to create payment intent: ${response.data}');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    final response = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user!.id)
        .single();
    final model = UserSupabaseModel.fromSupabase(response);
    return UserSupabaseMapper.toEntity(model);
  }

  @override
  String getCurrentUserId() {
    return supabaseClient.auth.currentUser?.id ?? '';
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    final response = await supabaseClient
        .from('users')
        .select()
        .eq('id', userId)
        .single();
    final model = UserSupabaseModel.fromSupabase(response);
    return UserSupabaseMapper.toEntity(model);
  }

  @override
  bool isUserLoggedIn() {
    return supabaseClient.auth.currentUser != null;
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Future<void> register({
    required UserEntity userEntity,
    required String password,
  }) async {
    final UserSupabaseModel u = UserSupabaseMapper.fromEntity(userEntity);
    await supabaseClient.auth.signUp(
      email: userEntity.email,
      password: password,
      emailRedirectTo: 'https://example.com',
      data: u.toMap(),
    );
  }

  @override
  Future<void> updateProfile(UserEntity userEntity) async {
    final user = supabaseClient.auth.currentUser;
    final model = UserSupabaseMapper.fromEntity(userEntity);
    await supabaseClient.from('users').update(model.toMap()).eq('id', user!.id);
  }

  @override
  Future<bool?> isUserSubscribed() async {
    final user = supabaseClient.auth.currentUser;
    final response = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user!.id)
        .single();
    final DateTime subscriptionExpiry = DateTime.parse(
      response['subscription_expiry'],
    );
    final bool isSubscribed = subscriptionExpiry.isAfter(DateTime.now());
    return isSubscribed;
  }
}
