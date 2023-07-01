
package main.DAO;

import java.util.List;

import org.springframework.stereotype.Repository;

import main.Model.EmployeeRefDocuments;

@Repository
public interface ReferenceDocumentDAOInterface {

	EmployeeRefDocuments findById(String id);

	void save(EmployeeRefDocuments document);

	List<EmployeeRefDocuments> getAllDocs();

	int getIndex();

	void deleteById(int id);

	int getDOCIndex(String docname);

}