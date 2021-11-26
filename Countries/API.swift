// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CountriesApiQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
    """
    query CountriesAPI {
      countries {
        __typename
        code
        name
        capital
        currency
        phone
        continent {
          __typename
          name
        }
        languages {
          __typename
          name
          native
        }
      }
    }
    """
    
    public let operationName: String = "CountriesAPI"
    
    public init() {
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Query"]
        
        public static var selections: [GraphQLSelection] {
            return [
                GraphQLField("countries", type: .nonNull(.list(.nonNull(.object(Country.selections))))),
            ]
        }
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(countries: [Country]) {
            self.init(unsafeResultMap: ["__typename": "Query", "countries": countries.map { (value: Country) -> ResultMap in value.resultMap }])
        }
        
        public var countries: [Country] {
            get {
                return (resultMap["countries"] as! [ResultMap]).map { (value: ResultMap) -> Country in Country(unsafeResultMap: value) }
            }
            set {
                resultMap.updateValue(newValue.map { (value: Country) -> ResultMap in value.resultMap }, forKey: "countries")
            }
        }
        
        public struct Country: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Country"]
            
            public static var selections: [GraphQLSelection] {
                return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("capital", type: .scalar(String.self)),
                    GraphQLField("currency", type: .scalar(String.self)),
                    GraphQLField("phone", type: .nonNull(.scalar(String.self))),
                    GraphQLField("continent", type: .nonNull(.object(Continent.selections))),
                    GraphQLField("languages", type: .nonNull(.list(.nonNull(.object(Language.selections))))),
                ]
            }
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public init(code: GraphQLID, name: String, capital: String? = nil, currency: String? = nil, phone: String, continent: Continent, languages: [Language]) {
                self.init(unsafeResultMap: ["__typename": "Country", "code": code, "name": name, "capital": capital, "currency": currency, "phone": phone, "continent": continent.resultMap, "languages": languages.map { (value: Language) -> ResultMap in value.resultMap }])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var code: GraphQLID {
                get {
                    return resultMap["code"]! as! GraphQLID
                }
                set {
                    resultMap.updateValue(newValue, forKey: "code")
                }
            }
            
            public var name: String {
                get {
                    return resultMap["name"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "name")
                }
            }
            
            public var capital: String? {
                get {
                    return resultMap["capital"] as? String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "capital")
                }
            }
            
            public var currency: String? {
                get {
                    return resultMap["currency"] as? String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "currency")
                }
            }
            
            public var phone: String {
                get {
                    return resultMap["phone"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "phone")
                }
            }
            
            public var continent: Continent {
                get {
                    return Continent(unsafeResultMap: resultMap["continent"]! as! ResultMap)
                }
                set {
                    resultMap.updateValue(newValue.resultMap, forKey: "continent")
                }
            }
            
            public var languages: [Language] {
                get {
                    return (resultMap["languages"] as! [ResultMap]).map { (value: ResultMap) -> Language in Language(unsafeResultMap: value) }
                }
                set {
                    resultMap.updateValue(newValue.map { (value: Language) -> ResultMap in value.resultMap }, forKey: "languages")
                }
            }
            
            public struct Continent: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Continent"]
                
                public static var selections: [GraphQLSelection] {
                    return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    ]
                }
                
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public init(name: String) {
                    self.init(unsafeResultMap: ["__typename": "Continent", "name": name])
                }
                
                public var __typename: String {
                    get {
                        return resultMap["__typename"]! as! String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                    }
                }
                
                public var name: String {
                    get {
                        return resultMap["name"]! as! String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "name")
                    }
                }
            }
            
            public struct Language: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Language"]
                
                public static var selections: [GraphQLSelection] {
                    return [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .scalar(String.self)),
                        GraphQLField("native", type: .scalar(String.self)),
                    ]
                }
                
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public init(name: String? = nil, native: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "Language", "name": name, "native": native])
                }
                
                public var __typename: String {
                    get {
                        return resultMap["__typename"]! as! String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                    }
                }
                
                public var name: String? {
                    get {
                        return resultMap["name"] as? String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "name")
                    }
                }
                
                public var native: String? {
                    get {
                        return resultMap["native"] as? String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "native")
                    }
                }
            }
        }
    }
}
