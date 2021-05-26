//
//  VoiceRecord+CoreDataProperties.swift
//  VoiceChanger
//
//  Created by Александр Мезга on 25.05.2021.
//  Copyright © 2021 Mithun. All rights reserved.
//
//

import Foundation
import CoreData


extension VoiceRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VoiceRecord> {
        return NSFetchRequest<VoiceRecord>(entityName: "VoiceRecord")
    }

    @NSManaged public var voice: String?
    @NSManaged public var recognizedText: String?
    @NSManaged public var imageName: String?
    @NSManaged public var speech: Data?

}

extension VoiceRecord : Identifiable {

}
