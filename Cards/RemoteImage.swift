import SwiftUI

struct NetworkDelay: EnvironmentKey {
    static var defaultValue: Double = 0
}

extension EnvironmentValues {
    var networkDelay: Double {
        get { self[NetworkDelay.self] }
        set { self[NetworkDelay.self] = newValue }
    }
}

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: Image?
    var url: URL?

    func load(url: URL, delay: Double = 0) async {
        if url == self.url && image != nil { return }

        do {
            self.url = url
            self.image = nil
            let (data, _) = try await URLSession.shared.data(from: url)
            if delay > 0 {
                try await Task.sleep(for: .seconds(delay)) // Artificial sleep to see the loading
            }
            #if os(macOS)
            image = NSImage(data: data).map(Image.init)
            #else
            image = UIImage(data: data).map(Image.init)
            #endif
            if image == nil {
                print(url)
            }
        } catch {
            print(error)
        }
    }
}

struct RemoteImage<V: View>: View {
    var url: URL
    @ViewBuilder var placeholder: () -> V
    fileprivate var _resizable: Bool = false
    fileprivate var _renderingMode = Image.TemplateRenderingMode.original
    @StateObject private var loader = ImageLoader()

    var body: some View {
        ManagedRemoteImage(url: url, loader: loader, resizable: _resizable, renderingMode: _renderingMode, placeholder: placeholder)
    }

    func resizable() -> Self {
        var copy = self
        copy._resizable = true
        return copy
    }

    func renderingMode(_ mode: Image.TemplateRenderingMode) -> Self {
        var copy = self
        copy._renderingMode = mode
        return copy
    }

    init(url: URL, placeholder: @escaping () -> V, resizable: Bool = false) {
        self.url = url
        self.placeholder = placeholder
        self._resizable = resizable
    }

    init(url: URL) where V == _ShapeView<Rectangle, AnyGradient> {
        self.url = url
        self.placeholder = { Rectangle().fill(Color.secondary.gradient) }
    }
}

struct ManagedRemoteImage<V: View>: View {
    var url: URL
    var placeholder: V
    fileprivate var _resizable: Bool
    fileprivate var _renderingMode: Image.TemplateRenderingMode
    @ObservedObject var loader: ImageLoader
    @Environment(\.networkDelay) private var delay

    init(url: URL, loader: ImageLoader, resizable: Bool = false, renderingMode: Image.TemplateRenderingMode = .original, @ViewBuilder placeholder: () -> V) {
        self.url = url
        self.loader = loader
        self.placeholder = placeholder()
        self._resizable = resizable
        self._renderingMode = renderingMode
    }

    var body: some View {
        ZStack {
            if let image = loader.image {
                let base = image.renderingMode(_renderingMode)
                if _resizable {
                    base
                        .resizable()
                } else {
                    base
                }
            } else {
                placeholder
            }
        }
        .task(id: url) {
            await loader.load(url: url, delay: Double.random(in: 0...delay))
        }
    }

    func resizable() -> some View {
        var copy = self
        copy._resizable = true
        return copy
    }
}
