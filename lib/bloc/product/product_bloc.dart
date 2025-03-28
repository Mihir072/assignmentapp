import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  int page = 0;
  final int limit = 10;
  bool isFetching = false;
  final ScrollController scrollController = ScrollController();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchMoreProducts>(_onFetchMoreProducts);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchMoreProducts());
      }
    });
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    if (isFetching) return;
    isFetching = true;

    try {
      final response = await http.get(Uri.parse(
          "https://dummyjson.com/products?limit=$limit&skip=${page * limit}"));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['products'];
        List<Product> newProducts =
            jsonResponse.map((e) => Product.fromJson(e)).toList();

        if (newProducts.isNotEmpty) {
          page++;
        }

        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          emit(ProductLoaded([...currentState.products, ...newProducts],
              isLoadingMore: false));
        } else {
          emit(ProductLoaded(newProducts, isLoadingMore: false));
        }
      } else {
        emit(ProductError("Failed to load products"));
      }
    } catch (e) {
      emit(ProductError("Error loading products: ${e.toString()}"));
    } finally {
      isFetching = false;
    }
  }

  Future<void> _onFetchMoreProducts(
      FetchMoreProducts event, Emitter<ProductState> emit) async {
    if (isFetching) return;
    isFetching = true;

    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      emit(ProductLoaded(currentState.products, isLoadingMore: true));
    }

    try {
      final response = await http.get(Uri.parse(
          "https://dummyjson.com/products?limit=$limit&skip=${page * limit}"));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['products'];
        List<Product> newProducts =
            jsonResponse.map((e) => Product.fromJson(e)).toList();

        if (newProducts.isNotEmpty) {
          page++;
        }

        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          emit(ProductLoaded([...currentState.products, ...newProducts],
              isLoadingMore: false));
        }
      } else {
        emit(ProductError("Failed to load more products"));
      }
    } catch (e) {
      emit(ProductError("Error loading more products: ${e.toString()}"));
    } finally {
      isFetching = false;
    }
  }
}
