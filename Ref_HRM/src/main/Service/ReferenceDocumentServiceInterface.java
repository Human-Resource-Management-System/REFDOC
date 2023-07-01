package main.Service;

import java.util.List;

import main.Model.EmployeeRefDocuments;

public interface ReferenceDocumentServiceInterface {

	public EmployeeRefDocuments getReferenceDocumentById(String id);

	public void addReferenceDocument(EmployeeRefDocuments document);

	public void deleteReferenceDocument(String docname);

	public List<EmployeeRefDocuments> getAllDocuments();
}
