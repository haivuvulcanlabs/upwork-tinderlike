//
//  Utilities.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import Combine
import SwiftUI

public func mutate<T>(_ arg: inout T, _ body: (inout T) -> Void) {
  body(&arg)
}

extension UIViewControllerTransitionCoordinator {
  // Fix UIKit method that's named poorly for trailing closure style
  @discardableResult
  func animateAlongsideTransition(_ animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
    return animate(alongsideTransition: animation, completion: completion)
  }
}
