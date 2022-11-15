class Queries {
  static String getAllCharacters() => """
  query {
    characters {
      info {
        pages
        next
        prev
      }
      results {
        id
        name
        image
        species
        episode {
          id
        }
      }
    }
  }
  """;

  static String getCharacterDetails() => """
    query {
      character(\$id: String!) {
          id
          name
          image
          species
          status
          origin {
            name
          }
          location {
            name
          }
          created
      }
      episodesByIds(\$ids: [String!]!) {
        name
        air_date
      }
    }
   """;
}
