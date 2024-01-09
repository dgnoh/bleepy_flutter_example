class LauncherUrlsModel {
  String cowUrl;
  String coffeeUrl;
  String cardUrl;

  LauncherUrlsModel({required this.cowUrl, required this.coffeeUrl, required this.cardUrl});

  LauncherUrlsModel replaceUserKey(String userKey) {
    String updatedCowUrl = cowUrl.replaceAll('{userKey}', userKey);
    String updatedCoffeeUrl = coffeeUrl.replaceAll('{userKey}', userKey);
    String updatedCardUrl = cardUrl.replaceAll('{userKey}', userKey);

    return LauncherUrlsModel(
      cowUrl: updatedCowUrl,
      coffeeUrl: updatedCoffeeUrl,
      cardUrl: updatedCardUrl,
    );
  }
}