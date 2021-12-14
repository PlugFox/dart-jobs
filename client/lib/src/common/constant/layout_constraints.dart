/// Максимальная ширина ленты
const double feedWidth = 620; // or 540

/// Ширина правой колонки
const double sideBarWidth = 320; // or 256 or 316;

/// Отступ боковых панелей от ленты
const double sidePadding = 24;

/// Минимальная ширина выдвинутого Drawer'а в роли рельсы
const double minRailWidth = 320;

/// Максимальная ширина выдвинутого Drawer'а в роли рельсы
const double maxRailWidth = 400;

/// Минимальная ширина экрана для отображения Drawer'а в роли рельсы
const double withRail = minRailWidth + sidePadding + feedWidth + sidePadding;

/// Максимально возможная ширина лейаута без учета Drawer'а
const double maxScaffoldWidth = sidePadding + feedWidth + sidePadding + sideBarWidth + sidePadding;

/// Минимальная ширина экрана необходимая для отображения ленты с правой панелью
const double withRightPanel = minRailWidth + maxScaffoldWidth;
