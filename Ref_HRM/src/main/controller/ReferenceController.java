package main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import main.Model.DocumentInputModel;
import main.Model.EmployeeRefDocuments;
import main.Service.ReferenceService;

@Controller
public class ReferenceController {

	private final ReferenceService rs;

	@Autowired
	private EmployeeRefDocuments document;

	@Autowired
	public ReferenceController(ReferenceService rs) {
		this.rs = rs;
	}

	@RequestMapping(value = "/viewReferenceDocument/{id}", method = RequestMethod.POST)
	/// {id} will map the id variable from the URL to the id parameter of the method
	public String viewReferenceDocument(@PathVariable("id") String id, Model model) {
		EmployeeRefDocuments document = rs.getReferenceDocumentById(id);
		if (document != null) {
			model.addAttribute("document", document);
		} else {
			model.addAttribute("error", "Document not found");
		}
		return "ReferenceDocument";
	}

	@RequestMapping(value = "/viewDocuments", method = RequestMethod.GET)
	public String viewDocuments(Model model) {
		List<EmployeeRefDocuments> document = rs.getAllDocuments();
		model.addAttribute("document", document);
		return "documentlist";
	}

	@RequestMapping(value = "/addReferenceDocument", method = RequestMethod.GET)
	public String addReferenceDocument(Model model) {
		return "UploadReferenceDocument";
	}

	@RequestMapping(value = "/DocumentSave", method = RequestMethod.POST)
	public String saveDocument(@ModelAttribute DocumentInputModel dim, Model model) {
		document.setDocName(dim.getDocname());
		document.setCategory(dim.getCategory());
		String path = dim.getDocumentData().getAbsolutePath();
		document.setDescription(path);
		System.out.println("-----------------------" + path);
		rs.addReferenceDocument(document);
		return "success";
	}

	@RequestMapping(value = "/deleteReferenceDocument", method = RequestMethod.POST)
	public String deleteReferenceDocument(@RequestParam("documentId") String documentId, Model model) {
		rs.deleteReferenceDocument(documentId);
		return "documentList";
	}

}
