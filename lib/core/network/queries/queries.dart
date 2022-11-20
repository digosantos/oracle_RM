class Queries {
  static String getAllCharacters() => """
    query CharactersAtPage(\$page: Int) {
      characters(page: \$page) {
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
    query CharacterDetails(\$id: ID!, \$episodesIds: [ID!]!) {
      character(id: \$id) {
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
      episodesByIds(ids: \$episodesIds) {
        id
        name
        air_date
      }
    }
  """;
}
