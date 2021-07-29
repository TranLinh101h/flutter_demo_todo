[![Tests](https://github.com/ltdangkhoa/flutter_demo_todo/actions/workflows/test.yml/badge.svg)](https://github.com/ltdangkhoa/flutter_demo_todo/actions/workflows/test.yml)

# demo

App Functionality:

- Display a list of todo items
- Add a todo item
- Delete a todo item
- Mark a todo item as done, or not done.

# Requirements

```
flutter channel master
flutter upgrade
```

# Run the app

Make sure to clean cache if there is any previous build

```
flutter clean
```

To run app with browser

```
flutter run -d chrome
```

To run app with other available

```
flutter run
```

# Run test

App come with widget test and can be run as

```
flutter test
```

Integration test with native device

```
flutter test integration_test/app_test.dart -d macos
```

Integration test with browser need more setup on driver. 

To test for web, determine which browser you want to test against and download the corresponding web driver:

- Chrome: Download ChromeDriver [https://chromedriver.chromium.org/downloads] 
- Firefox: Download GeckoDriver [https://github.com/mozilla/geckodriver/releases]
- Safari: Safari can only be tested on a Mac; the SafariDriver is already installed on Mac machines.
- Edge Download EdgeDriver [https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/] 

Launch the WebDriver, for example:

```
./chromedriver --port=4444
flutter drive --target=test_driver/integration_test.dart --browser-name=chrome --release
```


