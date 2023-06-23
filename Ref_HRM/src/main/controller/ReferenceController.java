package main.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import main.Model.DocumentInputModel;
import main.Model.EmployeeRefDocuments;
import main.Service.ReferenceServiceInterface;

@Controller
public class ReferenceController {
	@Autowired
	private ReferenceServiceInterface rs;// service interface

	@Autowired
	private EmployeeRefDocuments document;// Entity model class

	@RequestMapping(value = "/viewReferenceDocument/{id}", method = RequestMethod.POST)
	// {id} will map the id variable from the URL to the id parameter of the method
	public String viewReferenceDocument(@PathVariable("id") String id, Model model) {
		document = rs.getReferenceDocumentById(id);
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
	public String saveDocument(@ModelAttribute DocumentInputModel dim, Model model, HttpServletRequest req) {
		EmployeeRefDocuments document = new EmployeeRefDocuments();
		MultipartFile documentData = dim.getDocumentData();
		String Docname = documentData.getOriginalFilename();// Extract the file name from the MultipartFile
		document.setDocName(Docname);
		document.setCategory(dim.getCategory());

		System.out.println("start");

		if (documentData != null && !documentData.isEmpty()) {
			try {

				System.out.println("setting path");

				byte[] documentBytes = documentData.getBytes();// Save the document to the specified file path
				String path = req.getServletContext().getRealPath("/") + "WEB-INF" + File.separator + "views"
						+ File.separator + "Files" + File.separator + dim.getDocumentData().getOriginalFilename();

				System.out.println(path);

				document.setDescription(path);// Set the description as the file path
				FileOutputStream fos = new FileOutputStream(path);
				fos.write(documentBytes);
				fos.close();

				System.out.println("File uploaded successfully");

				rs.addReferenceDocument(document);// Add the document to the database

				model.addAttribute("message", "Document uploaded successfully!");// Display success message
			} catch (IOException e) {
				model.addAttribute("error", "Failed to upload the document!");// Handle the exception
			}
		} else {
			model.addAttribute("error", "No document found to upload!");// Handle the case when no document is uploaded
		}
		System.out.println("success");
		return "success";
	}

	@RequestMapping(value = "/OpenDocument", method = RequestMethod.GET)
	public void openDocument(@RequestParam("docname") String docname, HttpServletResponse response,
			HttpServletRequest request) {
		// Construct the file path based on the selected docname
		String filePath = request.getServletContext().getRealPath("/") + "WEB-INF" + File.separator + "views"
				+ File.separator + "Files" + File.separator + docname;

		System.out.println(filePath);

		try {
			File file = new File(filePath);
			System.out.println("In here");

			if (file.exists()) {
				String contentType = request.getServletContext().getMimeType(docname);
				response.setContentType(contentType);
				response.setHeader("Content-Disposition", "inline; filename=\"" + docname + "\"");

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
				OutputStream outputStream = response.getOutputStream();

				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}

				inputStream.close();
				outputStream.flush();
				outputStream.close();

			} else {
				System.out.println("No File exists");
			}
		} catch (IOException e) {
			// Handle the exception
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/deleteReferenceDocument", method = RequestMethod.GET)
	public String deleteReferenceDocument(@RequestParam("docname") String docname, Model model,
			HttpServletRequest request) {
		System.out.println("going to delete");
		rs.deleteReferenceDocument(docname);
		return "documentList";
	}
}
