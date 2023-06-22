package main.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.DAO.ReferenceInterface;
import main.Model.EmployeeRefDocuments;

@Service
public class ReferenceService {

	@Autowired
	private EmployeeRefDocuments document;

	private final ReferenceInterface rd;

	@Autowired
	public ReferenceService(ReferenceInterface rd) {
		this.rd = rd;
	}

	public EmployeeRefDocuments getReferenceDocumentById(String id) {
		return rd.findById(id);
	}

	public void addReferenceDocument(EmployeeRefDocuments document) {
		int id = rd.getIndex();
		document.setId(id);
		rd.save(document);
		System.out.println("EmployeeRefDocument inserted successfully.");
	}

	public void deleteReferenceDocument(String id) {
		rd.deleteById(id);
	}

	public List<EmployeeRefDocuments> getAllDocuments() {
		return rd.getAllDocs();
	}
}
