import UIKit

class QuestionsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var engineer: Engineer!

    static func loadController(with engineer: Engineer) -> QuestionsViewController {
        let viewController = QuestionsViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.setUp(with: engineer)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "About"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    func setUp(with engineer: Engineer) {
        loadViewIfNeeded()
        self.engineer = engineer
        setUpScrollView()
        setUpProfileView()
        for question in engineer.questions {
            addQuestion(with: question)
        }
    }

    private func addQuestion(with data: Question) {
        guard let cardView = QuestionCardView.loadView() else { return }
        cardView.setUp(with: data.questionText,
                       options: data.answerOptions,
                       selectedIndex: data.answer?.index)
        containerStack.addArrangedSubview(cardView)
    }
    
    private func setUpScrollView() {
        scrollView.delegate = self
        scrollView.decelerationRate = .fast
    }
    
    private func setUpProfileView() {
        guard let profileView = ProfileView.loadView() else { return }
        profileView.setUp(for: engineer)
        containerStack.addArrangedSubview(profileView)
    }
}
