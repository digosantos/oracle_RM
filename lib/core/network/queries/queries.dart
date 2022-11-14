class Queries {
  static String getCharacterDetails() => """
    query {
      character(\$id: String!) {
          id
          name
          image
          species
          episode {
            id
          }
      }
    }
   """;

  static String getAllCharacters() => """
  query {
    characters {
      results {
        id
      }
    }
  }
  """;
}
