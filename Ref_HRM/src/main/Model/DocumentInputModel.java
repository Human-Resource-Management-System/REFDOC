package main.Model;

import java.io.File;

public class DocumentInputModel {
	private String docname;
	private String category;
	private File documentData;

	public DocumentInputModel() {

	}

	public DocumentInputModel(String docname, String category, File documentData) {
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

	public File getDocumentData() {
		return documentData;
	}

	public void setDocumentData(File documentData) {
		this.documentData = documentData;
	}
}
