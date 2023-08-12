//
//  Created by Matt Bonney on 11/23/22.
//

import SwiftUI
import CoreData

public struct FetchRequestForEach<Entity, Content>: View where Entity: NSManagedObject, Entity: Identifiable, Content: View {
    @FetchRequest var entities: FetchedResults<Entity>
    @ViewBuilder let content: (Entity) -> Content

    public var body: some View {
        ForEach(entities) { entity in
            content(entity)
        }
    }
}
