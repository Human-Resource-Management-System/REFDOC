<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	 <% 
	 List<EmployeeRefDocuments> er = ( List<EmployeeRefDocuments> ) request.getAttribute("document");
	 String imagePath = request.getContextPath() + "/";%> 
	 
<div class="category-select">
  <label for="category">Select Category:</label>
  <select id="category" name="category" onchange="filterDocumentsByCategory()">
    <option value="all">All Categories</option>
    <option value="employee-handbook">Employee Handbook</option>
    <option value="code-of-conduct">Code of Conduct</option>
        <option value="Anti-Harrasement-Policy">Anti Harrasement Policy</option>
        <option value="IT-Security-Policy">IT Security Policy</option>
        <option value="Travel-and-Expense-Policy">Travel and Expense Policy</option>
    
  </select>
</div>

<div class="category" id="employee-handbook">
  <div class="category-title">Employee Handbook</div>
  <% String m = "Employee Handbook";
  for (EmployeeRefDocuments doc : er) {
    if (doc != null && doc.getCategory().equals(m)) { %>
      <div class="document">
        <%= doc.getDocName() %>&nbsp;&nbsp;
        <div class="document-link" onclick="openDocument('<%= doc.getDocName() %>')">View</div>&nbsp;&nbsp;
        <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
      </div>
    <% } 
  } %>
</div>



<div class="category" id="code-of-conduct">
  <div class="category-title">Code of Conduct</div>
 <%String n = "Code of Conduct";
for(EmployeeRefDocuments doc : er) {
    if(doc != null && doc.getCategory().equals(n)) {%>
    <div class="document">
      <%= doc.getDocName() %>&nbsp;&nbsp;
      <div class="document-link" onclick="openDocument('<%= doc.getDocName() %>')">View</div>&nbsp;&nbsp;
      <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
    </div>
  <% }} %>
</div>

 
  
  <div class="category" id="Anti-Harrasement-Policy"> 
  <div class="category-title">Anti Harrasement Policy</div>
  <% String p = "Anti Harrasement Policy";
  for (EmployeeRefDocuments doc : er) {
    if (doc != null && doc.getCategory().trim().equals(p)) { %>
      <div class="document">
        <%= doc.getDocName() %>&nbsp;&nbsp;
        <div class="document-link" onclick="openDocument('<%= doc.getDocName() %>')">View</div>&nbsp;&nbsp;
        <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
      </div>
    <% } 
  } %>
</div>


<div class="category" id="IT-Security-Policy">
  <div class="category-title">IT Security Policy</div>
  <% String q = "IT Security Policy";
  for (EmployeeRefDocuments doc : er) {
    if (doc != null && doc.getCategory().equals(q)) { %>
      <div class="document">
        <%= doc.getDocName() %>&nbsp;&nbsp;
        <div class="document-link" onclick="openDocument('<%= doc.getDocName() %>')">View</div>&nbsp;&nbsp;
        <div class="document-link" onclick="deleteDocument('<%= doc.getId() %>')">Delete</div>
      </div>
    <% } 
  } %>
</div>

<div class="category" id="Travel-and-Expense-Policy">
  <div class="category-title">Travel and Expense Policy</div>
  <% String r = "Travel and Expense Policy";
  for (EmployeeRefDocuments doc : er) {
    if (doc != null && doc.getCategory().equals(r)) { %>
      <div class="document">
        <%= doc.getDocName() %>&nbsp;&nbsp;
        <div class="document-link" onclick="openDocument('<%= doc.getDescription() %>')">View</div>&nbsp;&nbsp;
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
	  if (category === "all") {
	    document.getElementById("code-of-conduct").style.display = "block";
	    document.getElementById("employee-handbook").style.display = "block";
	    document.getElementById("Anti-Harrasement-Policy").style.display = "block";
	    document.getElementById("IT-Security-Policy").style.display = "block";
	    document.getElementById("Travel-and-Expense-Policy").style.display = "block";
	  }
	  else if (category === "employee-handbook") {
	    document.getElementById("code-of-conduct").style.display = "none";
	    document.getElementById("employee-handbook").style.display = "block";
	    document.getElementById("Anti-Harrasement-Policy").style.display = "none";
	    document.getElementById("IT-Security-Policy").style.display = "none";
	    document.getElementById("Travel-and-Expense-Policy").style.display = "none";
	  } 
	  else if (category === "code-of-conduct") {
	    document.getElementById("code-of-conduct").style.display = "block";
	    document.getElementById("employee-handbook").style.display = "none";
	    document.getElementById("Anti-Harrasement-Policy").style.display = "none";
	    document.getElementById("IT-Security-Policy").style.display = "none";
	    document.getElementById("Travel-and-Expense-Policy").style.display = "none";
	  }
	  else if (category === "Anti-Harrasement-Policy") {
		    document.getElementById("code-of-conduct").style.display = "none";
		    document.getElementById("employee-handbook").style.display = "none";
		    document.getElementById("Anti-Harrasement-Policy").style.display = "block";
		    document.getElementById("IT-Security-Policy").style.display = "none";
		    document.getElementById("Travel-and-Expense-Policy").style.display = "none";
		  }
	  else if (category === "IT-Security-Policy") {
		    document.getElementById("code-of-conduct").style.display = "none";
		    document.getElementById("employee-handbook").style.display = "none";
		    document.getElementById("Anti-Harrasement-Policy").style.display = "none";
		    document.getElementById("IT-Security-Policy").style.display = "block";
		    document.getElementById("Travel-and-Expense-Policy").style.display = "none";
		  }
	  else if (category === "Travel-and-Expense-Policy") {
		    document.getElementById("code-of-conduct").style.display = "none";
		    document.getElementById("employee-handbook").style.display = "none";
		    document.getElementById("Anti-Harrasement-Policy").style.display = "none";
		    document.getElementById("IT-Security-Policy").style.display = "none";
		    document.getElementById("Travel-and-Expense-Policy").style.display = "block";
		  }
	}

  function openDocument(documentPath) {
	  console.log('Opening document:', documentPath);
	  window.open(documentPath);
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
    	const documentElement = document.getElementById(documentId);// Find the document element to be removed
        if (documentElement) {
          documentElement.remove();    // Remove the document element from the DOM
          refreshPage();
        }
    	}
    function refreshPage() {	
  	  location.reload();  // Reload the current page
  	}

  </script>
</body>
</html>