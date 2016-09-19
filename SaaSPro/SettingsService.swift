//
//  SettingsService.swift
//  SaaSPro
//


import Foundation

class SettingsService{
    var settings : SettingsModel?
    var defaults : NSUserDefaults?
    init(){
        self.defaults = NSUserDefaults.standardUserDefaults()
        if let settingsTemp = self.defaults!.objectForKey("SavedSettings") as? String
        {
            self.settings = SettingsModel(json: settingsTemp)
            saveSettings()
        }else{
            self.settings = SettingsModel()
            saveSettings()
            
        }
    }
    
    func saveSettings(){
        let jsonString = self.settings!.toJsonString()
        self.defaults!.setObject(jsonString, forKey: "SavedSettings")
    }
    
    
    
    
}