import 'package:meta/meta.dart';

/// Страна
@immutable
class Country {
  /// Страна
  const Country({
    required final this.id,
    required final this.code,
    required final this.title,
    final this.latitude = 0,
    final this.longitude = 0,
  });

  /// Получить страну по коду
  factory Country.byCode(String? code) {
    final c = code?.trim().toUpperCase();
    if (c == null || c.length != 2) return Countries.unknown;
    return Countries.values[c] ?? Countries.unknown;
  }

  /// Это выбранная, существующая страна
  bool get isExist => id > 0;

  /// Идентификатор страны
  final int id;

  /// Двухбуквенный код страны
  final String code;

  /// Название страны
  final String title;

  /// Примерная широта
  final double latitude;

  /// Примерная долгота
  final double longitude;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => identical(other, this) || (other is Country && other.id == id);
}

/// Список всех стран
abstract class Countries {
  Countries._();

  static const Country unknown = Country(id: 0, code: 'XX', title: 'Unknown country', latitude: 0, longitude: 0);
  static const Country afghanistan = Country(id: 4, code: 'AF', title: 'Afghanistan', latitude: 33, longitude: 65);
  static const Country albania = Country(id: 8, code: 'AL', title: 'Albania', latitude: 41, longitude: 20);
  static const Country antarctica = Country(id: 10, code: 'AQ', title: 'Antarctica', latitude: -90, longitude: 0);
  static const Country algeria = Country(id: 12, code: 'DZ', title: 'Algeria', latitude: 28, longitude: 3);
  static const Country americanSamoa =
      Country(id: 16, code: 'AS', title: 'American Samoa', latitude: -14.3333, longitude: -170);
  static const Country andorra = Country(id: 20, code: 'AD', title: 'Andorra', latitude: 42.5, longitude: 1.6);
  static const Country angola = Country(id: 24, code: 'AO', title: 'Angola', latitude: -12.5, longitude: 18.5);
  static const Country antiguaAndBarbuda =
      Country(id: 28, code: 'AG', title: 'Antigua and Barbuda', latitude: 17.05, longitude: -61.8);
  static const Country azerbaijan = Country(id: 31, code: 'AZ', title: 'Azerbaijan', latitude: 40.5, longitude: 47.5);
  static const Country argentina = Country(id: 32, code: 'AR', title: 'Argentina', latitude: -34, longitude: -64);
  static const Country australia = Country(id: 36, code: 'AU', title: 'Australia', latitude: -27, longitude: 133);
  static const Country austria = Country(id: 40, code: 'AT', title: 'Austria', latitude: 47.3333, longitude: 13.3333);
  static const Country bahamas = Country(id: 44, code: 'BS', title: 'Bahamas', latitude: 24.25, longitude: -76);
  static const Country bahrain = Country(id: 48, code: 'BH', title: 'Bahrain', latitude: 26, longitude: 50.55);
  static const Country bangladesh = Country(id: 50, code: 'BD', title: 'Bangladesh', latitude: 24, longitude: 90);
  static const Country armenia = Country(id: 51, code: 'AM', title: 'Armenia', latitude: 40, longitude: 45);
  static const Country barbados =
      Country(id: 52, code: 'BB', title: 'Barbados', latitude: 13.1667, longitude: -59.5333);
  static const Country belgium = Country(id: 56, code: 'BE', title: 'Belgium', latitude: 50.8333, longitude: 4);
  static const Country bermuda = Country(id: 60, code: 'BM', title: 'Bermuda', latitude: 32.3333, longitude: -64.75);
  static const Country bhutan = Country(id: 64, code: 'BT', title: 'Bhutan', latitude: 27.5, longitude: 90.5);
  static const Country bolivia = Country(id: 68, code: 'BO', title: 'Bolivia', latitude: -17, longitude: -65);
  static const Country bosniaAndHerzegovina =
      Country(id: 70, code: 'BA', title: 'Bosnia and Herzegovina', latitude: 44, longitude: 18);
  static const Country botswana = Country(id: 72, code: 'BW', title: 'Botswana', latitude: -22, longitude: 24);
  static const Country bouvetIsland =
      Country(id: 74, code: 'BV', title: 'Bouvet Island', latitude: -54.4333, longitude: 3.4);
  static const Country brazil = Country(id: 76, code: 'BR', title: 'Brazil', latitude: -10, longitude: -55);
  static const Country belize = Country(id: 84, code: 'BZ', title: 'Belize', latitude: 17.25, longitude: -88.75);
  static const Country britishIndianOceanTerritory =
      Country(id: 86, code: 'IO', title: 'British Indian Ocean Territory', latitude: -6, longitude: 71.5);
  static const Country solomonIslands =
      Country(id: 90, code: 'SB', title: 'Solomon Islands', latitude: -8, longitude: 159);
  static const Country virginIslandsBritish =
      Country(id: 92, code: 'VG', title: 'Virgin Islands, British', latitude: 18.5, longitude: -64.5);
  static const Country brunei = Country(id: 96, code: 'BN', title: 'Brunei', latitude: 4.5, longitude: 114.6667);
  static const Country bulgaria = Country(id: 100, code: 'BG', title: 'Bulgaria', latitude: 43, longitude: 25);
  static const Country burma = Country(id: 104, code: 'MM', title: 'Burma', latitude: 22, longitude: 98);
  static const Country burundi = Country(id: 108, code: 'BI', title: 'Burundi', latitude: -3.5, longitude: 30);
  static const Country belarus = Country(id: 112, code: 'BY', title: 'Belarus', latitude: 53, longitude: 28);
  static const Country cambodia = Country(id: 116, code: 'KH', title: 'Cambodia', latitude: 13, longitude: 105);
  static const Country cameroon = Country(id: 120, code: 'CM', title: 'Cameroon', latitude: 6, longitude: 12);
  static const Country canada = Country(id: 124, code: 'CA', title: 'Canada', latitude: 60, longitude: -95);
  static const Country capeVerde = Country(id: 132, code: 'CV', title: 'Cape Verde', latitude: 16, longitude: -24);
  static const Country caymanIslands =
      Country(id: 136, code: 'KY', title: 'Cayman Islands', latitude: 19.5, longitude: -80.5);
  static const Country centralAfricanRepublic =
      Country(id: 140, code: 'CF', title: 'Central African Republic', latitude: 7, longitude: 21);
  static const Country sriLanka = Country(id: 144, code: 'LK', title: 'Sri Lanka', latitude: 7, longitude: 81);
  static const Country chad = Country(id: 148, code: 'TD', title: 'Chad', latitude: 15, longitude: 19);
  static const Country chile = Country(id: 152, code: 'CL', title: 'Chile', latitude: -30, longitude: -71);
  static const Country china = Country(id: 156, code: 'CN', title: 'China', latitude: 35, longitude: 105);
  static const Country taiwan = Country(id: 158, code: 'TW', title: 'Taiwan', latitude: 23.5, longitude: 121);
  static const Country christmasIsland =
      Country(id: 162, code: 'CX', title: 'Christmas Island', latitude: -10.5, longitude: 105.6667);
  static const Country cocosKeelingIslands =
      Country(id: 166, code: 'CC', title: 'Cocos (Keeling) Islands', latitude: -12.5, longitude: 96.8333);
  static const Country colombia = Country(id: 170, code: 'CO', title: 'Colombia', latitude: 4, longitude: -72);
  static const Country comoros = Country(id: 174, code: 'KM', title: 'Comoros', latitude: -12.1667, longitude: 44.25);
  static const Country mayotte = Country(id: 175, code: 'YT', title: 'Mayotte', latitude: -12.8333, longitude: 45.1667);
  static const Country congo = Country(id: 178, code: 'CG', title: 'Congo', latitude: -1, longitude: 15);
  static const Country congoTheDemocraticRepublicOfThe =
      Country(id: 180, code: 'CD', title: 'Congo, the Democratic Republic of the', latitude: 0, longitude: 25);
  static const Country cookIslands =
      Country(id: 184, code: 'CK', title: 'Cook Islands', latitude: -21.2333, longitude: -159.7667);
  static const Country costaRica = Country(id: 188, code: 'CR', title: 'Costa Rica', latitude: 10, longitude: -84);
  static const Country croatia = Country(id: 191, code: 'HR', title: 'Croatia', latitude: 45.1667, longitude: 15.5);
  static const Country cuba = Country(id: 192, code: 'CU', title: 'Cuba', latitude: 21.5, longitude: -80);
  static const Country cyprus = Country(id: 196, code: 'CY', title: 'Cyprus', latitude: 35, longitude: 33);
  static const Country czechRepublic =
      Country(id: 203, code: 'CZ', title: 'Czech Republic', latitude: 49.75, longitude: 15.5);
  static const Country benin = Country(id: 204, code: 'BJ', title: 'Benin', latitude: 9.5, longitude: 2.25);
  static const Country denmark = Country(id: 208, code: 'DK', title: 'Denmark', latitude: 56, longitude: 10);
  static const Country dominica =
      Country(id: 212, code: 'DM', title: 'Dominica', latitude: 15.4167, longitude: -61.3333);
  static const Country dominicanRepublic =
      Country(id: 214, code: 'DO', title: 'Dominican Republic', latitude: 19, longitude: -70.6667);
  static const Country ecuador = Country(id: 218, code: 'EC', title: 'Ecuador', latitude: -2, longitude: -77.5);
  static const Country elSalvador =
      Country(id: 222, code: 'SV', title: 'El Salvador', latitude: 13.8333, longitude: -88.9167);
  static const Country equatorialGuinea =
      Country(id: 226, code: 'GQ', title: 'Equatorial Guinea', latitude: 2, longitude: 10);
  static const Country ethiopia = Country(id: 231, code: 'ET', title: 'Ethiopia', latitude: 8, longitude: 38);
  static const Country eritrea = Country(id: 232, code: 'ER', title: 'Eritrea', latitude: 15, longitude: 39);
  static const Country estonia = Country(id: 233, code: 'EE', title: 'Estonia', latitude: 59, longitude: 26);
  static const Country faroeIslands = Country(id: 234, code: 'FO', title: 'Faroe Islands', latitude: 62, longitude: -7);
  static const Country falklandIslandsMalvinas =
      Country(id: 238, code: 'FK', title: 'Falkland Islands (Malvinas)', latitude: -51.75, longitude: -59);
  static const Country southGeorgiaAndTheSouthSandwichIslands = Country(
    id: 239,
    code: 'GS',
    title: 'South Georgia and the South Sandwich Islands',
    latitude: -54.5,
    longitude: -37,
  );
  static const Country fiji = Country(id: 242, code: 'FJ', title: 'Fiji', latitude: -18, longitude: 175);
  static const Country finland = Country(id: 246, code: 'FI', title: 'Finland', latitude: 64, longitude: 26);
  static const Country france = Country(id: 250, code: 'FR', title: 'France', latitude: 46, longitude: 2);
  static const Country frenchGuiana = Country(id: 254, code: 'GF', title: 'French Guiana', latitude: 4, longitude: -53);
  static const Country frenchPolynesia =
      Country(id: 258, code: 'PF', title: 'French Polynesia', latitude: -15, longitude: -140);
  static const Country frenchSouthernTerritories =
      Country(id: 260, code: 'TF', title: 'French Southern Territories', latitude: -43, longitude: 67);
  static const Country djibouti = Country(id: 262, code: 'DJ', title: 'Djibouti', latitude: 11.5, longitude: 43);
  static const Country gabon = Country(id: 266, code: 'GA', title: 'Gabon', latitude: -1, longitude: 11.75);
  static const Country georgia = Country(id: 268, code: 'GE', title: 'Georgia', latitude: 42, longitude: 43.5);
  static const Country gambia = Country(id: 270, code: 'GM', title: 'Gambia', latitude: 13.4667, longitude: -16.5667);
  static const Country palestinianTerritoryOccupied =
      Country(id: 275, code: 'PS', title: 'Palestinian Territory, Occupied', latitude: 32, longitude: 35.25);
  static const Country germany = Country(id: 276, code: 'DE', title: 'Germany', latitude: 51, longitude: 9);
  static const Country ghana = Country(id: 288, code: 'GH', title: 'Ghana', latitude: 8, longitude: -2);
  static const Country gibraltar =
      Country(id: 292, code: 'GI', title: 'Gibraltar', latitude: 36.1833, longitude: -5.3667);
  static const Country kiribati = Country(id: 296, code: 'KI', title: 'Kiribati', latitude: 1.4167, longitude: 173);
  static const Country greece = Country(id: 300, code: 'GR', title: 'Greece', latitude: 39, longitude: 22);
  static const Country greenland = Country(id: 304, code: 'GL', title: 'Greenland', latitude: 72, longitude: -40);
  static const Country grenada = Country(id: 308, code: 'GD', title: 'Grenada', latitude: 12.1167, longitude: -61.6667);
  static const Country guadeloupe =
      Country(id: 312, code: 'GP', title: 'Guadeloupe', latitude: 16.25, longitude: -61.5833);
  static const Country guam = Country(id: 316, code: 'GU', title: 'Guam', latitude: 13.4667, longitude: 144.7833);
  static const Country guatemala = Country(id: 320, code: 'GT', title: 'Guatemala', latitude: 15.5, longitude: -90.25);
  static const Country guinea = Country(id: 324, code: 'GN', title: 'Guinea', latitude: 11, longitude: -10);
  static const Country guyana = Country(id: 328, code: 'GY', title: 'Guyana', latitude: 5, longitude: -59);
  static const Country haiti = Country(id: 332, code: 'HT', title: 'Haiti', latitude: 19, longitude: -72.4167);
  static const Country heardIslandAndMcDonaldIslands =
      Country(id: 334, code: 'HM', title: 'Heard Island and McDonald Islands', latitude: -53.1, longitude: 72.5167);
  static const Country holySeeVaticanCityState =
      Country(id: 336, code: 'VA', title: 'Holy See (Vatican City State)', latitude: 41.9, longitude: 12.45);
  static const Country honduras = Country(id: 340, code: 'HN', title: 'Honduras', latitude: 15, longitude: -86.5);
  static const Country hongKong =
      Country(id: 344, code: 'HK', title: 'Hong Kong', latitude: 22.25, longitude: 114.1667);
  static const Country hungary = Country(id: 348, code: 'HU', title: 'Hungary', latitude: 47, longitude: 20);
  static const Country iceland = Country(id: 352, code: 'IS', title: 'Iceland', latitude: 65, longitude: -18);
  static const Country india = Country(id: 356, code: 'IN', title: 'India', latitude: 20, longitude: 77);
  static const Country indonesia = Country(id: 360, code: 'ID', title: 'Indonesia', latitude: -5, longitude: 120);
  static const Country iranIslamicRepublicOf =
      Country(id: 364, code: 'IR', title: 'Iran, Islamic Republic of', latitude: 32, longitude: 53);
  static const Country iraq = Country(id: 368, code: 'IQ', title: 'Iraq', latitude: 33, longitude: 44);
  static const Country ireland = Country(id: 372, code: 'IE', title: 'Ireland', latitude: 53, longitude: -8);
  static const Country israel = Country(id: 376, code: 'IL', title: 'Israel', latitude: 31.5, longitude: 34.75);
  static const Country italy = Country(id: 380, code: 'IT', title: 'Italy', latitude: 42.8333, longitude: 12.8333);
  static const Country ivoryCoast = Country(id: 384, code: 'CI', title: 'Ivory Coast', latitude: 8, longitude: -5);
  static const Country jamaica = Country(id: 388, code: 'JM', title: 'Jamaica', latitude: 18.25, longitude: -77.5);
  static const Country japan = Country(id: 392, code: 'JP', title: 'Japan', latitude: 36, longitude: 138);
  static const Country kazakhstan = Country(id: 398, code: 'KZ', title: 'Kazakhstan', latitude: 48, longitude: 68);
  static const Country jordan = Country(id: 400, code: 'JO', title: 'Jordan', latitude: 31, longitude: 36);
  static const Country kenya = Country(id: 404, code: 'KE', title: 'Kenya', latitude: 1, longitude: 38);
  static const Country koreaDemocraticPeoplesRepublicOf =
      Country(id: 408, code: 'KP', title: "Korea, Democratic People's Republic of", latitude: 40, longitude: 127);
  static const Country southKorea = Country(id: 410, code: 'KR', title: 'South Korea', latitude: 37, longitude: 127.5);
  static const Country kuwait = Country(id: 414, code: 'KW', title: 'Kuwait', latitude: 29.3375, longitude: 47.6581);
  static const Country kyrgyzstan = Country(id: 417, code: 'KG', title: 'Kyrgyzstan', latitude: 41, longitude: 75);
  static const Country laoPeoplesDemocraticRepublic =
      Country(id: 418, code: 'LA', title: "Lao People's Democratic Republic", latitude: 18, longitude: 105);
  static const Country lebanon = Country(id: 422, code: 'LB', title: 'Lebanon', latitude: 33.8333, longitude: 35.8333);
  static const Country lesotho = Country(id: 426, code: 'LS', title: 'Lesotho', latitude: -29.5, longitude: 28.5);
  static const Country latvia = Country(id: 428, code: 'LV', title: 'Latvia', latitude: 57, longitude: 25);
  static const Country liberia = Country(id: 430, code: 'LR', title: 'Liberia', latitude: 6.5, longitude: -9.5);
  static const Country libya = Country(id: 434, code: 'LY', title: 'Libya', latitude: 25, longitude: 17);
  static const Country liechtenstein =
      Country(id: 438, code: 'LI', title: 'Liechtenstein', latitude: 47.1667, longitude: 9.5333);
  static const Country lithuania = Country(id: 440, code: 'LT', title: 'Lithuania', latitude: 56, longitude: 24);
  static const Country luxembourg =
      Country(id: 442, code: 'LU', title: 'Luxembourg', latitude: 49.75, longitude: 6.1667);
  static const Country macao = Country(id: 446, code: 'MO', title: 'Macao', latitude: 22.1667, longitude: 113.55);
  static const Country madagascar = Country(id: 450, code: 'MG', title: 'Madagascar', latitude: -20, longitude: 47);
  static const Country malawi = Country(id: 454, code: 'MW', title: 'Malawi', latitude: -13.5, longitude: 34);
  static const Country malaysia = Country(id: 458, code: 'MY', title: 'Malaysia', latitude: 2.5, longitude: 112.5);
  static const Country maldives = Country(id: 462, code: 'MV', title: 'Maldives', latitude: 3.25, longitude: 73);
  static const Country mali = Country(id: 466, code: 'ML', title: 'Mali', latitude: 17, longitude: -4);
  static const Country malta = Country(id: 470, code: 'MT', title: 'Malta', latitude: 35.8333, longitude: 14.5833);
  static const Country martinique =
      Country(id: 474, code: 'MQ', title: 'Martinique', latitude: 14.6667, longitude: -61);
  static const Country mauritania = Country(id: 478, code: 'MR', title: 'Mauritania', latitude: 20, longitude: -12);
  static const Country mauritius =
      Country(id: 480, code: 'MU', title: 'Mauritius', latitude: -20.2833, longitude: 57.55);
  static const Country mexico = Country(id: 484, code: 'MX', title: 'Mexico', latitude: 23, longitude: -102);
  static const Country monaco = Country(id: 492, code: 'MC', title: 'Monaco', latitude: 43.7333, longitude: 7.4);
  static const Country mongolia = Country(id: 496, code: 'MN', title: 'Mongolia', latitude: 46, longitude: 105);
  static const Country moldovaRepublicOf =
      Country(id: 498, code: 'MD', title: 'Moldova, Republic of', latitude: 47, longitude: 29);
  static const Country montenegro = Country(id: 499, code: 'ME', title: 'Montenegro', latitude: 42, longitude: 19);
  static const Country montserrat =
      Country(id: 500, code: 'MS', title: 'Montserrat', latitude: 16.75, longitude: -62.2);
  static const Country morocco = Country(id: 504, code: 'MA', title: 'Morocco', latitude: 32, longitude: -5);
  static const Country mozambique = Country(id: 508, code: 'MZ', title: 'Mozambique', latitude: -18.25, longitude: 35);
  static const Country oman = Country(id: 512, code: 'OM', title: 'Oman', latitude: 21, longitude: 57);
  static const Country namibia = Country(id: 516, code: 'NA', title: 'Namibia', latitude: -22, longitude: 17);
  static const Country nauru = Country(id: 520, code: 'NR', title: 'Nauru', latitude: -0.5333, longitude: 166.9167);
  static const Country nepal = Country(id: 524, code: 'NP', title: 'Nepal', latitude: 28, longitude: 84);
  static const Country netherlands =
      Country(id: 528, code: 'NL', title: 'Netherlands', latitude: 52.5, longitude: 5.75);
  static const Country netherlandsAntilles =
      Country(id: 530, code: 'AN', title: 'Netherlands Antilles', latitude: 12.25, longitude: -68.75);
  static const Country aruba = Country(id: 533, code: 'AW', title: 'Aruba', latitude: 12.5, longitude: -69.9667);
  static const Country newCaledonia =
      Country(id: 540, code: 'NC', title: 'New Caledonia', latitude: -21.5, longitude: 165.5);
  static const Country vanuatu = Country(id: 548, code: 'VU', title: 'Vanuatu', latitude: -16, longitude: 167);
  static const Country newZealand = Country(id: 554, code: 'NZ', title: 'New Zealand', latitude: -41, longitude: 174);
  static const Country nicaragua = Country(id: 558, code: 'NI', title: 'Nicaragua', latitude: 13, longitude: -85);
  static const Country niger = Country(id: 562, code: 'NE', title: 'Niger', latitude: 16, longitude: 8);
  static const Country nigeria = Country(id: 566, code: 'NG', title: 'Nigeria', latitude: 10, longitude: 8);
  static const Country niue = Country(id: 570, code: 'NU', title: 'Niue', latitude: -19.0333, longitude: -169.8667);
  static const Country norfolkIsland =
      Country(id: 574, code: 'NF', title: 'Norfolk Island', latitude: -29.0333, longitude: 167.95);
  static const Country norway = Country(id: 578, code: 'NO', title: 'Norway', latitude: 62, longitude: 10);
  static const Country northernMarianaIslands =
      Country(id: 580, code: 'MP', title: 'Northern Mariana Islands', latitude: 15.2, longitude: 145.75);
  static const Country unitedStatesMinorOutlyingIslands =
      Country(id: 581, code: 'UM', title: 'United States Minor Outlying Islands', latitude: 19.2833, longitude: 166.6);
  static const Country micronesiaFederatedStatesOf =
      Country(id: 583, code: 'FM', title: 'Micronesia, Federated States of', latitude: 6.9167, longitude: 158.25);
  static const Country marshallIslands =
      Country(id: 584, code: 'MH', title: 'Marshall Islands', latitude: 9, longitude: 168);
  static const Country palau = Country(id: 585, code: 'PW', title: 'Palau', latitude: 7.5, longitude: 134.5);
  static const Country pakistan = Country(id: 586, code: 'PK', title: 'Pakistan', latitude: 30, longitude: 70);
  static const Country panama = Country(id: 591, code: 'PA', title: 'Panama', latitude: 9, longitude: -80);
  static const Country papuaNewGuinea =
      Country(id: 598, code: 'PG', title: 'Papua New Guinea', latitude: -6, longitude: 147);
  static const Country paraguay = Country(id: 600, code: 'PY', title: 'Paraguay', latitude: -23, longitude: -58);
  static const Country peru = Country(id: 604, code: 'PE', title: 'Peru', latitude: -10, longitude: -76);
  static const Country philippines = Country(id: 608, code: 'PH', title: 'Philippines', latitude: 13, longitude: 122);
  static const Country pitcairn = Country(id: 612, code: 'PN', title: 'Pitcairn', latitude: -24.7, longitude: -127.4);
  static const Country poland = Country(id: 616, code: 'PL', title: 'Poland', latitude: 52, longitude: 20);
  static const Country portugal = Country(id: 620, code: 'PT', title: 'Portugal', latitude: 39.5, longitude: -8);
  static const Country guineaBissau =
      Country(id: 624, code: 'GW', title: 'Guinea-Bissau', latitude: 12, longitude: -15);
  static const Country timorLeste =
      Country(id: 626, code: 'TL', title: 'Timor-Leste', latitude: -8.55, longitude: 125.5167);
  static const Country puertoRico =
      Country(id: 630, code: 'PR', title: 'Puerto Rico', latitude: 18.25, longitude: -66.5);
  static const Country qatar = Country(id: 634, code: 'QA', title: 'Qatar', latitude: 25.5, longitude: 51.25);
  static const Country runion = Country(id: 638, code: 'RE', title: 'Réunion', latitude: -21.1, longitude: 55.6);
  static const Country romania = Country(id: 642, code: 'RO', title: 'Romania', latitude: 46, longitude: 25);
  static const Country russia = Country(id: 643, code: 'RU', title: 'Russia', latitude: 60, longitude: 100);
  static const Country rwanda = Country(id: 646, code: 'RW', title: 'Rwanda', latitude: -2, longitude: 30);
  static const Country saintHelenaAscensionAndTristanDaCunha = Country(
    id: 654,
    code: 'SH',
    title: 'Saint Helena, Ascension and Tristan da Cunha',
    latitude: -15.9333,
    longitude: -5.7,
  );
  static const Country saintKittsAndNevis =
      Country(id: 659, code: 'KN', title: 'Saint Kitts and Nevis', latitude: 17.3333, longitude: -62.75);
  static const Country anguilla = Country(id: 660, code: 'AI', title: 'Anguilla', latitude: 18.25, longitude: -63.1667);
  static const Country saintLucia =
      Country(id: 662, code: 'LC', title: 'Saint Lucia', latitude: 13.8833, longitude: -61.1333);
  static const Country saintPierreAndMiquelon =
      Country(id: 666, code: 'PM', title: 'Saint Pierre and Miquelon', latitude: 46.8333, longitude: -56.3333);
  static const Country saintVincentTheGrenadines =
      Country(id: 670, code: 'VC', title: 'Saint Vincent & the Grenadines', latitude: 13.25, longitude: -61.2);
  static const Country sanMarino =
      Country(id: 674, code: 'SM', title: 'San Marino', latitude: 43.7667, longitude: 12.4167);
  static const Country saoTomeAndPrincipe =
      Country(id: 678, code: 'ST', title: 'Sao Tome and Principe', latitude: 1, longitude: 7);
  static const Country saudiArabia = Country(id: 682, code: 'SA', title: 'Saudi Arabia', latitude: 25, longitude: 45);
  static const Country senegal = Country(id: 686, code: 'SN', title: 'Senegal', latitude: 14, longitude: -14);
  static const Country serbia = Country(id: 688, code: 'RS', title: 'Serbia', latitude: 44, longitude: 21);
  static const Country seychelles =
      Country(id: 690, code: 'SC', title: 'Seychelles', latitude: -4.5833, longitude: 55.6667);
  static const Country sierraLeone =
      Country(id: 694, code: 'SL', title: 'Sierra Leone', latitude: 8.5, longitude: -11.5);
  static const Country singapore = Country(id: 702, code: 'SG', title: 'Singapore', latitude: 1.3667, longitude: 103.8);
  static const Country slovakia = Country(id: 703, code: 'SK', title: 'Slovakia', latitude: 48.6667, longitude: 19.5);
  static const Country vietnam = Country(id: 704, code: 'VN', title: 'Vietnam', latitude: 16, longitude: 106);
  static const Country slovenia = Country(id: 705, code: 'SI', title: 'Slovenia', latitude: 46, longitude: 15);
  static const Country somalia = Country(id: 706, code: 'SO', title: 'Somalia', latitude: 10, longitude: 49);
  static const Country southAfrica = Country(id: 710, code: 'ZA', title: 'South Africa', latitude: -29, longitude: 24);
  static const Country zimbabwe = Country(id: 716, code: 'ZW', title: 'Zimbabwe', latitude: -20, longitude: 30);
  static const Country spain = Country(id: 724, code: 'ES', title: 'Spain', latitude: 40, longitude: -4);
  static const Country westernSahara =
      Country(id: 732, code: 'EH', title: 'Western Sahara', latitude: 24.5, longitude: -13);
  static const Country sudan = Country(id: 736, code: 'SD', title: 'Sudan', latitude: 15, longitude: 30);
  static const Country suriname = Country(id: 740, code: 'SR', title: 'Suriname', latitude: 4, longitude: -56);
  static const Country svalbardAndJanMayen =
      Country(id: 744, code: 'SJ', title: 'Svalbard and Jan Mayen', latitude: 78, longitude: 20);
  static const Country swaziland = Country(id: 748, code: 'SZ', title: 'Swaziland', latitude: -26.5, longitude: 31.5);
  static const Country sweden = Country(id: 752, code: 'SE', title: 'Sweden', latitude: 62, longitude: 15);
  static const Country switzerland = Country(id: 756, code: 'CH', title: 'Switzerland', latitude: 47, longitude: 8);
  static const Country syrianArabRepublic =
      Country(id: 760, code: 'SY', title: 'Syrian Arab Republic', latitude: 35, longitude: 38);
  static const Country tajikistan = Country(id: 762, code: 'TJ', title: 'Tajikistan', latitude: 39, longitude: 71);
  static const Country thailand = Country(id: 764, code: 'TH', title: 'Thailand', latitude: 15, longitude: 100);
  static const Country togo = Country(id: 768, code: 'TG', title: 'Togo', latitude: 8, longitude: 1.1667);
  static const Country tokelau = Country(id: 772, code: 'TK', title: 'Tokelau', latitude: -9, longitude: -172);
  static const Country tonga = Country(id: 776, code: 'TO', title: 'Tonga', latitude: -20, longitude: -175);
  static const Country trinidadTobago =
      Country(id: 780, code: 'TT', title: 'Trinidad & Tobago', latitude: 11, longitude: -61);
  static const Country unitedArabEmirates =
      Country(id: 784, code: 'AE', title: 'United Arab Emirates', latitude: 24, longitude: 54);
  static const Country tunisia = Country(id: 788, code: 'TN', title: 'Tunisia', latitude: 34, longitude: 9);
  static const Country turkey = Country(id: 792, code: 'TR', title: 'Turkey', latitude: 39, longitude: 35);
  static const Country turkmenistan = Country(id: 795, code: 'TM', title: 'Turkmenistan', latitude: 40, longitude: 60);
  static const Country turksAndCaicosIslands =
      Country(id: 796, code: 'TC', title: 'Turks and Caicos Islands', latitude: 21.75, longitude: -71.5833);
  static const Country tuvalu = Country(id: 798, code: 'TV', title: 'Tuvalu', latitude: -8, longitude: 178);
  static const Country uganda = Country(id: 800, code: 'UG', title: 'Uganda', latitude: 1, longitude: 32);
  static const Country ukraine = Country(id: 804, code: 'UA', title: 'Ukraine', latitude: 49, longitude: 32);
  static const Country macedoniaTheFormerYugoslavRepublicOf = Country(
    id: 807,
    code: 'MK',
    title: 'Macedonia, the former Yugoslav Republic of',
    latitude: 41.8333,
    longitude: 22,
  );
  static const Country egypt = Country(id: 818, code: 'EG', title: 'Egypt', latitude: 27, longitude: 30);
  static const Country unitedKingdom =
      Country(id: 826, code: 'GB', title: 'United Kingdom', latitude: 54, longitude: -2);
  static const Country guernsey = Country(id: 831, code: 'GG', title: 'Guernsey', latitude: 49.5, longitude: -2.56);
  static const Country jersey = Country(id: 832, code: 'JE', title: 'Jersey', latitude: 49.21, longitude: -2.13);
  static const Country isleOfMan =
      Country(id: 833, code: 'IM', title: 'Isle of Man', latitude: 54.23, longitude: -4.55);
  static const Country tanzaniaUnitedRepublicOf =
      Country(id: 834, code: 'TZ', title: 'Tanzania, United Republic of', latitude: -6, longitude: 35);
  static const Country unitedStates =
      Country(id: 840, code: 'US', title: 'United States', latitude: 38, longitude: -97);
  static const Country virginIslandsUS =
      Country(id: 850, code: 'VI', title: 'Virgin Islands, U.S.', latitude: 18.3333, longitude: -64.8333);
  static const Country burkinaFaso = Country(id: 854, code: 'BF', title: 'Burkina Faso', latitude: 13, longitude: -2);
  static const Country uruguay = Country(id: 858, code: 'UY', title: 'Uruguay', latitude: -33, longitude: -56);
  static const Country uzbekistan = Country(id: 860, code: 'UZ', title: 'Uzbekistan', latitude: 41, longitude: 64);
  static const Country venezuela = Country(id: 862, code: 'VE', title: 'Venezuela', latitude: 8, longitude: -66);
  static const Country wallisAndFutuna =
      Country(id: 876, code: 'WF', title: 'Wallis and Futuna', latitude: -13.3, longitude: -176.2);
  static const Country samoa = Country(id: 882, code: 'WS', title: 'Samoa', latitude: -13.5833, longitude: -172.3333);
  static const Country yemen = Country(id: 887, code: 'YE', title: 'Yemen', latitude: 15, longitude: 48);
  static const Country zambia = Country(id: 894, code: 'ZM', title: 'Zambia', latitude: -15, longitude: 30);

