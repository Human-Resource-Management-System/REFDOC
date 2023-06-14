
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }

    h1 {
      font-size: 24px;
      margin-bottom: 10px;
    }

    .category {
      margin-bottom: 20px;
    }

    .category-title {
      font-weight: bold;
      font-size: 20px;
      margin-bottom: 10px;
    }

    .document {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }

    .document-name {
      margin-right: 10px;
    }

    .document-link {
      color: blue;
      text-decoration: underline;
      cursor: pointer;
    }
    
    .category-select {
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
  <h1>Reference Documents</h1>

  <div class="category-select">
    <label for="category">Select Category:</label>
    <select id="category" name="category" onchange="filterDocumentsByCategory()">
      <option value="all">All Categories</option>
      <option value="employee-handbook">Employee Handbook</option>
      <option value="code-of-conduct">Code of Conduct</option>
      <!-- Add more category options here -->
    </select>
  </div>
  
   <!-- Iterate over the list of documents -->
    <c:forEach items="${documents}" var="document">
        <div class="category">
            <div class="category-title">${document.getCategory()}</div>
            <div class="document">
                <div class="document-name">${document.getDocName()}</div><br>
                <div class="document-link" onclick="openDocument('${document.getPath()}')">View</div>&nbsp;&nbsp;
                <div class="document-link" onclick="deleteDocument('${document.getId()}')">Delete</div>
            </div>
        </div>
    </c:forEach>

  <div class="category" id="code-of-conduct">
    <div class="category-title">Code of Conduct</div>
    <div class="document">
      <div class="document-name">Code of Conduct - Document 1</div><br>
      <div class="document-link" onclick="openDocument('code-of-conduct/doc1.pdf')">View</div>&nbsp;&nbsp;
       <div class="document-link" onclick="deleteDocument('document1')">Delete</div>
    </div>
    <div class="document">
      <div class="document-name">Code of Conduct - Document 2</div><br>
      <div class="document-link" onclick="openDocument('code-of-conduct/doc2.pdf')">View</div>&nbsp;&nbsp;
       <div class="document-link" onclick="deleteDocument('document1')">Delete</div>
    </div>
  </div>

  <!-- Add more categories and documents as needed -->

  <script>
    function filterDocumentsByCategory() {
      const categorySelect = document.getElementById('category');
      const selectedCategory = categorySelect.value;

      // Hide all categories
      const categories = document.getElementsByClassName('category');
      for (let i = 0; i < categories.length; i++) {
        categories[i].style.display = 'none';
      }

      // Show the selected category or all categories if "All Categories" is selected
      if (selectedCategory === 'all') {
        for (let i = 0; i < categories.length; i++) {
          categories[i].style.display = 'block';
        }
      } else {
        const selectedCategoryElement = document.getElementById(selectedCategory);
        if (selectedCategoryElement) {
          selectedCategoryElement.style.display = 'block';
        }
      }
    }

    function openDocument(documentPath) {
      // Replace with your logic to open the document
      console.log('Opening document:', documentPath);
      // For example
    }
    function deleteDocument(documentId) {
    	  // Perform an AJAX request to delete the document
    	  // Replace 'your-delete-endpoint' with the actual endpoint URL for deleting a document
    	  // You may need to include additional logic or parameters based on your backend implementation

    	  fetch('/deleteReferenceDocument', {
    	    method: 'DELETE',
    	    headers: {
    	      'Content-Type': 'application/json',
    	    },
    	    body: JSON.stringify({ documentId: documentId }),
    	  })
    	    .then((response) => response.json())
    	    .then((data) => {
    	      // Handle the response after deleting the document
    	      // For example, you can show a success message, update the UI, or refresh the document list
    	      console.log('Document deleted:', data);
    	      showMessage('Document deleted successfully.');
    	      updateUI(documentId); 
    	    })
    	    .catch((error) => {
    	      // Handle any errors that occur during the deletion process
    	      console.error('Error deleting document:', error);
    	      showMessage('Error deleting document. Please try again.');
    	    });
    	}
    function showMessage(message) {
    	  // Assuming you have a message element in your HTML, e.g., <div id="message"></div>
    	  const messageElement = document.getElementById('message');
    	  messageElement.textContent = message;
    	  messageElement.style.display = 'block';
    	}
    function updateUI(documentId) {
    	  // Find the document element to be removed
    	  const documentElement = document.getElementById(documentId);

    	  // Remove the document element from the DOM
    	  if (documentElement) {
    	    documentElement.remove();
    	  }
    	}

  </script>
</body>
</html>
