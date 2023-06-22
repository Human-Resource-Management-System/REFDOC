<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="main.Model.EmployeeRefDocuments" %>
<%@ page import="java.util.List" %>

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
      <option value="Anti-Harrasement-Policy">Anti Harassment Policy</option>
      <option value="IT-Security-Policy">IT Security Policy</option>
      <option value="Travel-and-Expense-Policy">Travel and Expense Policy</option>
    </select>
  </div>

<%
  List<EmployeeRefDocuments> document = (List<EmployeeRefDocuments>) request.getAttribute("document");
%>


  <div class="category" id="employee-handbook">
    <div class="category-title">Employee Handbook</div>
    <% 
    String m = "Employee Handbook";
    for (EmployeeRefDocuments doc : document) {
      if (doc != null && doc.getCategory().equals(m)) { %>
        <div class="document">
          <div class="document-name" onclick="openDocument('<%= doc.getDocName() %>')"><%= doc.getDocName() %></div>
          <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
        </div>
      <% } 
    } %>
  </div>

  <div class="category" id="code-of-conduct">
    <div class="category-title">Code of Conduct</div>
    <% 
    String n = "Code of Conduct";
    for (EmployeeRefDocuments doc : document) {
      if (doc != null && doc.getCategory().equals(n)) { %>
        <div class="document">
          <div class="document-name" onclick="openDocument('<%= doc.getDocName() %>')"><%= doc.getDocName() %></div>
          <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
        </div>
      <% } 
    } %>
  </div>

 <div class="category" id="Anti-Harassment-Policy"> 
  <div class="category-title">Anti Harassment Policy</div>
  <% 
  String p = "Anti Harassment Policy";
  for (EmployeeRefDocuments doc : document) {
    if (doc != null && doc.getCategory().trim().equals(p)) { %>
      <div class="document">
        <div class="document-name" onclick="openDocument('<%= doc.getDocName() %>')"><%= doc.getDocName() %></div>
        <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
      </div>
    <% } 
  } %>
</div>

  <div class="category" id="IT-Security-Policy">
    <div class="category-title">IT Security Policy</div>
    <% 
    String q = "IT Security Policy";
    for (EmployeeRefDocuments doc : document) {
      if (doc != null && doc.getCategory().equals(q)) { %>
        <div class="document">
          <div class="document-name" onclick="openDocument('<%= doc.getDocName() %>')"><%= doc.getDocName() %></div>
          <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
        </div>
      <% } 
    } %>
  </div>

  <div class="category" id="Travel-and-Expense-Policy">
    <div class="category-title">Travel and Expense Policy</div>
    <% 
    String r = "Travel and Expense Policy";
    for (EmployeeRefDocuments doc : document) {
      if (doc != null && doc.getCategory().equals(r)) { %>
        <div class="document">
          <div class="document-name" onclick="openDocument('<%= doc.getDocName() %>')"><%= doc.getDocName() %></div>
          <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
        </div>
      <% } 
    } %>
  </div>

  <div class="add-button">
    <a href="addReferenceDocument">Add Document</a>
  </div>

  <script>
    function filterDocumentsByCategory() {
      var category = document.getElementById("category").value;

      // Show/hide the corresponding categories based on the selected option
      var categories = ["code-of-conduct", "employee-handbook", "Anti-Harassment-Policy", "IT-Security-Policy", "Travel-and-Expense-Policy"];
      for (var i = 0; i < categories.length; i++) {
        var categoryId = categories[i];
        if (category === "all" || category === categoryId) {
          document.getElementById(categoryId).style.display = "block";
        } else {
          document.getElementById(categoryId).style.display = "none";
        }
      }
    }

    function openDocument(docName) {
      console.log('Opening document:', docName);

      // Create a hidden form to submit the request
      var form = document.createElement('form');
      form.setAttribute('method', 'GET');
      form.setAttribute('action', '/OpenDocument');
      form.style.display = 'none';

      // Create a hidden input field to hold the docname value
      var input = document.createElement('input');
      input.setAttribute('type', 'hidden');
      input.setAttribute('name', 'docname');
      input.setAttribute('value', docName);

      // Append the input field to the form
      form.appendChild(input);

      // Append the form to the document body
      document.body.appendChild(form);

      // Submit the form
      form.submit();
    }

    function deleteDocument(documentId) {
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = '/deleteReferenceDocument'; // Replace with the appropriate URL for your delete endpoint

      const documentIdInput = document.createElement('input');
      documentIdInput.type = 'hidden';
      documentIdInput.name = 'documentId';
      documentIdInput.value = documentId;

      form.appendChild(documentIdInput);
      document.body.appendChild(form);
      form.submit();
    }

    function showMessage(message) {
      // Assuming you have a message element in your HTML, e.g., <div id="message"></div>
      const messageElement = document.getElementById('message');
      messageElement.textContent = message;
      messageElement.style.display = 'block';
    }

    function updateUI(documentId) {
      const documentElement = document.getElementById(documentId); // Find the document element to be removed
      if (documentElement) {
        documentElement.remove(); // Remove the document element from the DOM
        refreshPage();
      }
    }

    function refreshPage() {
      location.reload(); // Reload the current page
    }
  </script>
</body>

</html>
