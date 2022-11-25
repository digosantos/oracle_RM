class Queries {
  static String getAllCharacters() => """
    query CharactersAtPage(\$page: Int, \$filter: FilterCharacter) {
      characters(page: \$page, filter: \$filter) {
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

  static String getCharactersById() => """
    query CharactersByIds(\$ids: [ID!]!) {
      charactersByIds(ids: \$ids) {
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
