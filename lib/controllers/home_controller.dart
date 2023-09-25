import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vinhome_user/models/category_model.dart';
import 'package:vinhome_user/models/offer.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:vinhome_user/models/response/categories_response.dart';
import 'package:vinhome_user/models/response/mode3.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';
import '../models/response/categories_mode_response.dart';
import '../models/response/menu_mode.dart';
import '../models/response/menu_mode3s.dart';
import '../models/response/store_categories_response.dart';
import 'apis/api_path.dart';

class HomeController extends GetxController {
  late CarouselController carouselController;
  late CateroiesResponse cateroiesResponse;
  final ScrollController scrollController = ScrollController();
  late List<StoreCategoriesResponse> storeCategoriesResponseList;
  late CategoriesModeResponse categoriesModeResponse;
  late List<ListCategoryStoreInMenu> listCategoryStoreInMenusFiltered;
  late List<ListCategoryStoreInMenu> listCategoryStoreInMenusFilteredHome;
  late List<MenuMode> listMenuMode;
  late String menuMode;
  late List<Mode3> listMode3;
  late MenuMode3S menuMode3;
  var modeId = 1;
  String deliveryTimeMode3 = "";

  var choiceIndexDayFiltter = 0;
  var choideIndexCategoryByView = -1;

  var activeOffers = <Offer>[].obs;

  var currentBanner = 0.obs;
  var categories = <CategoryModel>[].obs;
  var isLoading = false;

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  @override
  void onInit() {
    carouselController = CarouselController();
    getMod();
    getOffers(1);
    super.onInit();
  }

  void getOffers(int mode) {
    List<Offer> offers = <Offer>[];
    offers.clear();
    switch (mode) {
      case 1:
        offers.add(Offer(
          1,
          "https://www.highlandscoffee.com.vn/vnt_upload/weblink/Summer_Tea__website_banner2000x640_Tra_Yi_hYng.jpg",
        ));
        offers.add(Offer(
          2,
          "https://firebasestorage.googleapis.com/v0/b/deliveryfood-9c436.appspot.com/o/banner%2Fbanner_sale.jpg?alt=media&token=7d19e5a3-9cbf-44e7-902d-bb532651362f",
        ));
        offers.add(Offer(
          3,
          "https://firebasestorage.googleapis.com/v0/b/deliveryfood-9c436.appspot.com/o/banner%2F193452567_232982721923561_7074968439565756507_n.jpg?alt=media&token=81a1f170-ee5a-472f-b47a-31decc0760fc",
        ));
        break;
      case 2:
        offers.add(Offer(
          1,
          "https://firebasestorage.googleapis.com/v0/b/deliveryfood-9c436.appspot.com/o/icon%2Fslider_1.webp?alt=media&token=b61c0b1c-cdb9-4376-a4d4-954dc4a562d6",
        ));
        offers.add(Offer(
          2,
          "https://firebasestorage.googleapis.com/v0/b/deliveryfood-9c436.appspot.com/o/banner%2Fsection_banner_2.jpg?alt=media&token=8b1e5d93-a71e-42e4-935c-79071d44f2a0",
        ));
        offers.add(Offer(
          3,
          "https://salt.tikicdn.com/cache/w830/ts/tmp/d3/b9/a9/26ecee15b4f1b63e5ff92b621226f000.jpg",
        ));
        break;

      default:
        offers.add(Offer(1,
            "https://firebasestorage.googleapis.com/v0/b/deliveryfood-9c436.appspot.com/o/banner%2Fslide_2.png?alt=media&token=fda857ed-3c7f-469d-9e51-927a28207085"));
    }

    activeOffers.value = offers;
  }

  void getMod() {
    List<CategoryModel> categorieList = <CategoryModel>[];

    categorieList.add(CategoryModel(
        1,
        "Gọi món",
        "assets/images/hamburger.png",
        () => {
              getCategories('1'),
              getStoreCategories('1'),
              getOffers(1),
              getMenuMode(1),
              Get.toNamed(Routes.categoryDetail, arguments: 1),
            }));
    categorieList.add(CategoryModel(
        2,
        "Giao hàng",
        "assets/images/groceries.png",
        () => {
              getStoreCategoriesMode('2', false),
              getOffers(2),
              getMenuMode(2),
              Get.toNamed(Routes.categoryDetail, arguments: 2),
            }));
    categorieList.add(CategoryModel(
        3,
        "Đặt hàng",
        "assets/images/food-delivery.png",
        () => {
              getStoreCategoriesMode3(),
              getOffers(3),
              getMenuMode(3),
              Get.toNamed(Routes.categoryDetail, arguments: 3),
            }));
    categories.value = categorieList;
  }

  List<Offer> offers = <Offer>[];

