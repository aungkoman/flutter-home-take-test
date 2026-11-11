
import 'package:dartz/dartz.dart';
import 'package:hometake/features/auth/domain/entities/params/user_login_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_otp_verify_params.dart';
import 'package:hometake/features/auth/domain/entities/params/user_register_params.dart';
import 'package:hometake/features/auth/domain/entities/user_entity.dart';
import 'package:hometake/features/product/domain/entities/params/get_product_by_id_params.dart';
import 'package:hometake/features/product/domain/entities/params/get_proudct_params.dart';
import 'package:hometake/features/product/domain/entities/product_entity.dart';
import '../../../../core/error/failures.dart';

abstract class ProductRepository{

  Future<Either<Failure,List<ProductEntity>>> getProducts({required GetProductParams getProductParams});

  Future<Either<Failure,ProductEntity>> getProductById({required GetProductByIdParams getProductByIdParams});

}