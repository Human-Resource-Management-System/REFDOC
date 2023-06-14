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

  <div class="category" id="employee-handbook">
    <div class="category-title">Employee Handbook</div>
    <div class="document">
      <div class="document-name">Employee Handbook - Document 1</div>
      <div class="document-link" onclick="openDocument('employee-handbook/doc1.pdf')">View</div>
    </div>
    <div class="document">
      <div class="document-name">Employee Handbook - Document 2</div>
      <div class="document-link" onclick="openDocument('employee-handbook/doc2.pdf')">View</div>
    </div>
  </div>

  <div class="category" id="code-of-conduct">
    <div class="category-title">Code of Conduct</div>
    <div class="document">
      <div class="document-name">Code of Conduct - Document 1</div>
      <div class="document-link" onclick="openDocument('code-of-conduct/doc1.pdf')">View</div>
    </div>
    <div class="document">
      <div class="document-name">Code of Conduct - Document 2</div>
      <div class="document-link" onclick="openDocument('code-of-conduct/doc2.pdf')">View</div>
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
  </script>
</body>
</html>