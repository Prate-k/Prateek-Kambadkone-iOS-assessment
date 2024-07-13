import UIKit

class GlucodianTableViewCell: UITableViewCell {
    
    typealias DisplayInfo = (name: String, role: String, image: UIImage?)
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(with info: DisplayInfo) {
        nameLabel.text = info.name
        roleLabel.text = info.role
        if let image = info.image {
            profileImage.image = image
        }
    }
    
    override func prepareForReuse() {
        profileImage.image = UIImage(systemName: "person.fill")
    }
}
