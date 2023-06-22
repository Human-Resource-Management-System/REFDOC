
package main.DAO;

import java.util.List;

import org.springframework.stereotype.Repository;

import main.Model.EmployeeRefDocuments;

@Repository
public interface ReferenceInterface {

	EmployeeRefDocuments findById(String id);

	void deleteById(String id);

	void save(EmployeeRefDocuments document);

	List<EmployeeRefDocuments> getAllDocs();

	int getIndex();

}