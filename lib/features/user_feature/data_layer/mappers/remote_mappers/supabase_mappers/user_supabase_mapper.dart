import 'package:gaia_nutrition_plans/features/user_feature/data_layer/models/remote_models/supabase_models/user_supabase_model.dart';
import 'package:gaia_nutrition_plans/features/user_feature/domain_layer/entities/user_entity.dart';

class UserSupabaseMapper {
  /// تحويل من Entity إلى SupabaseModel
  static UserSupabaseModel fromEntity(UserEntity entity) {
    return UserSupabaseModel(
      id: entity.id,
      firstName: entity.firstName,
      secondName: entity.secondName,
      birthday: entity.birthday,
      weight: entity.weight,
      height: entity.height,
      gender: entity.gender,
      email: entity.email,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// تحويل من SupabaseModel إلى Entity
  static UserEntity toEntity(UserSupabaseModel model) {
    return UserEntity(
      id: model.id,
      firstName: model.firstName,
      secondName: model.secondName,
      birthday: model.birthday,
      weight: model.weight,
      height: model.height,
      gender: model.gender,
      email: model.email,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
