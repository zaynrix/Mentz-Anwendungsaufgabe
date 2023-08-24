class Endpoints {
  Endpoints._();

  static String baseUrl =
      "https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=en&outputFormat=RapidJSON&type_sf=any";

  // receiveTimeout
  static const int receiveTimeout = 30000;

  // connectTimeout
  static const int connectionTimeout = 30000;

// Offset & limited
  static const int offset = 0;
  static const int limit = 20;
}
