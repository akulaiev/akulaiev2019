//
//  ArticleManager.swift
//  akulaiev2019
//
//  Created by Anna KULAIEVA on 10/11/19.
//

import Foundation
import CoreData

public class ArticleManager: NSObject {
    
    var managedObjContext: NSManagedObjectContext
    var commitPredicate: NSPredicate?
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
    
    public override init() {
        var modelUrl: URL!
        if let bundleURL = Bundle(for: Article.self).url(forResource: "akulaiev2019", withExtension: "bundle") {
            guard let frameworkBundle = Bundle(url: bundleURL) else {
                fatalError("Error loading bundle")
            }
            modelUrl = frameworkBundle.url(forResource: "article", withExtension: "momd")
        }
        else {
            modelUrl = Bundle(for: Article.self).url(forResource: "article", withExtension: "momd")
        }
        guard let managedObjModel = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Error initializing managedObjModel from: \(modelUrl!)")
        }
        
        let persistentStoreCoord = NSPersistentStoreCoordinator(managedObjectModel: managedObjModel)
        
        managedObjContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjContext.persistentStoreCoordinator = persistentStoreCoord
        
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let storeURL = docURL?.appendingPathComponent("akulaiev2019.sqlite")
        do {
            try persistentStoreCoord.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    public func newArticle() -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjContext) as! Article
    }
    
    func loadData() -> [Article] {
        request.predicate = commitPredicate
        do {
            let result = try managedObjContext.fetch(request) as! [Article]
            return result
        }
        catch {
            fatalError("Failed to fetch articles")
        }
    }
    
    public func getAllArticles() -> [Article] {
        commitPredicate = NSPredicate(value: true)
        return loadData()
    }
    
    public func  getArticles(withLang lang : String) -> [Article] {
        commitPredicate = NSPredicate(format: "language == %@", lang)
        return loadData()
    }
    
    public func getArticles(containString str : String) -> [Article] {
        commitPredicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str, str)
        return loadData()
    }
    
    public func removeArticle(article : Article) {
        managedObjContext.delete(article)
    }
    
    public func save() {
        if managedObjContext.hasChanges {
            do {
                try managedObjContext.save()
            }
            catch{
                fatalError("Fail to save content \(error)");
            }
        }
    }
}


