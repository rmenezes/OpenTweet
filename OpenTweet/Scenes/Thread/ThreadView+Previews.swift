import Foundation

extension ThreadView_Previews {
    final class ViewModel: ThreadViewModeling & ObservableObject {
        var tweets: [Tweet] = []
    }
}
