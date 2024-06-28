// price.dart

class SewaPrices {
  static const Map<String, Map<String, int>> prices = {
    "Gitar": {
      "1 Hari": 80000,
      "2 Hari": 150000,
      "3 Hari": 200000,
    },
    "Bass": {
      "1 Hari": 80000,
      "2 Hari": 150000,
      "3 Hari": 200000,
    },
    "Keyboard": {
      "1 Hari": 100000,
      "2 Hari": 180000,
      "3 Hari": 250000,
    },
    "Ampli": {
      "1 Hari": 200000,
      "2 Hari": 300000,
      "3 Hari": 350000,
    },
  };

  static int? getPrice(String? instrument, String? duration) {
    if (instrument == null || duration == null) {
      return null;
    }
    return prices[instrument]?[duration];
  }
}


class StudioPrice {
  static double calculateTotalPrice(String? duration) {
    if (duration == null) {
      return 0.0;
    }
    switch (duration) {
      case "1 jam":
        return 45000;
      case "2 jam":
        return 80000;
      case "3 jam":
        return 120000;
      default:
        return 0.0;
    }
  }
}

class RecordingPrice {
  static double calculateTotalPrice(String? duration) {
    if (duration == null) {
      return 0.0;
    }
    switch (duration) {
      case "1 jam":
        return 150000;
      case "2 jam":
        return 270000;
      default:
        return 0.0;
    }
  }
}
