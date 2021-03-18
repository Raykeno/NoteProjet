import UIKit

class NoteTableViewController: UITableViewController {
    
    var notes: [Note] = [
        Note(name: "Aller au magasin", contenu: "Acheter un paquet de crayon pour la semaine prochaine",
              date: "12/01/2021 14:05"),
        Note(name: "Nettoyer le casque VR", contenu: "Nettoyer le casque pour jouer demain",
              date: "23/02/2021 12:05"),
        Note(name: "Ranger mes affaires", contenu: "J'ai besoin de ranger mes affaires pour mes prochaines vacances",
              date: "24/02/2021 11:11"),
        Note(name: "Aller au véto pour le chat", contenu: "Le véto m'a demandée de venir le dimanche pour un examen pour mon chat",
              date: "06/03/2021 15:25"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = "\(note.name)"
        cell.detailTextLabel?.text = note.date
        cell.showsReorderControl = true
        
        return cell
    }
    
   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedNote = notes.remove(at: fromIndexPath.row)
        notes.insert(movedNote, at: to.row)
        tableView.reloadData()

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        
        if segue.identifier == "SaveUnwind" {
            let sourceVC = segue.source as! AddEditNoteTableViewController
            
            if let note = sourceVC.note {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // update
                    notes[selectedIndexPath.row] = note
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                } else { // insert
                    let newIndexPath = IndexPath(row: notes.count, section: 0)
                    notes.append(note)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                    
                }
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addEditController = navigationController.topViewController as! AddEditNoteTableViewController
            addEditController.note = note
            
        }
    }
    

}
