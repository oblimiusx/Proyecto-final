//
//  DBManager.swift
//  PCPrototype
//
//  Created by Diego Monteverde on 12/6/17.
//  Copyright © 2017 ihelperdevelop. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    //Variables db Fields
    let field_caseId = "case_id"
    let field_title = "case_title"
    let field_Presentation_Type = "case_presentation_type"
    let field_Text_Presentation = "case_text_presentation"
    let field_Question = "case_question"
    let field_Image = "case_main_image"
    let field_Argument_Favor = "case_argument_favor"
    let field_Argument_Against = "case_argument_against"
    let field_argument_fragment = "r_fragment_argument"
    let field_argument_stance = "r_fragment_argument_stance"
    let field_evidence_desc = "r_case_evidence_desc"
    let Favor = "true"
    let Against = "false"
    
    //User db variables
    let field_user_session_id = "user_session_id"
    let field_user_stance = "user_stance"
    let field_user_why = "user_why"
    let field_user_opinion = "user_opinion"
    let field_module_one_clear = "module_one_clear"
    let field_module_two_clear = "module_two_clear"
    let field_module_three_clear = "module_three_clear"
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "ctdb.sqlite"
    let userDatabaseFileName = "userdb.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    var userDatabase: FMDatabase!
    var pathToUserDatabase: String!
    
    func getCaseData(id: String) -> [String]! {
        var data: [String] = []
        
        if openDatabase() {
            //let query = "SELECT * FROM Case WHERE \(field_caseId)=?"
            let query = "select * from Case_data WHERE \(field_caseId) =?"
            
            do {
                let results = try database.executeQuery(query, values: [id])
                while results.next() {
                    data.append(results.string(forColumn: field_title)!)
                    data.append(results.string(forColumn: field_Text_Presentation)!)
                    data.append(results.string(forColumn: field_Question)!)
                    data.append(results.string(forColumn: field_Image)!)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        return data
    }
    
    override init() {
        super.init()
        
        let resourcePath = Bundle.main.resourceURL!.absoluteString
        pathToDatabase  = resourcePath.appending("/\(databaseFileName)")
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToUserDatabase = documentsDirectory.appending("/\(userDatabaseFileName)")
    }
    
    func openDatabase() -> Bool {
        database = FMDatabase(path: pathToDatabase)

        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func getArgument(id: String, stance: Bool) -> String! {
        var data: String = ""
        
        if openDatabase() {
            let query = "select * from Case_data WHERE \(field_caseId) =?"
            
            do {
                if stance {
                    let results = try database.executeQuery(query, values: [id])
                    while results.next() {
                        data = results.string(forColumn: field_Argument_Favor)!
                    }
                } else {
                    let results = try database.executeQuery(query, values: [id])
                    while results.next() {
                        data = results.string(forColumn: field_Argument_Against)!
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        
        }
        return data
    }
    
    func getArgumentFragments(id: String, stance: Bool) -> [String]! {
        var data: [String] = []
        
        if stance {
            if openDatabase() {
                let query = "select * from R_fragment_arguments WHERE \(field_caseId) =? AND \(field_argument_stance) = 'true'"
                
                do {
                    let results = try database.executeQuery(query, values: [id])
                    while results.next() {
                        data.append(results.string(forColumn: field_argument_fragment)!)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                database.close()
            }
        } else {
            if openDatabase() {
                let query = "select * from R_fragment_arguments WHERE \(field_caseId) =? AND \(field_argument_stance) = 'false'"
                
                do {
                    let results = try database.executeQuery(query, values: [id])
                    while results.next() {
                        data.append(results.string(forColumn: field_argument_fragment)!)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                database.close()
            }
        }
        
        return data
    }
    
    func getEvidences(id: String) -> [String]! {
        var data: [String] = []
        
        if openDatabase() {
            let query = "select * from R_case_evidence WHERE \(field_caseId) =?"
            
            do {
                let results = try database.executeQuery(query, values: [id])
                while results.next() {
                    data.append(results.string(forColumn: field_evidence_desc)!)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        
        return data
    }
    
    
    func createUserDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToUserDatabase) {
            userDatabase = FMDatabase(path: pathToUserDatabase!)
            
            if userDatabase != nil {
                // Open the database.
                if userDatabase.open() {
                    let createUserDataTableQuery = "create table UserData (user_session_id integer primary key autoincrement not null, user_stance text, user_why text, user_opinion text, module_one_clear text, module_two_clear text, module_three_clear text)"
                    
                    do {
                        try userDatabase.executeUpdate(createUserDataTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    userDatabase.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        return created
    }
    
    
    func insertSession() {
        if openUserDatabase() {
            let query = "insert into UserData (\(field_user_stance), \(field_user_why), \(field_user_opinion), \(field_module_one_clear), \(field_module_two_clear), \(field_module_three_clear)) values (0, 'null', 'null', 0, 0, 0);"
           
            if !userDatabase.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())

            userDatabase.close()
                
            }
        }
    }
    
    
    func updatetStance(stance:String) {
        if openUserDatabase() {
            let query = "update UserData set \(field_user_stance)=?"
            
            do {
                try userDatabase.executeUpdate(query, values: [stance])
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
    }
    
    func updateWhy(why:String) {
        if openUserDatabase() {
            let query = "update UserData set \(field_user_why)=?"
            
            do {
                try userDatabase.executeUpdate(query, values: [why])
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
    }
    
    func updateModule(module:String){
        if module == "1" {
            if openUserDatabase() {
                let query = "update UserData set \(field_module_one_clear)=?"
                
                do {
                    try userDatabase.executeUpdate(query, values: ["1"])
                }
                catch {
                    print(error.localizedDescription)
                }
                userDatabase.close()
            }
        } else if module == "2" {
            if openUserDatabase() {
                let query = "update UserData set \(field_module_two_clear)=?"
                
                do {
                    try userDatabase.executeUpdate(query, values: ["1"])
                }
                catch {
                    print(error.localizedDescription)
                }
                userDatabase.close()
            }
        } else if module == "3" {
            if openUserDatabase() {
                let query = "update UserData set \(field_module_three_clear)=?"
                
                do {
                    try userDatabase.executeUpdate(query, values: ["1"])
                }
                catch {
                    print(error.localizedDescription)
                }
                userDatabase.close()
            }
        }
        
    }
    
    func updateOpinion (opinion:String) {
        if openUserDatabase() {
            let query = "update UserData set \(field_user_opinion)=?"
            
            do {
                try userDatabase.executeUpdate(query, values: [opinion])
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
    }
    
    func getStance(id: String) -> String! {
        var data: String = ""
        
        if openUserDatabase() {
            let query = "select * from UserData WHERE \(field_user_session_id) =?"
            
            do {
                let results = try userDatabase.executeQuery(query, values: [id])
                while results.next() {
                    data = results.string(forColumn: field_user_stance)!
                }
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
        
        return data
    }
    
    func getWhy(id: String) -> String! {
        var data: String = ""
        
        if openUserDatabase() {
            let query = "select * from UserData WHERE \(field_user_session_id) =?"
            
            do {
                let results = try userDatabase.executeQuery(query, values: [id])
                while results.next() {
                    data = results.string(forColumn: field_user_why)!
                }
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
        
        return data
    }
    
    func getOpinion(id: String) -> String! {
        var data: String = ""
        
        if openUserDatabase() {
            let query = "select * from UserData WHERE \(field_user_session_id) =?"
            
            do {
                let results = try userDatabase.executeQuery(query, values: [id])
                while results.next() {
                    data = results.string(forColumn: field_user_opinion)!
                }
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
        
        return data
    }
    
    func getModules (id: String) -> [String]! {
        var data: [String] = []
        
        if openUserDatabase() {
            let query = "select * from UserData WHERE \(field_user_session_id) =?"
            
            do {
                let results = try userDatabase.executeQuery(query, values: [id])
                while results.next() {
                    data.append(results.string(forColumn: field_module_one_clear)!)
                    data.append(results.string(forColumn: field_module_two_clear)!)
                    data.append(results.string(forColumn: field_module_three_clear)!)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            userDatabase.close()
        }
        
        return data
    }
    
    func openUserDatabase() -> Bool {
        userDatabase = FMDatabase(path: pathToUserDatabase)
        
        if userDatabase != nil {
            if userDatabase.open() {
                return true
            }
        }
        
        return false
    }
    
}
