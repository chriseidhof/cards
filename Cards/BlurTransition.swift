//

import Foundation
import SwiftUI

struct BlurTransition: Transition {
    var amount: CGFloat = 10

    func body(content: Content, phase: TransitionPhase) -> some View {
        content.blur(radius: phase.isIdentity ? 0 : amount)
    }
}

extension Transition where Self == BlurTransition {
    static var blur: Self { BlurTransition() }
    static func blur(amount: CGFloat) -> Self { BlurTransition(amount: amount) }
}
