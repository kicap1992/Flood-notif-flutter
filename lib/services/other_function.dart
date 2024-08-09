import 'package:intl/intl.dart';

class OtherFunction {
  int umur(String tanggalLahir) {
    // change tanggalLahir to DateTime
    DateTime date = DateTime.parse(tanggalLahir);
    // get current date
    DateTime now = DateTime.now();
    // get difference in year
    int year = now.year - date.year;
    return year;
  }

  String commaFormat(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  String changeMonth(String month) {
    switch (month) {
      case 'Januari':
        return '01';
      case 'Februari':
        return '02';
      case 'Maret':
        return '03';
      case 'April':
        return '04';
      case 'Mei':
        return '05';
      case 'Juni':
        return '06';
      case 'Juli':
        return '07';
      case 'Agustus':
        return '08';
      case 'September':
        return '09';
      case 'Oktober':
        return '10';
      case 'November':
        return '11';
      case 'Desember':
        return '12';
      default:
        return '';
    }
  }

  String changeMonthYear(String s) {
    // get the last 2 digits
    String month = s.substring(s.length - 2);
    // get the first 4 digits
    String year = s.substring(0, 4);
    // return the month and year
    switch (month) {
      case '01':
        return 'Januari $year';
      case '02':
        return 'Februari $year';
      case '03':
        return 'Maret $year';
      case '04':
        return 'April $year';
      case '05':
        return 'Mei $year';
      case '06':
        return 'Juni $year';
      case '07':
        return 'Juli $year';
      case '08':
        return 'Agustus $year';
      case '09':
        return 'September $year';
      case '10':
        return 'Oktober $year';
      case '11':
        return 'November $year';
      case '12':
        return 'Desember $year';
      default:
        return '';
    }
  }

  String getDayOfWeek(String date) {
    DateTime dateTime = DateTime.parse(date);
    List<String> daysOfWeek = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    return daysOfWeek[dateTime.weekday - 1];
  }

  String formatDateString(String dateString) {
    // Remove the "T" and replace it with " | "
    String formattedString = dateString.replaceAll('T', '\n');

    // Remove the ".000Z"
    formattedString = formattedString.replaceAll('.000Z', '');

    // Parse the input string to DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Get the day of the week in Indonesian
    String dayOfWeek = DateFormat.EEEE('id_ID').format(dateTime);

    // Add the day of the week to the formatted string
    formattedString = '$formattedString\n$dayOfWeek';

    return formattedString;
  }

  String formatDateString2(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    // Adjust for the timezone if needed (this example assumes UTC)
    dateTime = dateTime.toLocal();

    // Format the DateTime object to match your database format
    String dbDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return dbDate;
  }

  String timeNameRemover(String time) {
    List<String> parts = time.split(' ');
    String timePart = parts[0];

    // Split the time part into hours, minutes, and seconds
    List<String> timeComponents = timePart.split(':');
    String hours = timeComponents[0];
    String minutes = timeComponents[1];

    // Create the new time string without seconds and with a period instead of a colon
    String newTimeStr = '$hours.$minutes';

    return newTimeStr;
  }
}
