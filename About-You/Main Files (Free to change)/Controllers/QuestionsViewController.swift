import UIKit
import UniformTypeIdentifiers

class QuestionsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var containerStack: UIStackView!
    private weak var profileView: ProfileView?
    private weak var imagePicker: UIImagePickerController?
    
    private var engineer: Engineer!
    
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
        self.profileView = profileView
        profileView.setUp(for: engineer, delegate: self)
        containerStack.addArrangedSubview(profileView)
    }
}

// MARK: - ProfileViewDelegate

extension QuestionsViewController: ProfileViewDelegate, UINavigationControllerDelegate {
    
    func selectImage() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            self.showDestructiveAlert(with: "Feature Not Available", 
                                      message: "Photo Library is not currently available",
                                      type: .ok)
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = [UTType.image.identifier]
        self.imagePicker = imagePicker
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, 
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            self.showDestructiveAlert(with: "Failed",
                                      message: "Unable to select the image, please try again.",
                                      type: .close)
            imagePicker?.dismiss(animated: true) { [weak self] in self?.imagePicker = nil }
            return
        }
        imagePicker?.dismiss(animated: true) { [weak self] in self?.imagePicker = nil }
        profileView?.updateImage(with: image)
    }
}
