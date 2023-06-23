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
      background-color: #f2f2f2;
    }

    h1 {
      font-size: 28px;
      margin-bottom: 20px;
      color: #333333;
    }

    .category-select {
      margin-bottom: 20px;
    }

    label {
      font-weight: bold;
      color: #333333;
    }

    select {
      padding: 8px;
      border: 1px solid #cccccc;
      border-radius: 5px;
      font-size: 16px;
    }

    .category {
      margin-bottom: 30px;
    }

    .category-title {
      font-weight: bold;
      font-size: 20px;
      margin-bottom: 10px;
      color: #333333;
    }

    .document {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }

    .document-name {
      margin-right: 10px;
      color: #333333;
      font-size: 16px;
    }
.document-name a {
    color: #FF0000; /* Change the color to your preferred color */
    text-decoration: none;
  }

 .delete-button {
    padding: 5px 10px;
    background-color: #FF0000; /* Change the background color to your preferred color */
    color: red;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px; /* Change the font size to your preferred size */
    font-weight: bold; /* Add font weight if desired */
    /* Add any other desired styles */
  }

  .delete-button:hover {
    background-color:  #45a049; /* Change the background color on hover if desired */
    text-decoration: none;
  }
    .add-button {
      margin-top: 20px;
    }

    .add-button a {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      font-size: 16px;
    }

    .add-button a:hover {
      background-color: #45a049;
    }

    #message {
      display: none;
      font-size: 16px;
      margin-top: 20px;
      color: #333333;
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
      <a href="OpenDocument?docname=<%= doc.getDocName() %>"><%= doc.getDocName() %></a>&nbsp;&nbsp;
           <a href="deleteReferenceDocument?docname=<%= doc.getDocName() %>">Delete</a>
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
               <a href="OpenDocument?docname=<%= doc.getDocName() %>"><%= doc.getDocName() %></a>&nbsp;&nbsp;
           <a href="deleteReferenceDocument?docname=<%= doc.getDocName() %>">Delete</a>
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
          <a href="OpenDocument?docname=<%= doc.getDocName() %>"><%= doc.getDocName() %></a>&nbsp;&nbsp;
          <a href="deleteReferenceDocument?docname=<%= doc.getDocName() %>">Delete</a>
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
         <a href="OpenDocument?docname=<%= doc.getDocName() %>"><%= doc.getDocName() %></a>&nbsp;&nbsp;
          <a href="deleteReferenceDocument?docname=<%= doc.getDocName() %>">Delete</a>
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
        <a href="OpenDocument?docname=<%= doc.getDocName() %>"><%= doc.getDocName() %></a>&nbsp;&nbsp;
        <a href="deleteReferenceDocument?docname=<%= doc.getDocName() %>">Delete</a>
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
