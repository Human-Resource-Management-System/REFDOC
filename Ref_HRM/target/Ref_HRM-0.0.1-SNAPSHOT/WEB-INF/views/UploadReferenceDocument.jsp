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

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      font-weight: bold;
      display: block;
      margin-bottom: 5px;
    }

    .form-group input[type="text"],
    .form-group textarea,
    .form-group select {
      width: 300px;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 16px;
    }

    .form-group textarea {
      height: 100px;
    }

    .form-group input[type="file"] {
      margin-top: 5px;
    }

    .submit-button {
      margin-top: 10px;
      font-size: 16px;
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .submit-button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <h1>Upload Document</h1>

  <form id="DocumentSave" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="docname">Document Name:</label>
      <input type="text" id="docname" name="docname" required>
    </div>

    <div class="form-group">
      <label for="category">Category:</label>
      <select id="category" name="category">
        <option value="employee-handbook">Employee Handbook</option>
        <option value="code-of-conduct">Code of Conduct</option>
        <option value="anti-harassment-policy">Anti-Harassment Policy</option>
        <option value="it-security-policy">IT Security Policy</option>
        <option value="travel-expense-policy">Travel and Expense Policy</option>
      </select>
    </div>

    <div class="form-group">
      <label for="description">Description:</label>
      <textarea id="description" name="description"></textarea>
    </div>

    <div class="form-group">
      <label for="file-upload">Upload Document:</label>
      <input type="file" id="file-upload" name="document" required>
    </div>

    <input class="submit-button" type="submit" value="Upload">
  </form>

  <script>
    const form = document.getElementById('document-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();

      const docname = document.getElementById('docname').value;
      const category = document.getElementById('category').value;
      const description = document.getElementById('description').value;
      const fileInput = document.getElementById('file-upload');
      const file = fileInput.files[0];

      if (!docname || !category || !file) {
        alert('Please fill in all the required fields and upload a document.');
        return;
      }

      const formData = new FormData();
      formData.append('docname', docname);
      formData.append('category', category);
      formData.append('description', description);
      formData.append('document', file);

      // You can use AJAX or fetch API to send the form data to the server for processing
      // Example using fetch API
      fetch('/addReferenceDocument', {
        method: 'GET',
        body: formData
      })
      .then(response => {
        if (response.ok) {
          alert('Document uploaded successfully!');
          form.reset();
        } else {
          throw new Error('Error uploading document.');
        }
      })
      .catch(error => {
        alert(error.message);
      });
    });
  </script>
</body>
</html>
