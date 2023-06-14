
package main.DAO;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import main.Model.EmployeeRefDocuments;

@Repository
public class ReferenceDAO implements ReferenceInterface {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	@Transactional
	public EmployeeRefDocuments findById(String id) {
		return entityManager.find(EmployeeRefDocuments.class, id);
	}

	@Override
	@Transactional
	public void save(EmployeeRefDocuments document) {
		entityManager.persist(document);
	}

	@Override
	@Transactional
	public void deleteById(String id) {
		EmployeeRefDocuments document = entityManager.find(EmployeeRefDocuments.class, id);
		if (document != null) {
			entityManager.remove(document);
		}
	}

	@Override
	@Transactional
	public List<EmployeeRefDocuments> getAllDocs() {
		String query = "SELECT doc FROM EmployeeRefDocuments doc";
		return entityManager.createQuery(query).getResultList();
	}
}
