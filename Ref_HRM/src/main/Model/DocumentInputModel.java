package main.Model;

import org.springframework.web.multipart.MultipartFile;

public class DocumentInputModel {
	private String docname;
	private String category;
	private MultipartFile documentData;

	public DocumentInputModel() {

	}

	public DocumentInputModel(String docname, String category, MultipartFile documentData) {
		this.docname = docname;
		this.category = category;
		this.documentData = documentData;
	}

	public String getDocname() {
		return docname;
	}

	public void setDocname(String docname) {
		this.docname = docname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public MultipartFile getDocumentData() {
		return documentData;
	}

	public void setDocumentData(MultipartFile documentData) {
		this.documentData = documentData;
	}
}
