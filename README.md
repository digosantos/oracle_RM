# oracle_rm

### THA Loft

## Passos para executar a aplicação:
```shell
$ git clone git@github.com:digocse/oracle_RM.git
$ cd oracle_RM
$ flutter clean
$ flutter pub get
$ flutter run
```
Instalação do Flutter (se necessário): https://docs.flutter.dev/get-started/install

## Passos para executar os testes:
```shell
$ flutter test
```

## CI flow:
```shell
$ Tests autommatically run through GH actions
$ You can check it here: https://github.com/digocse/oracle_RM/actions 
```

## Arquitetura do Projeto
- Clean Architecture
O padrão de arquitetura utilizado incentiva a separação de responsabilidades de cada módulo 
  e facilita o processo de construção das regras de negócio e aplicação de boas práticas
  de TDD (Test Driven Development).
  
Iniciando a construção do projeto pela camada "domain", construí os casos de uso (usecases)
necessários para a execução das principais funcionalidades do aplicativo. Naturalmente, foram
desenvovidas em seguida a camada de data para recuperação e persistência de recursos internos
e externos.

Concluída a camada de dados, trabalhei da camada de UI. Mais especificamente, foram desenvolvidos 
os principais recursos para o correto gerenciamento de estado das telas.

Por fim, foram criadas as telas e componentes que compõem a interface junto com ações necessárias
para entregar a parte de UX.

Foram abstraídos recursos relacionados as entidades Characters e Favorites, pensando na possível
reutilização das funcionalidades implementadas.

### Organização e Esboço
https://excalidraw.com/#json=iJjuWn3TRgJymUYQXhOLf,MbOHCs32pOsf4evnQOX9cQ
<img width="438" alt="Screen Shot 2022-11-25 at 19 43 24" src="https://user-images.githubusercontent.com/22969298/204065756-f95ed256-3dc1-4883-ad08-ddf0a5f8b601.png">
![Screen Shot 2022-11-25 at 19 44 16](https://user-images.githubusercontent.com/22969298/204065760-4bef997d-8883-4970-befc-28b716b9ee6d.png)


## Bibliotecas Externas
***
equatable
Utilizada para comparação de objetos. Com essa biblioteca, não se faz necessário escrever
manualmente a comparação entre hashcode dos atributos de uma classe.
***
dartz
Programação funcional. Utilizado para encapsular resultados bem sucedidos ou falhas
após execução de métodos sem a necessidade de gerenciar estados.
***
build_runner
Auxilia na geração de arquivos de teste que funcionarão como stubs nos testes.
***
graphql
Utilizado como linguagem de consulta de https://rickandmortyapi.com/graphql
De acordo com os requisitos solicitados e estudo de API, escolhi graphQL pela facilidade
em trazer informações dentro da mesma requisição (e.g. dados do personagem e dados específicos
dos episódios), além de enxugar a maioria dos payloads executados buscando somente as informações
necessárias para montar a tela (semelhante à um BFF).
***
shared_preferences
Armazenamento interno dos favoritos
***
flutter_bloc
Gerenciamento de estado de tela
***
get_it
Localizador de serviços. Auxilia na utilização de recursos em qualquer lugar do app de maneira
otimizada e evita que a camada de UI tenha dependências de outras camadas.
***
go_router
Utilizado para navegação entre páginas do app. 
***
mockito
Facilita a criação de mocks para serem utilizados nos testes. 
***

## Melhorias
Tendo em vista a finalidade do teste, o prazo de entrega e rotina pessoal, dediquei meus recursos
principalmente à organização do código, arquitetura e cobertura de testes. Abri mão do refinamento 
de alguns recursos que certamente fariam parte do desenvolvimento de um aplicativo para produção.

Deixo listado abaixo, alguns pontos de melhoria:
- Acessibilidade (aplicação de nodes semânticos)
- Estilos de fonte
- Parsing de data/horário
- Internacionalização
- Redesign do app
- Tratamento de cenários de erro e telas sem informação
- Logo do app
