import 'package:flutter/material.dart';
import 'package:places/domain/search_interactor/search_interactor.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  bool isControllerEmpty = true;

  void searchSights(String value) {
    setState(
      () {
        if (value.isNotEmpty) {
          isControllerEmpty = false;
          Provider.of<SearchInteractor>(context, listen: false)
              .findSightsByName(value);
        } else {
          isControllerEmpty = true;
          Provider.of<SearchInteractor>(context, listen: false)
              .clearSearchList();
        }
      },
    );
  }

  void completeSearch(String value) {
    if (value.isNotEmpty) {
      Provider.of<SearchInteractor>(context, listen: false).addQuery(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Container();
    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   appBar: AppBar(
    //     leadingWidth: 80,
    //     elevation: 0,
    //     backgroundColor: Colors.transparent,
    //     title: Text(
    //       'Список интересных мест',
    //       style: theme.textTheme.headline6?.copyWith(color: colors!.title),
    //     ),
    //     centerTitle: true,
    //     leading: TextButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       child: Text(
    //         AppStrings.cancel,
    //         style: theme.textTheme.bodyText1
    //             ?.copyWith(color: colors!.smallSecondaryTwo),
    //       ),
    //     ),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.only(right: 16.0, left: 16, top: 6),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         SearchField(
    //           iconButton: CustomIconButton(
    //             child: const Icon(Icons.cancel),
    //             onPressed: () {
    //               searchController.text = '';
    //               searchSights('');
    //             },
    //           ),
    //           textfield: TextField(
    //             controller: searchController,
    //             onChanged: searchSights,
    //             onSubmitted: completeSearch,
    //             decoration: InputDecoration(
    //               border: InputBorder.none,
    //               hintText: AppStrings.searchString,
    //               hintStyle: theme.textTheme.bodyText1
    //                   ?.copyWith(color: colors!.subTitle),
    //             ),
    //           ),
    //         ),
    //         Consumer<SearchInteractor>(
    //           builder: (context, searchInteractor, child) {
    //             if (isControllerEmpty) {
    //               return Expanded(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.only(top: 32.0),
    //                       child: Text(
    //                         AppStrings.youSearched,
    //                         style: theme.textTheme.headline1
    //                             ?.copyWith(color: colors!.subTitle),
    //                       ),
    //                     ),
    //                     Flexible(
    //                       child: ListView.separated(
    //                         shrinkWrap: true,
    //                         itemCount: searchInteractor.searchQueries.length,
    //                         itemBuilder: (context, index) {
    //                           return ListTile(
    //                             title: Text(
    //                               searchInteractor.searchQueries[index],
    //                             ),
    //                             trailing: IconButton(
    //                               icon: SvgPicture.asset(
    //                                   AssetImages.iconCrossPath,
    //                                   color: Colors.black),
    //                               onPressed: () {
    //                                 setState(() {
    //                                   searchInteractor.deleteSearchQuery(index);
    //                                 });
    //                               },
    //                             ),
    //                           );
    //                         },
    //                         separatorBuilder: (context, index) {
    //                           return const Divider();
    //                         },
    //                       ),
    //                     ),
    //                     TextButton(
    //                       onPressed: () => setState(() {
    //                         Provider.of<SearchInteractor>(
    //                           context,
    //                           listen: false,
    //                         ).clearHistory();
    //                       }),
    //                       child: Text(AppStrings.clearHistory,
    //                           style: theme.textTheme.bodyText1
    //                               ?.copyWith(color: AppColors.lmGreen)),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             } else {
    //               if (searchInteractor.searchSightList.isNotEmpty) {
    //                 return Expanded(
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 35.0),
    //                     child: ListView.separated(
    //                       itemCount: searchInteractor.searchSightList.length,
    //                       itemBuilder: (context, index) {
    //                         return ListTile(
    //                           leading: SizedBox(
    //                             height: 56,
    //                             width: 56,
    //                             child: Container(
    //                               decoration: const BoxDecoration(
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(8.0)),
    //                                 image: DecorationImage(
    //                                     alignment: Alignment.topCenter,
    //                                     fit: BoxFit.cover,
    //                                     image: ExactAssetImage(
    //                                         AssetImages.mockImageCardPath)),
    //                               ),
    //                               height: 56,
    //                             ),
    //                           ),
    //                           title: highlightedSearchText(
    //                             searchInteractor.searchSightList[index].name,
    //                             searchController.text,
    //                             theme.textTheme.bodyText1,
    //                           ),
    //                           //  Text(
    //                           //   SearchInteractor.searchSightList[index].name,
    //                           //   style: theme.textTheme.bodyText1,
    //                           // ),
    //                           subtitle: Text(
    //                             Provider.of<FilterRepository>(context,
    //                                     listen: false)
    //                                 .getFilterById(SearchInteractor
    //                                     .searchSightList[index].filterId)
    //                                 .title,
    //                             // SearchInteractor
    //                             //     .sightRepository.filterRepository
    //                             //     .getFilterById(SearchInteractor
    //                             //         .searchSightList[index].filterId)
    //                             //     .title,
    //                             style: theme.textTheme.bodyText2?.copyWith(
    //                                 color: colors!.smallSecondaryTwo),
    //                           ),
    //                         );
    //                       },
    //                       separatorBuilder: (context, index) {
    //                         return const Divider();
    //                       },
    //                     ),
    //                   ),
    //                 );
    //               } else {
    //                 return Expanded(
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       SvgPicture.asset(AssetImages.iconSearchPath,
    //                           height: 58),
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 32),
    //                         child: Text(
    //                           AppStrings.findNothing,
    //                           style: theme.textTheme.headline6
    //                               ?.copyWith(color: colors!.subTitle),
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Text(
    //                           AppStrings.tryAnotherQuery,
    //                           style: theme.textTheme.bodyText2
    //                               ?.copyWith(color: colors!.subTitle),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               }
    //             }
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  RichText highlightedSearchText(
    String text,
    String hightlightText,
    TextStyle? style,
  ) {
    int startIndex = text.indexOf(hightlightText);
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
}
