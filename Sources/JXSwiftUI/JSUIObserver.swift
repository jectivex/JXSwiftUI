//
//  JSUIObserver.swift
//
//  Created by Abe White on 10/6/22.
//

import Combine

class JSUIObserver: ObservableObject {
    func willChange() {
        self.objectWillChange.send()
    }
}
