//
//  RealmManager.swift
//  AppZemoga
//
//  Created by Oscar David Myerston Vega on 8/10/22.
//

import Foundation
import RealmSwift

class RealmManager {

    var realm: Realm!

    init() {
        do {
            realm = try Realm()
        } catch let error {
            print("Realm error: \(error.localizedDescription)")
        }
    }

    func getAllPosts () -> [HomeModel.HomePost] {
        return Mapper.mapRealmResultSetToArray(realm.objects(PostLocal.self))
    }

    func addPost(_ post: HomeModel.HomePost) -> Bool {
        var result = false
        if !existsInDB(post.id!) {
            self.insert(post)
            result = true
        }
        return result
    }

    func insert (_ post: HomeModel.HomePost) {
        do {
            try realm.write {
                realm.add(Mapper.mapToPostLocal(post))
            }
        } catch let error {
            print("Error insert Realm: \(error.localizedDescription)")
        }
    }

    func existsInDB(_ id: Int) -> Bool {
        var exist = false
        let postLocal = realm.objects(PostLocal.self).filter("id == \(id)")
        if postLocal.count > 0 {
            exist = true
        }
        return exist
    }

    func removeAllPosts(posts: [HomeModel.HomePost]) {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print("Error Deleted all posts Realm: \(error.localizedDescription)")
        }
    }

    func removePost(post: HomeModel.HomePost) {
        do {
            try realm.write {
                realm.delete(realm.objects(PostLocal.self).filter("id=%@", post.id!))
            }
            
        } catch let error as NSError {
            print("Error insert Realm: \(error.localizedDescription)")
        }
    }

    func updateObject(_ id: Int, isSelected: Bool) {

        let post = realm.objects(PostLocal.self).filter("id = %@", id)
        if let post = post.first {
            try! realm.write {
                post.isFav = isSelected
            }
        }
    }

}
