import 'package:drift/drift.dart';

import '../../../auth/data/database/app_database.dart' as database;
import '../../domain/entities/product_catalog.dart';

abstract class ProductLocalDatasource {
  Future<ProductCatalog> getCatalog();
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  ProductLocalDatasourceImpl({required this.db});

  final database.AppDatabase db;

  @override
  Future<ProductCatalog> getCatalog() async{
    await Future.delayed(Duration(seconds: 3));
    return db.transaction(() async {
      final List<database.ProductType> typeRows =
          await (db.select(db.productTypes)..orderBy([
                (t) => OrderingTerm.asc(t.priorityNo),
                (t) => OrderingTerm.asc(t.id),
              ]))
              .get();
      final List<database.Product> productRows =
          await (db.select(db.products)..orderBy([
                (t) => OrderingTerm.asc(t.priorityNo),
                (t) => OrderingTerm.asc(t.id),
              ]))
              .get();
      final List<database.Category> categoryRows =
          await (db.select(db.categories)..orderBy([
                (t) => OrderingTerm.asc(t.priorityNo),
                (t) => OrderingTerm.asc(t.id),
              ]))
              .get();
      final List<database.Banner> bannerRows = await (db.select(
        db.banners,
      )..orderBy([(t) => OrderingTerm.asc(t.id)])).get();
      final List<database.Shop> shopRows = await (db.select(
        db.shops,
      )..orderBy([(t) => OrderingTerm.asc(t.id)])).get();
      final List<database.CategoryProduct> linkRows = await (db.select(
        db.categoryProducts,
      )..orderBy([(t) => OrderingTerm.asc(t.id)])).get();

      final Map<int, ProductTypeEntity> types = {
        for (final database.ProductType row in typeRows)
          row.id: ProductTypeEntity(
            id: row.id,
            name: row.name,
            imageUrl: row.imageUrl,
            priorityNo: row.priorityNo,
          ),
      };
      final Map<int, CategoryEntity> categories = {
        for (final database.Category row in categoryRows)
          row.id: CategoryEntity(
            id: row.id,
            name: row.name,
            imageUrl: row.imageUrl,
            priorityNo: row.priorityNo,
            isActive: row.isActive,
          ),
      };
      final Map<int, ProductEntity> products = {};
      for (final database.Product row in productRows) {
        final ProductTypeEntity type = types[row.productTypeId]!;
        final ProductEntity product = ProductEntity(
          id: row.id,
          name: row.name,
          imageUrl: row.imageUrl,
          priorityNo: row.priorityNo,
          price: row.price,
          currency: row.currency,
          productCode: row.productCode,
          description: row.description,
          isNew: row.isNew,
          discountPercentage: row.discountPercentage,
          discountAmount: row.discountAmount,
          productTypeId: row.productTypeId,
          productType: type,
        );
        products[row.id] = product;
        type.products.add(product);
      }
      final List<CategoryProductEntity> links = [];
      for (final database.CategoryProduct row in linkRows) {
        final ProductEntity product = products[row.productId]!;
        final CategoryEntity category = categories[row.categoryId]!;
        final CategoryProductEntity link = CategoryProductEntity(
          id: row.id,
          categoryId: row.categoryId,
          productId: row.productId,
          category: category,
          product: product,
        );
        links.add(link);
        category.categoryProducts.add(link);
        product.categoryProducts.add(link);
      }

      return ProductCatalog(
        products: products.values.toList(),
        productTypes: types.values.toList(),
        categories: categories.values.toList(),
        categoryProducts: links,
        banners: [
          for (final database.Banner row in bannerRows)
            BannerEntity(id: row.id, name: row.name, imageUrl: row.imageUrl),
        ],
        shops: [
          for (final database.Shop row in shopRows)
            ShopEntity(
              id: row.id,
              name: row.name,
              description: row.description,
              address: row.address,
              imageUrl: row.imageUrl,
              lat: row.lat,
              lng: row.lng,
            ),
        ],
      );
    });
  }
}
