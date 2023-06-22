<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
  <style>
   body {
      font-family: Arial, sans-serif;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      background-color: #f2f2f2;
    }

    .form-container {
      width: 400px;
      padding: 20px;
      background-color: #ffffff;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    h1 {
      font-size: 24px;
      margin-bottom: 10px;
      text-align: center;
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
 <div class="form-container">
    <h1>Upload Document</h1>

  <form action="DocumentSave" method="POST" >
    <div class="form-group">
      <label for="docname">Document Name:</label>
      <input type="text" id="docname" name="docname" required>
    </div>

    <div class="form-group">
      <label for="category">Category:</label>
      <select id="category" name="category">
        <option value="Employee Handbook">Employee Handbook</option>
        <option value="Code of Conduct">Code of Conduct</option>
        <option value="Anti Harassment Policy">Anti Harassment Policy</option>
        <option value="IT Security Policy">IT Security Policy</option>
        <option value="Travel and Expense Policy">Travel and Expense Policy</option>
      </select>
    </div>

    <div class="form-group">
      <label for="file-upload">Upload Document:</label>
      <input type="file" id="file-upload" name="documentData" required>
    </div>

    <input class="submit-button" type="submit" value="Upload">
  </form>

  <script>
    const form = document.getElementById('document-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();

      const docName = document.getElementById('docName').value;
      const category = document.getElementById('category').value;
      const documentData = document.getElementById('documentData').value;
  
      if (!docName || !category || !file) {
        alert('Please fill in all the required fields and upload a document.');
        return;
      }

      const formData = new FormData();
      formData.append('docName', docName);
      formData.append('category', category);
      formData.append('documentData', documentData);
   //   formData.append('document', file);
      
      fetch('/DocumentSave', {
        method: 'POST',
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
