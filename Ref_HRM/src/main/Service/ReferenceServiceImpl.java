package main.Service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import main.DAO.ReferenceDAOInterface;
import main.Model.EmployeeRefDocuments;

@Service
public class ReferenceServiceImpl implements ReferenceServiceInterface {

	@Autowired
	private EmployeeRefDocuments document;// entity model class

	@Autowired
	private ReferenceDAOInterface rd;// DAO interface

	public EmployeeRefDocuments getReferenceDocumentById(String id) {
		return rd.findById(id);
	}

	public void addReferenceDocument(EmployeeRefDocuments document) {

		int id = rd.getIndex();// to know last id in the db
		document.setId(id);

		LocalDate dt = LocalDate.now();// to insert the date of upload/change
		document.setLastUpdatedDate(dt);

		document.setLastUpdatedUser(123);// static representation of the user until the sessions involve

		rd.save(document);// calling to DAO class to persist
		System.out.println("EmployeeRefDocument inserted successfully.");
	}

	public void deleteReferenceDocument(String docname) {
		int id = rd.getIndex();// to know last id in the db
		document.setId(id);
		rd.deleteById(id);
	}

	public List<EmployeeRefDocuments> getAllDocuments() {
		return rd.getAllDocs();
	}
}
