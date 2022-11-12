class Queries {
  static String getAllCharacters() => """
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
}
