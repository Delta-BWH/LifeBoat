
import 'package:backendless_sdk/backendless_sdk.dart';

class OperationsHelper {

  // Singleton
  static final OperationsHelper _singleton = OperationsHelper._internal();

  factory OperationsHelper() {
    return _singleton;
  }

  OperationsHelper._internal();

  // Properties
  String currentObjectId;

  // Methods
  String createObjectCodeForTable(String tableName) {
    return """
  Map<dynamic, dynamic> newObject =
    {"codegen": "new object"};

  Backendless.data.of("$tableName").save(newObject)
    .then( (savedObject) {
      // handle response
    });
  """;
  }

  String updateObjectCodeForTable(String tableName) {
    String id = currentObjectId != null ? currentObjectId : "";

    return """
  Map<dynamic, dynamic> object =
    {"codegen": "updatedObject",
    "objectId": "$id"};

  Backendless.data.of("$tableName").save(object)
    .then( (savedObject) {
      // handle response
    });
    """;
  }

  String deleteObjectCodeForTable(String tableName) {
    String id = currentObjectId != null ? currentObjectId : "";

    return """
  Map<dynamic, dynamic> entity =
    {"objectId": "$id"};

  Backendless.data.of("$tableName").remove(entity: entity)
    .then( (removed) {
      // handle response
    });
    """;
  }

  String basicFindObjectCodeForTable(String tableName) {
    return """
  Backendless.data.of("$tableName").find()
    .then( (foundObjects) {
      // handle response
    });
    """;
  }

  String findFirstObjectCodeForTable(String tableName) {
    return """
  Backendless.data.of("$tableName").findFirst()
    .then( (firstObject) {
      // handle response
    });
    """;
  }

  String findLastObjectCodeForTable(String tableName) {
    return """
  Backendless.data.of("$tableName").findLast()
    .then( (firstObject) {
      // handle response
    });
    """;
  }

  String findSortObjectsCodeForTable(String tableName, List<String> sortBy) {

    final mappedSortBy = sortBy
      .map( (property) {
        return "\"" + property + "\"";
      })
      .toList();

    return """
  final queryBuilder = DataQueryBuilder();
  queryBuilder.sortBy = $mappedSortBy;

  Backendless.data.of("$tableName")
    .find(queryBuilder)
    .then( (foundObjects) {
      // handle response
    });
    """;
  }

  String findWithRelatedObjectsCodeForTable(String tableName, List<String> relations) {

    final mappedProperties = relations
      .map( (property) {
        return "\"" + property + "\"";
      })
      .toList();

    return """
  final queryBuilder = DataQueryBuilder();
  queryBuilder.related = $mappedProperties;

  Backendless.data.of("$tableName")
    .find(queryBuilder)
    .then( (foundObjects) {
      // handle response
    });
    """;
  }
}