  Future<void> getCategories(String id) async {
    isLoading = true;

    Map<String, String> queryParams = {'modeId': id};
    ResponseUtil.getDetailQueryMapping(queryParams, ApiPath.CATEGORIES_BANNER)
        .then((value) {
      cateroiesResponse = cateroiesResponseFromJson(value.body);
      delay();
    });
  }

  void delay() {
    Future.delayed(const Duration(seconds: 1), () {
      isLoading = true;
      update();
    }).then((value) {
      isLoading = false;
      update();
    });
  }

  Future<void> getStoreCategoriesMode3() async {
    isLoading = true;
    Map<String, String> queryParams = {'pageSize': '7'};
    try {
      await ResponseUtil.getDetailQueryMapping(queryParams, ApiPath.MODE3)
          .then((value) {
        listMode3 = mode3FromJson(value.body);
        delay();
      });
    } catch (e) {
      listMode3 = [];
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getStoreCategories(String id) async {
    isLoading = true;
    Map<String, String> queryParams = {
      'modeId': id,
      'storeCateSize': '5',
      'storeSize': '8'
    };
    ResponseUtil.getDetailQueryMapping(queryParams, ApiPath.STORE_CATEGORY)
        .then((value) {
      storeCategoriesResponseList = storeCategoriesResponseFromJson(value.body);
      delay();
    });
  }

  Future<void> getStoreCategoriesMode(String id, bool isHome) async {
    isLoading = true;
    Map<String, String> queryParams = {
      'modeId': id,
      'gb': 'cate',
      'page': '1',
      'pageSize': isHome ? '7' : '100',
    };
    ResponseUtil.getDetailQueryMapping(queryParams, ApiPath.MENU_FILTER)
        .then((value) {
      categoriesModeResponse = categoriesModeResponseFromJson(value.body);
      if (isHome) {
        listCategoryStoreInMenusFilteredHome =
            categoriesModeResponse.listCategoryStoreInMenus;

        listCategoryStoreInMenusFilteredHome.add(ListCategoryStoreInMenu(
            id: '8',
            image: 'assets/images/load_more_icon.png',
            name: 'Xem thêm',
            status: '1',
            listProducts: []));
      } else {
        listCategoryStoreInMenusFiltered = categoriesModeResponse
            .listCategoryStoreInMenus
            .where((element) => element.listProducts.isNotEmpty)
            .toList();
      }
      delay();
    });
  }

  Future<void> getMenuMode(int mode) async {
    modeId = mode;
    Map<String, String> queryParams = {"modeId": mode.toString()};
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String currentDate = formatter.format(DateTime.now());
    bool isTrue = false;
    await ResponseUtil.getMapping(path: ApiPath.MENU, queryParams: queryParams)
        .then((value) => {
              if (value.status == 200)
                {
                  listMenuMode = menuModeFromJson(value.body),
                  if (mode == 1 && DateTime.now().hour >= 12)
                    {
                      menuMode = listMenuMode[1].id,
                    }
                  else if (mode == 3)
                    {
                      for (MenuMode mode in listMenuMode)
                        {
                          if (mode.dayFilter == currentDate)
                            {
                              menuMode = mode.id,
                              isTrue = true,
                            }
                        },
                      if (!isTrue)
                        {
                          menuMode = listMenuMode.first.id,
                        }
                    }
                  else
                    {
                      menuMode = listMenuMode.first.id,
                    },
                  update(),
                }
              else
                {isLoading = false, update()}
            });
  }

  Future<void> getMenuMode3s(String id, String categoryId) async {
    menuMode = id;
    isLoading = true;
    Map<String, String> queryParams = {};
    if (categoryId != '') {
      queryParams = {
        'page': '1',
        'pageSize': '100',
        'searchBy': categoryId,
      };
    } else {
      queryParams = {
        'page': '1',
        'pageSize': '100',
      };
    }

    await ResponseUtil.getMapping(
            path: ApiPath.MODE3_FILTER + id + "/stores",
            queryParams: queryParams)
        .then((value) => {
              if (value.status == 200)
                {
                  menuMode3 = menuMode3SFromJson(value.body),
                },
              isLoading = false,
              update(),
            });
  }

  void changeChoiceIndexDayFiltter(index) {
    choiceIndexDayFiltter = index;
    choideIndexCategoryByView = -1;
    update();
  }

  void changeChoideIndexCategoryByView(index) {
    String categoryId = '';
    if (index != -1) {
      categoryId = menuMode3.categoryInMenuViews[index].id;
    }
    print(menuMode + " menuModeId");
    print(categoryId + " categoryId");
    getMenuMode3s(menuMode, categoryId);
    choideIndexCategoryByView = index;
    update();
  }
}
