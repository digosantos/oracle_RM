enum Routes {
  root('/'),
  charactersListing('/characters_listing'),
  characterDetails('/character_details'),
  favorites('/favorites');

  final String routeName;
  const Routes(this.routeName);
}
