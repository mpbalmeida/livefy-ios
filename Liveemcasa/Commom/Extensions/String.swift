//
//  String.swift
//  Liveemcasa
//
//  Created by Daniel Maia dos Passos on 05/04/20.
//  Copyright © 2020 Daniel Maia dos Passos. All rights reserved.
//

import Foundation
import UIKit

extension String {
  
  // MARK: - Date extenstions
  static func decodePDFInt8CString(_ cString: UnsafePointer<Int8>?, repairingInvalidCodeUnits: Bool = false) -> String? {
    guard let cString = cString else { return nil }
    let str  = cString.withMemoryRebound(to: UInt8.self, capacity: 1) {
      (bytes: UnsafePointer<UInt8>) in
      return String.decodeCString(bytes, as: UTF8.self, repairingInvalidCodeUnits:repairingInvalidCodeUnits)
    }
    return str?.result
  }
  
  static func formmatedMoney(value:Double) -> String {
    return String(format: "%.02f", value)
  }
  
  static func formmatedDMYDate(date:Date) -> String {
    
    return String(format: "%02d-%02d-%02d", date.day, date.month, date.year)
    
  }
  
  static func formmatedYYYYMMDDDate(date:Date) -> String {
    
    return String(format: "%02d-%02d-%02d", date.year, date.month, date.day)
    
  }
  
  static func formmatedYYYYMMDate(date:Date) -> String {
    
    return String(format: "%02d-%02d", date.year, date.month)
    
  }
  
  static func formmatedYYYYMMDDTDate(date:Date) -> String {
    
    return String(format: "%02d-%02d-%02d'T'%02d:%02d:%02d",
                  date.year,
                  date.month,
                  date.day,
                  date.hour,
                  date.minute,
                  date.second)
    
  }
  
  static func addZeroLeftDecimalPlaces(value: Int, countDecimalPlaces: Int = 1) -> String {
    return String(format: "%0\(countDecimalPlaces)d", value)
  }
  
