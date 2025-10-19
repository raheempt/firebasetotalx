import 'dart:developer' as developer;

const String _red = '\x1B[31m'; 
const String _green = '\x1B[32m'; 
const String _yellow = '\x1B[33m'; 
const String _reset = '\x1B[0m';  


void logInfo(String message) {
  developer.log('$_green$message$_reset', name: 'INFO');
}

void logWarning(String message) {
  developer.log('$_yellow$message$_reset', name: 'WARNING');
}

void logError(String message) {
  developer.log('$_red$message$_reset', name: 'ERROR');
}