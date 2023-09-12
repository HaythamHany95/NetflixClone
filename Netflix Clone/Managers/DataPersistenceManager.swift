//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Haytham on 08/09/2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DataBaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }

static let shared = DataPersistenceManager()
    
    func downloadShowWith(model: Show, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let item = ShowItem(context: context)
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.release_data = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        
        do {
           try context.save()
            completion(.success(()))

        } catch {
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    
    func fetchingShowsFromDatabase(completion: @escaping (Result<[ShowItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<ShowItem>
        request = ShowItem.fetchRequest()
        
        do {
            let shows = try context.fetch(request)
            completion(.success(shows))

        } catch {
            completion(.failure(DataBaseError.failedToFetchData))
        }
    }
    
    func deleteShowWith(model: ShowItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
     
        do {
          try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToDeleteData))
        }
    }
}
