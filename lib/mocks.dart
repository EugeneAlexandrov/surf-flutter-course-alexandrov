import 'domain/intention.dart';
import 'domain/sight.dart';

final List<Sight> sights = [
  Sight(
      name: 'Астраханский кремль',
      details:
          'Величественная крепость из белого камня, построенная в XVI веке, в которой сейчас расположен музей.',
      lat: 46.3460304,
      lon: 48.036286,
      type: 'исторический памятник',
      url: 'https://goo.gl/maps/zQU9HsQBjZDc5p967'),
  Sight(
      name: 'Три Топора',
      details: '',
      lat: 46.3515615,
      lon: 48.0359429,
      type: 'бар',
      url: 'https://goo.gl/maps/AbX9sV6MtFEqvw6w6'),
  Sight(
      name: 'Пряности и радости',
      details:
          'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
      lat: 46.3401663,
      lon: 48.0505972,
      type: 'ресторан',
      url: 'https://g.page/AstMusei?share'),
  Sight(
      name: 'Большие Исады',
      details:
          'один из исторических районов Астрахани, расположен в восточной трети безымянного искусственного острова, образованного каналом имени Варвация, Волгой, Кутумом и Царёвом',
      lat: 46.3329807,
      lon: 48.0681409,
      type: 'продуктовый рынок',
      url: 'https://goo.gl/maps/ho1VvTkTPRitcoGd6'),
];

final List<Intention> intentionsList = [
  Intention(sights[0], DateTime(2021, 8, 5), false),
  Intention(sights[1], DateTime(2022, 1, 15), false),
  Intention(sights[2], DateTime(2021, 10, 15), true),
  Intention(sights[3], DateTime(2022, 01, 15), true),
];
