final List<String> months = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

List<String> get generateYearsUntilNow {
  final int currentYear = DateTime.now().year;
  return List.generate(currentYear - 1900 + 1,(index) => (currentYear - index).toString());
}

abstract class DateManager {
  // ignore: non_constant_identifier_names
  static String get dd_MM_yyyy => 'dd/MM/yyyy';

  // ignore: non_constant_identifier_names
  static String get dd_MMMM_yyyy => 'dd MMMM yyyy';

  // ignore: non_constant_identifier_names
  static String get dd_MM_yyyy_HHmmss => 'dd-MM-yyyy HH:mm:ss';

  // ignore: non_constant_identifier_names
  static String get dd_MMM_yyyy => 'dd MMM yyyy';

  // ignore: non_constant_identifier_names
  static String get yyyy_MM_dd => 'yyyy-MM-dd';

  // ignore: non_constant_identifier_names
  static String get yyyy_MM_dd_HHmm => 'yyyy-MM-dd HH:mm';

  // ignore: non_constant_identifier_names
  static String get dd_MMM_yyyy_HHmmss => 'dd MMM yyyy, HH:mm:ss';

  // ignore: non_constant_identifier_names
  static String get ddMMyyyy => 'ddMMyyyy';

  // ignore: non_constant_identifier_names
  static String get dd_MM_yyyy_dashes => 'dd-MM-yyyy';

  static String get yearFormat => 'yyyy';

  static String get hourFormat => 'HH:mm';

  static String get dayFormat => 'EEEE';

  static String get dateFormatMMMM => 'MMMM';

  static String get dateFormatISO8601 => "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static String get dateFormatRFC3339 => "yyyy-MM-dd'T'HH:mm:ss'Z'";

  static String get dateFormatWithMilliseconds => "yyyy-MM-dd'T'HH:mm:ss.fff'Z'";

  static DateTime get getDateNow => DateTime.now();

  static DateTime get getFirstDate => DateTime(1950);

  static DateTime get getEndDate =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  static String get localId => 'id';
}
