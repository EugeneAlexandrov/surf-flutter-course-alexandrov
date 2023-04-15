import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/data/mock_categories.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/search_interactor/search_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/components/search_widget.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

String s =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFBDlR-zBwGFRxTLrfQhANd2M_aNNbKgSfpQ&usqp=CAU';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leadingWidth: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Список интересных мест',
          style: theme.textTheme.headline6?.copyWith(color: colors!.title),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
            style: theme.textTheme.bodyText1
                ?.copyWith(color: colors!.smallSecondaryTwo),
          ),
        ),
      ),
      body: Consumer<SearchInteractor>(
        builder: (context, searchInteractor, child) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16, top: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchField(
                  iconButton: CustomIconButton(
                    child: const Icon(Icons.cancel),
                    onPressed: () {
                      searchInteractor.deleteActualQuery();
                      searchController.text = '';
                    },
                  ),
                  textfield: TextField(
                    controller: searchController,
                    onChanged: searchInteractor.changeQuery,
                    onSubmitted: (value) {
                      searchInteractor.addSearchQuery(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.searchString,
                      hintStyle: theme.textTheme.bodyText1
                          ?.copyWith(color: colors!.subTitle),
                    ),
                  ),
                ),
                searchInteractor.actualQuery.isEmpty
                    ? QueryListWidget(searchInteractor)
                    : PlaceListWidet(
                        searchInteractor: searchInteractor,
                        searchController: searchController),
              ],
            ),
          );
        },
      ),
    );
  }
}

RichText highlightedSearchText(
  String text,
  String hightlightText,
  TextStyle? style,
) {
  int startIndex = text.toLowerCase().indexOf(hightlightText);
  int endIndex = startIndex + hightlightText.length;
  String start = text.substring(0, startIndex);
  String middle = text.substring(startIndex, endIndex);
  String end = text.substring(endIndex);
  return RichText(
      text: TextSpan(text: start, style: style, children: <TextSpan>[
    TextSpan(text: middle, style: style?.copyWith(color: Colors.green)),
    TextSpan(text: end, style: style),
  ]));
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(this.place, {Key? key}) : super(key: key);
  final Place place;

  @override
  Widget build(BuildContext context) {
    if (place.urls.isNotEmpty) {
      return SizedBox(
        height: 56,
        width: 56,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          height: 56,
          child: Image.network(
            place.urls[0],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image_outlined);
            },
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 56,
        width: 56,
        child: Icon(Icons.broken_image_outlined),
      );
    }
  }
}

class EmptyPlaceHolder extends StatelessWidget {
  const EmptyPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetImages.iconSearchPath, height: 58),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text(
              AppStrings.findNothing,
              style:
                  theme.textTheme.headline6?.copyWith(color: colors!.subTitle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppStrings.tryAnotherQuery,
              style:
                  theme.textTheme.bodyText2?.copyWith(color: colors!.subTitle),
            ),
          ),
        ],
      ),
    );
  }
}

class QueryListWidget extends StatelessWidget {
  const QueryListWidget(this.searchInteractor, {Key? key}) : super(key: key);
  final SearchInteractor searchInteractor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Text(
              AppStrings.youSearched,
              style:
                  theme.textTheme.headline1?.copyWith(color: colors!.subTitle),
            ),
          ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: searchInteractor.queries.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                      searchInteractor.queries[index],
                    ),
                    trailing: IconButton(
                        icon: SvgPicture.asset(AssetImages.iconCrossPath,
                            color: Colors.black),
                        onPressed: () {
                          searchInteractor.deleteSearchQuery(index);
                        }));
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          TextButton(
            onPressed: searchInteractor.clearSearchQueryHistory,
            child: Text(AppStrings.clearHistory,
                style: theme.textTheme.bodyText1
                    ?.copyWith(color: AppColors.lmGreen)),
          ),
        ],
      ),
    );
  }
}

class PlaceListWidet extends StatelessWidget {
  const PlaceListWidet({
    required this.searchInteractor,
    required this.searchController,
    Key? key,
  }) : super(key: key);
  final SearchInteractor searchInteractor;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return FutureBuilder<List<Place>>(
      future: searchInteractor.places,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Place> places = snapshot.data!;
          if (places.isNotEmpty) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: ListView.separated(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: AvatarWidget(places[index]),
                      title: highlightedSearchText(
                        places[index].name,
                        searchController.text,
                        theme.textTheme.bodyText1,
                      ),
                      subtitle: Text(
                        getFilterTitle(places[index].placeType),
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: colors!.smallSecondaryTwo),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            );
          } else {
            return const EmptyPlaceHolder();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
