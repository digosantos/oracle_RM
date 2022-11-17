enum Routes {
  root('/'),
  charactersListing('/characters_listing'),
  characterDetails('/character_details');

  final String routeName;
  const Routes(this.routeName);
}
