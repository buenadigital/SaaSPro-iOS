//
//  EVExtensions.swift
//  EVReflection
//


import Foundation

/**
Implementation for Equatable ==

- parameter lhs: The object at the left side of the ==
- parameter rhs: The object at the right side of the ==
:returns: True if the objects are the same, otherwise false.
*/
public func ==(lhs: EVObject, rhs: EVObject) -> Bool {
    return EVReflection.areEqual(lhs, rhs: rhs)
}

/**
Implementation for Equatable !=

- parameter lhs: The object at the left side of the ==
- parameter rhs: The object at the right side of the ==
:returns: False if the objects are the the same, otherwise true.
*/
public func !=(lhs: EVObject, rhs: EVObject) -> Bool {
    return !EVReflection.areEqual(lhs, rhs: rhs)
}


/**
Extending the NSObject
*/
public extension NSObject {
    /**
    Convenience init for creating an object whith the property values of a dictionary.
    */
    public convenience init(dictionary:NSDictionary) {
        self.init()
        EVReflection.setPropertiesfromDictionary(dictionary, anyObject: self)
    }
    
    /**
    Convenience init for creating an object whith the contents of a json string.
    */
    public convenience init(json:String?) {
        self.init()
        let jsonDict = EVReflection.dictionaryFromJson(json)
        EVReflection.setPropertiesfromDictionary(jsonDict, anyObject: self)
    }
    
    /**
    Returns the dictionary representation of this object.
    
    :parameter: performKeyCleanup set to true if you want to cleanup the keys
    
    :returns: The dictionary
    */
    final public func toDictionary(performKeyCleanup:Bool = false) -> NSDictionary {
        let (reflected, _) = EVReflection.toDictionary(self, performKeyCleanup: performKeyCleanup)
        return reflected
    }
    
    /**
    Convert this object to a json string
    
    :parameter: performKeyCleanup: set to true if you want to cleanup the keys
    
    :returns: The json string
    */
    final public func toJsonString(performKeyCleanup:Bool = false) -> String {
        return EVReflection.toJsonString(self, performKeyCleanup: performKeyCleanup)
    }
    
    /**
    Convenience method for instantiating an array from a json string.
    
    :parameter: json The json string
    
    :returns: An array of objects
    */
    public class func arrayFromJson<T where T:NSObject>(json:String?) -> [T] {
        return EVReflection.arrayFromJson(T(), json: json)
    }
    
}


/**
Extending Array with an initializer with a json string
*/
extension Array {
    
    /**
    Initialize an array based on a json string
    
    :parameter: json The json string
    
    :returns: The array of objects
    */
    init(json:String?){
        self.init()
        let arrayTypeInstance = getArrayTypeInstance(self)
        let newArray = EVReflection.arrayFromJson(arrayTypeInstance, json: json)
        for item in newArray {
            self.append(item)
        }
    }
    
    /**
    Get the type of the object where this array is for
    
    :parameter: arr this array
    
    :returns: The object type
    */
    private func getArrayTypeInstance<T>(arr:Array<T>) -> T {
        return arr.getTypeInstance()
    }
    
    /**
    Get the type of the object where this array is for
    
    :returns: The object type
    */
    private func getTypeInstance<T>(
        ) -> T {
            let nsobjectype : NSObject.Type = T.self as! NSObject.Type
            let nsobject: NSObject = nsobjectype.init()
            return nsobject as! T
    }
}
