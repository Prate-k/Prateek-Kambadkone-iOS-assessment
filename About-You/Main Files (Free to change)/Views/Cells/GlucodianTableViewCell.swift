import UIKit

class GlucodianTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(with name: String, role: String, image: UIImage?) {
        nameLabel.text = name
        roleLabel.text = role
        if let image {
            profileImage.image = image
        }
    }
    
    override func prepareForReuse() {
        profileImage.image = UIImage(systemName: "person.fill")
    }
}
