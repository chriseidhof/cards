import SwiftUI

private struct ScaleUpAndDownEffect: AnimatableModifier {
    var scale: CGFloat
    var count: CGFloat
    var animatableData: CGFloat {
        get { count }
        set { count = newValue }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(1 + sin(2 * .pi * count) * (scale-1))
    }
}

extension View {
    func scaleDownAndUpEffect(scale: CGFloat = 1.2, count: Int) -> some View {
        return modifier(ScaleUpAndDownEffect(scale: scale, count: .init(count) + 0.5))
    }

    func scaleUpAndDownEffect(scale: CGFloat = 1.2, count: Int) -> some View {
        return modifier(ScaleUpAndDownEffect(scale: scale, count: .init(count)))
    }
}

struct TriggerScaleDownAndUp<Value: Equatable>: ViewModifier {
    var value: Value
    var scale: CGFloat
    var animation = Animation.linear(duration: 0.3)
    @State private var changes = 0

    func body(content: Content) -> some View {
        content
            .scaleDownAndUpEffect(scale: scale, count: changes)
            .animation(animation, value: changes)
            .onChange(of: value) { changes += 1}
    }
}

extension View {
    func scaleDownAndUpEffect<Value: Equatable>(scale: CGFloat = 1.2, animation: Animation = .linear(duration: 0.3), trigger: Value) -> some View {
        modifier(TriggerScaleDownAndUp(value: trigger, scale: scale, animation: animation))
    }
}

extension View {
    // This animates three times as slow as the version above, because it first animates to the "down" scale, then on completion to the up scale, and then back to the beginning

    func phaseScaleDownAndUpEffect<Value: Equatable>(scale: CGFloat = 1.2, animation: Animation = .linear(duration: 0.3), trigger: Value) -> some View {
        let downScale = 1-(scale-1)
        return phaseAnimator(
            [1, downScale, scale, scale],
            trigger: trigger,
            content: { $0.scaleEffect($1) },
            animation: { _ in animation }
        )
    }
}