  /// SwifterSwift: Date object from string of date format.
  ///
  ///    "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
  ///    "not date string".date(withFormat: "yyyy-MM-dd") -> nil
  ///
  /// - Parameter format: date format.
  /// - Returns: Date object from string (if applicable).
  public func date(withFormat format: String? = "yyyy-MM-dd") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    return dateFormatter.date(from: self)
  }

  // MARK: - CPF/CNPJ Regex
  
  var isCPF: Bool {
    let numbers = compactMap({Int(String($0))})
    guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
    let soma1 = 11 - ( numbers[0] * 10 +
      numbers[1] * 9 +
      numbers[2] * 8 +
      numbers[3] * 7 +
      numbers[4] * 6 +
      numbers[5] * 5 +
      numbers[6] * 4 +
      numbers[7] * 3 +
      numbers[8] * 2 ) % 11
    let dv1 = soma1 > 9 ? 0 : soma1
    let soma2 = 11 - ( numbers[0] * 11 +
      numbers[1] * 10 +
      numbers[2] * 9 +
      numbers[3] * 8 +
      numbers[4] * 7 +
      numbers[5] * 6 +
      numbers[6] * 5 +
      numbers[7] * 4 +
      numbers[8] * 3 +
      numbers[9] * 2 ) % 11
    let dv2 = soma2 > 9 ? 0 : soma2
    return dv1 == numbers[9] && dv2 == numbers[10]
  }
  
  var isCNPJ: Bool {
    let numbers = compactMap({Int(String($0))})
    guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
    let soma1 = 11 - ( numbers[11] * 2 +
      numbers[10] * 3 +
      numbers[9] * 4 +
      numbers[8] * 5 +
      numbers[7] * 6 +
      numbers[6] * 7 +
      numbers[5] * 8 +
      numbers[4] * 9 +
      numbers[3] * 2 +
      numbers[2] * 3 +
      numbers[1] * 4 +
      numbers[0] * 5 ) % 11
    let dv1 = soma1 > 9 ? 0 : soma1
    let soma2 = 11 - ( numbers[12] * 2 +
      numbers[11] * 3 +
      numbers[10] * 4 +
      numbers[9] * 5 +
      numbers[8] * 6 +
      numbers[7] * 7 +
      numbers[6] * 8 +
      numbers[5] * 9 +
      numbers[4] * 2 +
      numbers[3] * 3 +
      numbers[2] * 4 +
      numbers[1] * 5 +
      numbers[0] * 6 ) % 11
    let dv2 = soma2 > 9 ? 0 : soma2
    return dv1 == numbers[12] && dv2 == numbers[13]
  }
  
  // MARK: - CEP Validation
  var isCEPValid: Bool {
    let unmaskedCEP = self.removingDigitMask()
    
    if unmaskedCEP.count > 2 {
      
      if let numberPrefixCEP = Int(unmaskedCEP), numberPrefixCEP >= 1000000 {
        return true
      }
    } else {
      return true
    }
    
    return false
  }
  
  // MARK: - Email Regex
  
  var isEmailValid: Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
  }
  
  // MARK: - Phone Regex
  
  var isValidPhone: Bool {
    let phoneRegex = "\\([1-9]{2}\\)+ 9[0-9]{4}-[0-9]{4}"
    return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
  }
  
  var isValidLandlinePhone: Bool {
    let phoneRegex = "^(?:\\(?([1-9][0-9])\\)?\\s?)?(?:(\\d|[2-8]\\d{3})\\-?(\\d{4}))$"
    return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
  }
  
  var getDDDLandlinePhone: String {
    return String(self.unmaskPhoneNumber().prefix(2))
  }
  
  var getNumberLandlinePhone: String {
    return String(self.unmaskPhoneNumber().suffix(8))
  }
  
  // MARK: - International Phone
  
  func isValidInternationalPhone() -> Bool {
    let phoneRegex = "\\+[0-9]{1,3}-[0-9]{4,12}"
    return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
  }
  
  func ddiOfInternationalPhone() -> String? {
    guard self.isValidInternationalPhone() else { return nil }
    guard let ddi = self.split(separator: "-").first else { return nil }
    return String(ddi)
  }
  
  func internationalPhoneWithoutDdi() -> String? {
    guard self.isValidInternationalPhone() else { return nil }
    guard let phone = self.split(separator: "-").last else { return nil }
    return String(phone)
  }
  
  // MARK: - IsEmpty
  
  var isEmptyString: Bool {
    return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
  }
  
  // MARK: - Encoded / Decoded
  
  func encodeString() -> String? {
    let allowCharacters = CharacterSet.alphanumerics
    let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowCharacters)
    
    return encodedString
  }
  
  func decodeString() -> String? {
    let text = self.replacingOccurrences(of: "+", with: " ")
    
    return text.removingPercentEncoding!
  }
  
  func encodeURL() -> String? {
    let encodedString = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
    return encodedString!
  }
  
  // MARK: - Mask
  func currencyInputFormatting() -> String {
    
    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.currencySymbol = "R$ "
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.locale = Locale(identifier: "pt_BR")
    
    var amountWithPrefix = self
    
    do {
      let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                        options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                        range: NSRange(location: 0, length: self.count),
                                                        withTemplate: "")
      
      let double = (amountWithPrefix as NSString).doubleValue
      number = NSNumber(value: (double / 100))
      
      guard number != 0 as NSNumber else {
        return "R$ 0,00"
      }
    } catch {
      return "R$ 0,00"
    }
    
    return formatter.string(from: number)!
  }
  
  func currencyInputFormatting(localeIdentifier: String = "pt_BR", symbol: String? = nil, fractionDigits: Int = 2) -> String? {
    let defaultValue = NSNumber(value: 0)
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.locale = Locale(identifier: localeIdentifier)
    formatter.maximumFractionDigits = fractionDigits
    formatter.minimumFractionDigits = fractionDigits
    formatter.paddingPosition = .afterPrefix
    formatter.paddingCharacter = " "
    if let symbol = symbol {
      formatter.currencySymbol = symbol
    }
    if let number = self.toRawNumber(), let formattedNumber = formatter.string(from: number) {
      return formattedNumber
    } else {
      return formatter.string(from: defaultValue)
    }
  }
  
  func toRawNumber(_ divisor: Double = 100) -> NSNumber? {
    do {
      var amountWithPrefix = self
      let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                        options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                        range: NSRange(location: 0, length: count),
                                                        withTemplate: "")
      if let double = Double(amountWithPrefix) {
        let number = NSNumber(value: (double / divisor))
        
        return number
      }
      return nil
    } catch {
      return nil
    }
  }
  
  func currencyInputFormattingWithNumberNegative() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.currencySymbol = "R$ "
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.locale = Locale(identifier: "pt_BR")
    return formatter.string(from: NSNumber(value: Double(self) ?? 0.0))!
  }
  
  func applyBarCodeMask() -> String {
    let kDigitMaskCIP: String = "########## ########### ########### # ##############"
    let kDigitMaskDealership: String = "############ ############ ############ ############"
    let kDealershipDigit: Character = "8"
    
    let digitMask = self.first == kDealershipDigit ? kDigitMaskDealership : kDigitMaskCIP
    
    let maskedText = self.applyingDigitMask(digitMask)
    return maskedText
  }
  
  func applyingDigitMask(_ mask: String) -> String {
    let digits = removingDigitMask()
    var masked = ""
    var digitIndex = 0, maskIndex = 0
    while maskIndex < mask.count && digitIndex < digits.count {
      var char = mask[mask.index(mask.startIndex, offsetBy: maskIndex)]
      if char == "#" {
        char = digits[digits.index(digits.startIndex, offsetBy: digitIndex)]
        digitIndex += 1
      }
      masked.append(char)
      maskIndex += 1
    }
    
    return masked
  }
  
  func removingDigitMask() -> String {
    return replacingOccurrences( of:"\\D", with: "", options: .regularExpression)
  }
  
  func removingCurrencyMask() -> String {
    var clearValue = self.replacingOccurrences(of: "R$", with: "")
    clearValue = clearValue.replacingOccurrences(of: ".", with: "")
    clearValue = clearValue.replacingOccurrences(of: ",", with: ".")
    clearValue = clearValue.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return clearValue
  }

  func removeCurrency() -> Double? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    if let number = formatter.number(from: self) {
      return number.doubleValue
    }
    return nil
  }
  
  /// Obfuscate Phone Number with ***** on first block numbers
  ///
  /// - Returns: obfuscated phone number
  func obfuscatePhoneNumber() -> String {
    if self.isEmpty {
      return self
    }
    
    let end = self.firstIndex(of: "-") ?? self.startIndex
    let start = self.index(end, offsetBy: -5)
    let range = start..<end
    return self.replacingCharacters(in: range, with: "*****")
  }
  
  /// Obfuscate Foreign Phone Number with ***** on first block numbers
  ///
  /// - Returns: obfuscated phone number
  func obfuscateForeignPhoneNumber() -> String {
    if self.isEmpty {
      return self
    }
    
    let numberParts = self.split(separator: " ")
    let ddi = numberParts.first
    let number = numberParts.last
    let formattAux = "\(number ?? "")"
    
    let offset = max(-4, -(formattAux.count-4))
    let end = formattAux.index(formattAux.endIndex, offsetBy: offset)
    let range = formattAux.startIndex..<end
    
    let mask = formattAux[range].map({_ in "*" }).joined()
    let replaced = formattAux.replacingCharacters(in: range, with: mask)
    return "\(ddi ?? "") \(replaced)"
  }
  
  /// Remove phone number mask (country code and hyphen)
  ///
  /// - Returns: phone number without +55 or -
  func unmaskCellNumber() -> String {
    return replacingOccurrences(of: "+55", with: "").replacingOccurrences(of: "-", with: "")
  }
  
  func unmaskPhoneNumber() -> String {
    var clearValue = self.replacingOccurrences(of: "+55", with: "")
    clearValue = clearValue.replacingOccurrences(of: "(", with: "")
    clearValue = clearValue.replacingOccurrences(of: ")", with: "")
    clearValue = clearValue.replacingOccurrences(of: "-", with: "")
    clearValue = clearValue.replacingOccurrences(of: " ", with: "")
    clearValue = clearValue.trimmingCharacters(in: .whitespacesAndNewlines)
    return clearValue
  }
  
  
  // MARK: - IsNumber
  
  var onlyDigits: String {
    return components(separatedBy: CharacterSet.decimalDigits.inverted)
      .joined()
  }
  
  var isNumber: Bool {
    return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }
  
  // MARK: - base64
  
  func stringToBase64() -> String? {
    guard let data = self.data(using: String.Encoding.utf8) else {
      return nil
    }

    return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
  }
  
  func base64ToString() -> String? {
    guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
      return nil
    }

    return String(data: data as Data, encoding: String.Encoding.utf8)
  }
  
  func accountType() -> String? {
    if self.isEmpty {
      return self
    }
    var account = self
    let last = self.suffix(1)
    account.removeLast()
    account = (account + "-" + last)
    
    return account
  }
  
  // MARK: - Date Management
  
  func formatDateString() -> String {
    if self.contains("-") {
      let year = self.split(separator: "-")[0]
      let month = self.split(separator: "-")[1]
      let day = self.split(separator: "-")[2]
      
      return "\(day)/\(month)/\(year)"
    } else if self.contains("/") {
      let year = self.split(separator: "/")[2]
      let month = self.split(separator: "/")[1]
      let day = self.split(separator: "/")[0]
      
      return "\(year)-\(month)-\(day)"
    } else {
      return ""
    }
  }
  
  func formatYYYYMMDDTDateString() -> String {
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterPrint.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatYYYYMMDDDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy-MM-dd"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet2 = DateFormatter()
    dateFormatterGet2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterGet2.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet3 = DateFormatter()
    dateFormatterGet3.dateFormat = "yyyy-MM-dd"
    dateFormatterGet3.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet2.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet3.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYWihtouSSSDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet2 = DateFormatter()
    dateFormatterGet2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatterGet2.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet3 = DateFormatter()
    dateFormatterGet3.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    dateFormatterGet3.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet4 = DateFormatter()
    dateFormatterGet4.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatterGet4.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet5 = DateFormatter()
    dateFormatterGet5.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    dateFormatterGet5.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet2.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet3.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet4.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet5.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYWithHHmm() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet2 = DateFormatter()
    dateFormatterGet2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatterGet2.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy - HH:mm"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet2.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYWithHHmmAndAt(customFormat: String = "dd/MM/yyyy 'às' HH:mm") -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet2 = DateFormatter()
    dateFormatterGet2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatterGet2.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet3 = DateFormatter()
    dateFormatterGet3.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    dateFormatterGet3.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet4 = DateFormatter()
    dateFormatterGet4.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    dateFormatterGet4.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet5 = DateFormatter()
    dateFormatterGet5.dateFormat = "dd/MM/yyyy"
    dateFormatterGet5.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = customFormat
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet2.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet3.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet4.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    if let date = dateFormatterGet5.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYHHMMSSDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "ddMMyyyyHHmmss"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYHHMMSSwithHDateString() -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy - HH'h'mm"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatHHMMLiteralDateString() -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "HH:mm"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      let strDate = String(format: "%dh", date.hour)
      
      if date.minute > 0 && date.minute < 10 {
        return String(format: "%@0%d", strDate, date.minute)
      } else if date.minute > 0 && date.minute > 9 {
        return String(format: "%@%d", strDate, date.minute)
      } else {
        return strDate
      }
    }
    
    return ""
  }
  
  func formatDDMMYYYYWithoutHHmm() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatterGet.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterGet2 = DateFormatter()
    dateFormatterGet2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatterGet2.calendar = Calendar(identifier: .gregorian)
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy - HH:mm"
    dateFormatterPrint.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatterGet.date(from: self) {
      let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
      let formatedDate = Calendar.current.date(from: components)
      
      let result = dateFormatterPrint.string(from: formatedDate!)
      if !result.isEmpty {
        return String(result.split(separator: " ")[0])
      }
    }
    
    if let date = dateFormatterGet2.date(from: self) {
      let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
      let formatedDate = Calendar.current.date(from: components)
      
      let result = dateFormatterPrint.string(from: formatedDate!)
      if !result.isEmpty {
        return String(result.split(separator: " ")[0])
      }
    }
    
    return ""
  }
  
  func toDate(format: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.date(from: self)
  }
  
  public func isValidDate() -> Bool {
    if !self.isEmpty {
      if self.count == 10 {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "pt_BR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        
        if self.contains("/") {
          dateFormatter.dateFormat = "dd/MM/yyyy"
        } else {
          dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        
        if dateFormatter.date(from: self) != nil {
          return true
        } else {
          return false
        }
      } else {
        return false
      }
    }
    
    return false
  }
  
  public func isMoreThenYears(format: String, year: Int) -> Bool {
    if !self.isEmpty {
      let dateFormatter = DateFormatter()
      if self.count == 10 {
        dateFormatter.dateFormat = format
        dateFormatter.locale =  Locale(identifier: "pt_BR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        
        if let date = dateFormatter.date(from: self) {
          return date.validateYears(year: year)
        } else {
          return false
        }
      } else {
        return false
      }
    }
    
    return true
  }
  
  // Returns time by passing each of the elements
  func hourWithElements() -> Date {
    let timeSplit = self.split(separator: ":")
    guard let hourDate = Date(hour: Int(timeSplit[0]), minute: Int(timeSplit[1]), second: Int(timeSplit[2])) else {
      return Date()
    }
    return hourDate
  }
  
  // MARK: - Manipulate string
  
  func formatAccount(separator: String = "-") -> String {
    if self.isEmpty {
      return separator
    }
    
    let strAccount = self
    
    let startIndex = strAccount.startIndex
    let endIndex = strAccount.endIndex
    let digitIndex = strAccount.index(before: endIndex)
    
    let account = String(strAccount[startIndex ..< digitIndex])
    let digit = String(strAccount[digitIndex ..< endIndex])
    
    return account + separator + digit
  }
  
  func formatCPF() -> String {
    if !self.isCPF {
      return "–"
    }
    
    let strAccount = self
    let iFirstPart = strAccount.index(strAccount.startIndex, offsetBy: 3)
    let iSecondPart = strAccount.index(iFirstPart, offsetBy: 3)
    let iThirdPart = strAccount.index(iSecondPart, offsetBy: 3)
    let iLastPart = strAccount.index(strAccount.endIndex, offsetBy: -2)
    let firstPart = strAccount[..<iFirstPart]
    let secondPart = strAccount[iFirstPart..<iSecondPart]
    let thirdPart = strAccount[iSecondPart..<iThirdPart]
    let lastPart = strAccount[iLastPart...]
    var cpfFormatted = firstPart + "."
    cpfFormatted += secondPart + "."
    cpfFormatted += thirdPart + "-"
    cpfFormatted += lastPart
    return String(cpfFormatted)
  }
  
  func formatCNPJ() -> String {
    if !self.isCNPJ {
      return "–"
    }
    
    let strAccount = self
    let iFirstPart = strAccount.index(strAccount.startIndex, offsetBy: 2)
    let iSecondPart = strAccount.index(iFirstPart, offsetBy: 3)
    let iThirdPart = strAccount.index(iSecondPart, offsetBy: 3)
    let iFourthPart = strAccount.index(iThirdPart, offsetBy: 4)
    let iLastPart = strAccount.index(strAccount.endIndex, offsetBy: -2)
    
    let firstPart = strAccount[..<iFirstPart]
    let secondPart = strAccount[iFirstPart..<iSecondPart]
    let thirdPart = strAccount[iSecondPart..<iThirdPart]
    let fourthPart = strAccount[iThirdPart..<iFourthPart]
    let lastPart = strAccount[iLastPart...]
    var cnpjFormatted = firstPart + "."
    cnpjFormatted += secondPart + "."
    cnpjFormatted += thirdPart + "/"
    cnpjFormatted += fourthPart + "-"
    cnpjFormatted += lastPart
    return String(cnpjFormatted)
  }
  
  // MARK: - Substring
  
  func subString(startIndex: Int, endIndex: Int) -> String {
    let end = (endIndex - self.count) + 1
    let indexStartOfText = self.index(self.startIndex, offsetBy: startIndex)
    let indexEndOfText = self.index(self.endIndex, offsetBy: end)
    let substring = self[indexStartOfText..<indexEndOfText]
    return String(substring)
  }
  
  func formatNameAndMiddleName() -> String {
    let components = self.components(separatedBy: " ")
    
    if components.count > 2 {
      var secondPositionName = 2
      if components[secondPositionName].count <= 3 && components.count >= 2 {
        secondPositionName += 1
      }
      
      return String(format: "%@ %@", components[0], components[secondPositionName])
    }
    
    return self
  }
  
  func formatHyphenAndTruncateTail() -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.hyphenationFactor = 1.0
    paragraphStyle.lineBreakMode = .byTruncatingTail
    paragraphStyle.alignment = .center
    
    let hyphenAttribute = [NSAttributedString.Key.paragraphStyle : paragraphStyle] as [NSAttributedString.Key : Any]
    
    return NSMutableAttributedString(string: self, attributes: hyphenAttribute)
  }
  
  func attributed() -> NSMutableAttributedString {
    return NSMutableAttributedString(string: self)
  }
  
  func initialsOfName() -> String? {
    if !self.isEmpty {
      let initials = self
        .components(separatedBy: " ")
        .reduce("") {
          ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)"
      }
      return initials.uppercased()
    }
    
    return nil
  }
  
  func capitalize() -> String {
    var formattedString = self.localizedLowercase
    formattedString = formattedString.capitalized
    return formattedString
  }
  
  func firstCapitalized() -> String {
    var formattedString = self.localizedLowercase
    guard let first = first else { return "" }
    formattedString = String(first).uppercased() + formattedString.dropFirst()
    return formattedString
  }
  
  func removingWhitespaces() -> String {
    return components(separatedBy: .whitespaces).joined()
  }
  
  func split(by length: Int) -> [String] {
    var startIndex = self.startIndex
    var results = [Substring]()
    
    while startIndex < self.endIndex {
      let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
      results.append(self[startIndex..<endIndex])
      startIndex = endIndex
    }
    
    return results.map { String($0) }
  }
  
  func insertDivisionTextByBlocks(length: Int, divisionText: String) -> String {
    let text = self.split(by: length)
    return text.map({ "\($0)\(divisionText)" }).joined()
  }

  
  // MARK: - UIImage
  
  func img(_ index: Int) -> UIImage {
    let img = UIImage(named: self.format(index))
    return img ?? UIImage()
  }
  
  func format(_ obj: Any) -> String {
    let str = String(format: self, arguments: [String(describing: obj)])
    return str
  }
  
  // MARK: - Bool
  func isValid(in range: NSRange, string: String) -> Bool {
    let newString = (self as NSString).replacingCharacters(in: range, with: string) as NSString
    if  newString.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
      return true
    } else {
      return false
    }
  }
  
  func toInt32Array() -> [Int32] {
    return self.components(separatedBy: ",").map { s in Int32(s.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0 }
  }
  
  // MARK: - Removes all and keep only letters
  
  func onlyLetters() -> String {
    return String(self.filter { $0.isLetter || $0.isWhitespace })
  }
  
  func withoutAccentuation() -> String {
    let updateString = self.replace(occurences: ["ª", "º", "æ", "Æ", "œ", "Œ", "ø", "Ø"], with: "")
    return updateString.folding(options: .diacriticInsensitive, locale: .current)
  }
  
  func returnDigitsOnly() -> String {
    let stringArray = self.components(separatedBy: CharacterSet.decimalDigits.inverted)
    return stringArray.joined()
  }
  
  /// Add character at the left of the string based on the desired length
  ///
  /// - Returns: formated string with left pad
  
  func leftPadding(toLength: Int, withPad character: Character) -> String {
    let stringLength = self.count
    if stringLength < toLength {
      return String(repeatElement(character, count: toLength - stringLength)) + self
    } else {
      return String(self.suffix(toLength))
    }
  }
  /// Removes query string from url
  ///
  /// - Returns the path of the url
  func removeQueryFromURL() -> String {
    guard let urlComponents = URLComponents(string: self) else { return self }
    return urlComponents.path
  }
  
  func removeSpecialCharsFromString() -> String {
    let clearString : Set<Character> =
      Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
    return String(self.filter {
      clearString.contains($0)
    })
  }
  
  func formatDate(_ patternIn: String = "yyyy-MM-dd'T'HH:mm:ss.SSS", patternOut: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    dateFormatter.dateFormat = patternIn
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    
    if let date = dateFormatter.date(from: self) {
      let newFormat = DateFormatter()
      newFormat.dateFormat = patternOut
      newFormat.calendar = Calendar(identifier: .gregorian)
      
      let dateStr = newFormat.string(from: date)
      return newFormat.date(from: dateStr) ?? Date()
    }
    
    return Date()
  }
  
  func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.height)
  }

  func toDictionary() -> NSDictionary? {
    let blankDict : NSDictionary = [:]
    if let data = self.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
      } catch {
        print(error.localizedDescription)
      }
    }
    return blankDict
  }
  
  static func createAttributedString(text: String?, fontSize: Double, color: UIColor) -> NSAttributedString {
    let font: UIFont = UIFont.systemFont(ofSize: CGFloat(fontSize))
    let color: UIColor = color
    let atributtes: [NSAttributedString.Key : Any] = [
      .font : font,
      .foregroundColor : color
    ]
    let attributedString = NSAttributedString(string: text ?? "", attributes: atributtes)
    return attributedString
  }
  
  func asAttributedString(fontSize: Double, color: UIColor? = .gray, bold: Bool = false) -> NSAttributedString {
    let font: UIFont = bold ? UIFont.systemFont(ofSize: CGFloat(fontSize), weight: UIFont.Weight.semibold) : UIFont.systemFont(ofSize: CGFloat(fontSize))
    let color: UIColor = color ?? .gray
    let atributtes: [NSAttributedString.Key : Any] = [
      .font : font,
      .foregroundColor : color
    ]
    let attributedString = NSAttributedString(string: self, attributes: atributtes)
    return attributedString
  }
  
  func indexOfCharacter(char: Character) -> Int {
    if let idx = self.firstIndex(of: char) {
      return self.distance(from: startIndex, to: idx)
    }
    return -1
  }
  
  func replace(occurences: [String], with string: String) -> String {
      var newString = self
      for occur in occurences {
          newString = newString.replacingOccurrences(of: occur, with: string)
      }
      return newString
  }
  
  func onlyNumbers() -> String {
    return self.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
  }
}
