//  CoreDataHelper.swift
//
//  Copyright (c) 2014 Austin Kelleher, a@alk.im
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


//  REPLACE THE NSMANAGEDOBJECT ** ATTEND ** WITH YOUR NSMANAGEDOBJECT USED AS ENTITY IN YOUR COREDATA MODEL IN THIS FILE.


import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    
    /**
    * Returns an NSManagedObjectContext, which is used for core data fetching
    */
    class func getManagedContext() -> NSManagedObjectContext {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        return context
    }
    
    /**
    * Returns an NSArray of results from a core data request
    * @var entityName The name of the core data entity to request
    */
    
    class func getCoreDataResults(_ entityName: String) -> NSArray {
        let context = getManagedContext()
        
        let request: NSFetchRequest<Attend> //REPLACE ATTEND WITH YOUR ENTITY
        if #available(iOS 10.0, *) {
            request = NSFetchRequest<Attend>(entityName: "\(entityName)") //REPLACE ATTEND WITH YOUR ENTITY
        } else {
            request = NSFetchRequest<Attend>(entityName: "\(entityName)") //REPLACE ATTEND WITH YOUR ENTITY
        }
        do {
           let results = try context.fetch(request)
            return results as NSArray
        } catch let error {
            print(error.localizedDescription)
        }
        return []
    }
    
    /**
    * Returns the object inside of the core data request at @id or nil if none
    * @var entityName The name of the core data entity to request
    * @var id The Id of the core data object to fetch
    */
    class func getCoreDataResultById(_ entityName: String, id: Int) -> NSManagedObject? {
        let results = getCoreDataResults(entityName)
        
        if(id >= 0 && results.count > id) {
            return results[id] as? NSManagedObject
        }
        
        return nil
    }
    
    /**
    * Returns the first object inside of the core data request or nil if none
    * @var entityName The name of the core data entity to request
    */
    class func getFirstCoreDataResult(_ entityName: String) -> NSManagedObject? {
        return getCoreDataResultById(entityName, id: 0)
    }
    
    class func getTotalItems(_ entityName: String) -> Int? {
        
        let context = getManagedContext()
        
        let request: NSFetchRequest<Attend>  //REPLACE ATTEND WITH YOUR ENTITY
        if #available(iOS 10.0, *) {
            request = Attend.fetchRequest() as! NSFetchRequest<Attend>  //REPLACE ATTEND WITH YOUR ENTITY
        } else {
            request = NSFetchRequest(entityName: "\(entityName)")
        }
        do {
            let result:NSArray = try context.fetch(request) as NSArray
            return result.count
        } catch let error {
            print(error.localizedDescription)
        }
        return 0
    }
    
    /**
    * Saves an object to core data using a dictionary for the core data object key value pairs
    * @var entityName The name of the core data entity to request
    * @var dictionary The key value pair dictionary that represents the core data object properties
    */
    class func save(_ entityName: String, dictionary: Dictionary<String, String>) {
        let context = getManagedContext()
        
        let saveObject: AnyObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        for(key, value) in dictionary {
            saveObject.setValue(value, forKey: key)
        }
        do {
            try context.save()
            print("saved")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        } 
    }
}
