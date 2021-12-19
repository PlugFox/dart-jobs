/// Максимальная ширина колонки с основным контентом
const double bodyWidth = 620; // or 540

// /// Ширина правой колонки с дополнительным контентом
//const double sidePaneWidth = 320; // or 256 or 316;

/// Отступ боковых панелей от краев экрана, между собой и от рельсы (Drawer)
const double sidePadding = 24;

/// Ширина выдвинутого Drawer'а в роли рельсы
/// На планшетах, в случае выдвижения, может быть больше и достигать 400 dip
const double railWidth = 320;

/// Максимально возможная ширина лейаута с правой панелью, но без учета Drawer'а
const double scaffoldWidth = sidePadding + bodyWidth + sidePadding; // + sidePaneWidth + sidePadding;

/// Минимальная ширина экрана для отображения выдвинутого Drawer'а в роли рельсы
const double scaffoldWithRail = railWidth + scaffoldWidth;
