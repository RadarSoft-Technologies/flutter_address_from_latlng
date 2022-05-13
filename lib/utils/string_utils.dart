/// A string class that contains some utils method
class StringUtils{
  /// This method return a string with max length from [lst] list
  String getMaxStringFromList(List<String> lst) {
    String maxAddress = '';
    for (String v in lst) {
      maxAddress = (maxAddress.length < v.length) ? v : maxAddress;
    }
    return maxAddress;
  }
}