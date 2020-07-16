<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<% BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
   String uploadUrl = blobstoreService.createUploadUrl("/upload-notes"); %>

<html>
  <head>
    <meta charset="UTF-8">
    <title>Upload Notes</title>
    <script src="https://unpkg.com/vue"></script>
    <script src="https://unpkg.com/http-vue-loader"></script>
    <link rel="stylesheet" href="styles/upload-notes-form.css">
    <script src="upload.js"></script>
  </head>
  <body>
    <div id="my-nav">
      <navigation :user="user"></navigation>
    </div>
    <div id="form-content">
      <h1>Upload Notes</h1>
      <form method="POST"
            enctype="multipart/form-data"
            action="<%= uploadUrl %>"
            id="upload-form">
        <div class="form-item">
          <label for="title">Title</label>
          <input type="text" name="title">
        </div>
        <div class="form-item">
          <label for="school">School</label>
          <input type="text" name="school">
        </div>
        <div class="form-item">
          <label for="course">Course</label>
          <input type="text" name="course">
        </div>
        <div class="form-item">
          <label for="other-tags">Other Tags</label>
          <textarea name="other-tags" cols="50" rows="5"></textarea>
        </div>
        <div class="form-item">
          <label for="notes-pdf">Notes PDF</label>
          <iframe id="preview" height="400" width="350"></iframe>
          <br>
          <input type="file"
                accept="application/pdf"
                name="notes-pdf"
                onchange="previewUploadedFile(this)"
                required>
          </div>
        <input type="submit">
      </form>
    </div>
    <script>
      new Vue({
        el: '#my-nav',
        components: {
          'navigation': httpVueLoader('components/navbar.vue')
        },
        data: {
          user: {
            name: 'Bob the Builder',
            points: 597
          }
        }
      });
    </script>
  </body>
</html>