  static Map<String, Country> values = <String, Country>{
    'XX': unknown,
    'AF': afghanistan,
    'AL': albania,
    'AQ': antarctica,
    'DZ': algeria,
    'AS': americanSamoa,
    'AD': andorra,
    'AO': angola,
    'AG': antiguaAndBarbuda,
    'AZ': azerbaijan,
    'AR': argentina,
    'AU': australia,
    'AT': austria,
    'BS': bahamas,
    'BH': bahrain,
    'BD': bangladesh,
    'AM': armenia,
    'BB': barbados,
    'BE': belgium,
    'BM': bermuda,
    'BT': bhutan,
    'BO': bolivia,
    'BA': bosniaAndHerzegovina,
    'BW': botswana,
    'BV': bouvetIsland,
    'BR': brazil,
    'BZ': belize,
    'IO': britishIndianOceanTerritory,
    'SB': solomonIslands,
    'VG': virginIslandsBritish,
    'BN': brunei,
    'BG': bulgaria,
    'MM': burma,
    'BI': burundi,
    'BY': belarus,
    'KH': cambodia,
    'CM': cameroon,
    'CA': canada,
    'CV': capeVerde,
    'KY': caymanIslands,
    'CF': centralAfricanRepublic,
    'LK': sriLanka,
    'TD': chad,
    'CL': chile,
    'CN': china,
    'TW': taiwan,
    'CX': christmasIsland,
    'CC': cocosKeelingIslands,
    'CO': colombia,
    'KM': comoros,
    'YT': mayotte,
    'CG': congo,
    'CD': congoTheDemocraticRepublicOfThe,
    'CK': cookIslands,
    'CR': costaRica,
    'HR': croatia,
    'CU': cuba,
    'CY': cyprus,
    'CZ': czechRepublic,
    'BJ': benin,
    'DK': denmark,
    'DM': dominica,
    'DO': dominicanRepublic,
    'EC': ecuador,
    'SV': elSalvador,
    'GQ': equatorialGuinea,
    'ET': ethiopia,
    'ER': eritrea,
    'EE': estonia,
    'FO': faroeIslands,
    'FK': falklandIslandsMalvinas,
    'GS': southGeorgiaAndTheSouthSandwichIslands,
    'FJ': fiji,
    'FI': finland,
    'FR': france,
    'GF': frenchGuiana,
    'PF': frenchPolynesia,
    'TF': frenchSouthernTerritories,
    'DJ': djibouti,
    'GA': gabon,
    'GE': georgia,
    'GM': gambia,
    'PS': palestinianTerritoryOccupied,
    'DE': germany,
    'GH': ghana,
    'GI': gibraltar,
    'KI': kiribati,
    'GR': greece,
    'GL': greenland,
    'GD': grenada,
    'GP': guadeloupe,
    'GU': guam,
    'GT': guatemala,
    'GN': guinea,
    'GY': guyana,
    'HT': haiti,
    'HM': heardIslandAndMcDonaldIslands,
    'VA': holySeeVaticanCityState,
    'HN': honduras,
    'HK': hongKong,
    'HU': hungary,
    'IS': iceland,
    'IN': india,
    'ID': indonesia,
    'IR': iranIslamicRepublicOf,
    'IQ': iraq,
    'IE': ireland,
    'IL': israel,
    'IT': italy,
    'CI': ivoryCoast,
    'JM': jamaica,
    'JP': japan,
    'KZ': kazakhstan,
    'JO': jordan,
    'KE': kenya,
    'KP': koreaDemocraticPeoplesRepublicOf,
    'KR': southKorea,
    'KW': kuwait,
    'KG': kyrgyzstan,
    'LA': laoPeoplesDemocraticRepublic,
    'LB': lebanon,
    'LS': lesotho,
    'LV': latvia,
    'LR': liberia,
    'LY': libya,
    'LI': liechtenstein,
    'LT': lithuania,
    'LU': luxembourg,
    'MO': macao,
    'MG': madagascar,
    'MW': malawi,
    'MY': malaysia,
    'MV': maldives,
    'ML': mali,
    'MT': malta,
    'MQ': martinique,
    'MR': mauritania,
    'MU': mauritius,
    'MX': mexico,
    'MC': monaco,
    'MN': mongolia,
    'MD': moldovaRepublicOf,
    'ME': montenegro,
    'MS': montserrat,
    'MA': morocco,
    'MZ': mozambique,
    'OM': oman,
    'NA': namibia,
    'NR': nauru,
    'NP': nepal,
    'NL': netherlands,
    'AN': netherlandsAntilles,
    'AW': aruba,
    'NC': newCaledonia,
    'VU': vanuatu,
    'NZ': newZealand,
    'NI': nicaragua,
    'NE': niger,
    'NG': nigeria,
    'NU': niue,
    'NF': norfolkIsland,
    'NO': norway,
    'MP': northernMarianaIslands,
    'UM': unitedStatesMinorOutlyingIslands,
    'FM': micronesiaFederatedStatesOf,
    'MH': marshallIslands,
    'PW': palau,
    'PK': pakistan,
    'PA': panama,
    'PG': papuaNewGuinea,
    'PY': paraguay,
    'PE': peru,
    'PH': philippines,
    'PN': pitcairn,
    'PL': poland,
    'PT': portugal,
    'GW': guineaBissau,
    'TL': timorLeste,
    'PR': puertoRico,
    'QA': qatar,
    'RE': runion,
    'RO': romania,
    'RU': russia,
    'RW': rwanda,
    'SH': saintHelenaAscensionAndTristanDaCunha,
    'KN': saintKittsAndNevis,
    'AI': anguilla,
    'LC': saintLucia,
    'PM': saintPierreAndMiquelon,
    'VC': saintVincentTheGrenadines,
    'SM': sanMarino,
    'ST': saoTomeAndPrincipe,
    'SA': saudiArabia,
    'SN': senegal,
    'RS': serbia,
    'SC': seychelles,
    'SL': sierraLeone,
    'SG': singapore,
    'SK': slovakia,
    'VN': vietnam,
    'SI': slovenia,
    'SO': somalia,
    'ZA': southAfrica,
    'ZW': zimbabwe,
    'ES': spain,
    'EH': westernSahara,
    'SD': sudan,
    'SR': suriname,
    'SJ': svalbardAndJanMayen,
    'SZ': swaziland,
    'SE': sweden,
    'CH': switzerland,
    'SY': syrianArabRepublic,
    'TJ': tajikistan,
    'TH': thailand,
    'TG': togo,
    'TK': tokelau,
    'TO': tonga,
    'TT': trinidadTobago,
    'AE': unitedArabEmirates,
    'TN': tunisia,
    'TR': turkey,
    'TM': turkmenistan,
    'TC': turksAndCaicosIslands,
    'TV': tuvalu,
    'UG': uganda,
    'UA': ukraine,
    'MK': macedoniaTheFormerYugoslavRepublicOf,
    'EG': egypt,
    'GB': unitedKingdom,
    'GG': guernsey,
    'JE': jersey,
    'IM': isleOfMan,
    'TZ': tanzaniaUnitedRepublicOf,
    'US': unitedStates,
    'VI': virginIslandsUS,
    'BF': burkinaFaso,
    'UY': uruguay,
    'UZ': uzbekistan,
    'VE': venezuela,
    'WF': wallisAndFutuna,
    'WS': samoa,
    'YE': yemen,
    'ZM': zambia,
  };
}
