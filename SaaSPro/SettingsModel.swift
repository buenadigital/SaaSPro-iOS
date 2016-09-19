//
//  SettingsModel.swift
//  SaaSPro
//


import Foundation

class SettingsModel : EVObject {
    var email : String?
    var password : String?
    var token : String?
    var account : String?
    var saveCredentials : Bool = false
    var tokenExpirationDate : String?
    var securityQuestion : String?
    var securityQuestionValidated : Bool = false
}