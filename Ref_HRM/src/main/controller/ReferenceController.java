package main.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import main.Model.DocumentInputModel;
import main.Model.EmployeeRefDocuments;
import main.Service.ReferenceService;

// ...

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
		// Create a new instance of EmployeeRefDocuments
		EmployeeRefDocuments document = new EmployeeRefDocuments();

		document.setDocName(dim.getDocname());
		document.setCategory(dim.getCategory());

		MultipartFile documentData = dim.getDocumentData();
		if (documentData != null && !documentData.isEmpty()) {
			try {
				// Get the file name
				String fileName = StringUtils.cleanPath(documentData.getOriginalFilename());

				// Set the file path where the document will be saved
				String filePath = "Files/" + fileName; // this path according to your project structure

				// Save the document to the specified file path
				byte[] documentBytes = documentData.getBytes();
				Path path = Paths.get(filePath);
				Files.write(path, documentBytes);

				// Set the description as the file path
				document.setDescription(filePath);

				// Add the document to the database
				rs.addReferenceDocument(document);

				// Display success message
				model.addAttribute("message", "Document uploaded successfully!");
			} catch (IOException e) {
				// Handle the exception
				model.addAttribute("error", "Failed to upload the document!");
			}
		} else {
			// Handle the case when no document is uploaded
			model.addAttribute("error", "No document found to upload!");
		}

		return "success";
	}

	@RequestMapping(value = "/OpenDocument", method = RequestMethod.GET)
	public void openDocument(@RequestParam("docname") String docname, HttpServletResponse response) {
		// Construct the file path based on the selected docname
		String filePath = "Files/" + docname; // Update the path based on your project structure

		try {
			// Set the content type based on the file extension
			String mimeType = URLConnection.guessContentTypeFromName(docname);
			response.setContentType(mimeType);

			// Set the content disposition to "inline" to open the file in the browser
			response.setHeader("Content-Disposition", "inline; filename=\"" + docname + "\"");

			// Read the file from the specified path
			FileInputStream fileInputStream = new FileInputStream(filePath);
			OutputStream outputStream = response.getOutputStream();

			// Write the file content to the response output stream
			byte[] buffer = new byte[4096];
			int bytesRead;
			while ((bytesRead = fileInputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}

			// Close the streams
			fileInputStream.close();
			outputStream.close();
		} catch (IOException e) {
			// Handle the exception
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/deleteReferenceDocument", method = RequestMethod.POST)
	public String deleteReferenceDocument(@RequestParam("documentId") String documentId, Model model) {
		rs.deleteReferenceDocument(documentId);
		return "documentList";
	}

}
