
extension DateExtension on String {
  String toMonthNumber() {
    if (this.isEmpty) return '';

    const monthMap = {
      'Januari': 1,
      'Februari': 2,
      'Maret': 3,
      'April': 4,
      'Mei': 5,
      'Juni': 6,
      'Juli': 7,
      'Agustus': 8,
      'September': 9,
      'Oktober': 10,
      'November': 11,
      'Desember': 12,
    };
    return monthMap[this].toString();
  }

  String toMonthName() {
    if (this.isEmpty) return '';
    const monthMap = {
      1: 'Januari',
      2: 'Februari',
      3: 'Maret',
      4: 'April',
      5: 'Mei',
      6: 'Juni',
      7: 'Juli',
      8: 'Agustus',
      9: 'September',
      10: 'Oktober',
      11: 'November',
      12: 'Desember',
    };

    final monthInt = int.tryParse(this);
    if (monthInt == null || !monthMap.containsKey(monthInt)) {
      return '';
    }

    return monthMap[monthInt] ?? '';
  }
}
