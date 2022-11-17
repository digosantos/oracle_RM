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
        name
        air_date
      }
    }
  """;
}
