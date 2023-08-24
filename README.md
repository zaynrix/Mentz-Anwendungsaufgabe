Sure, here's the corrected version of your README:

```markdown
# MENTZ

![Logo](https://github.com/zaynrix/Mentz-Anwendungsaufgabe/assets/28483872/55473802-7ad9-4526-a556-1bbdf8949cde)

## Folder Structure

The project follows an organized structure based on features, using the MVC pattern.

```
|-lib|
     |     
     | Registration | models -> Feature-specific models 
                    | screens -> Subfolders for sub-features if applicable
                    | providers -> Required providers for the feature 
                    | repositories -> Corresponding repositories for providers
                    | widgets -> Widgets directly related to the feature 
```

## Usage

Access resources using the resource manager:

```
// Colors
ColorManager.primary;

// Images
ImageAssets.splashLogoPng;
SVGAssets.homeSvg;
IconAssets.arrowRight;
```


// Font weights
FontWeightManager.black;

// Text strings
AppString.bankWithdraw;
```

## Navigation

Navigation in the project is built using the `OnGenerateRoute` approach:

```dart
// Push named route
sl<NavigationService>().navigateTo(Routes.home);

// Push named route and remove previous routes
sl<NavigationService>().navigateToAndRemove(Routes.home);

// Pop navigation stack
sl<NavigationService>().pop();
```

## Included Packages

The project utilizes the following packages for various features and functionalities:

- **flutter_launcher_icons:** Generates launcher icons for different platforms
- **cupertino_icons:** Provides iOS-styled icons
- **flutter_svg:** Renders SVG images
- **provider:** Manages app state using state management
- **rename:** Renames identifiers like files and folders
- **dio:** A powerful HTTP client for making API requests
- **flutter_screenutil:** Responsive design library for Flutter
- **get_it:** A service locator for dependency injection
- **shimmer:** Creates shimmering effects for loading content
