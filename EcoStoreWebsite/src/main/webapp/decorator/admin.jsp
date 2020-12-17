<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><dec:title default="Trang quản trị" </title>
    <meta name="description" content="Sufee Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="apple-icon.png">
    <link rel="shortcut icon" href="favicon.ico">

    <link rel="stylesheet" href="<c:url value='/template/admin/vendors/bootstrap/dist/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/template/admin/vendors/font-awesome/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/template/admin/vendors/datatables.net-bs4/css/dataTables.bootstrap4.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/template/admin/vendors/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css'/>">

    <link rel="stylesheet" href="<c:url value='/template/admin/assets/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/css/crud.css'/>">

    <!-- web fonts -->
    <link
            href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i&amp;subset=latin-ext"
            rel="stylesheet">
    <link
            href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&amp;subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese"
            rel="stylesheet">
    <!-- //web fonts -->

    <script src="<c:url value='/template/admin/vendors/jquery/dist/jquery.min.js'/>"></script>
    <script src="<c:url value='/template/admin/vendors/popper.js/dist/umd/popper.min.js'/>"></script>
    <script src="<c:url value='/template/admin/vendors/bootstrap/dist/js/bootstrap.min.js'/>"></script>

    <script>
        $(document).ready(function () {
            // Select/Deselect checkboxes
            var checkbox = $('table tbody input[type="checkbox"]');
            $("#selectAll").click(function () {
                if (this.checked) {
                    checkbox.each(function () {
                        this.checked = true;
                    });
                } else {
                    checkbox.each(function () {
                        this.checked = false;
                    });
                }
            });
            checkbox.click(function () {
                if (!this.checked) {
                    $("#selectAll").prop("checked", false);
                }
            });
        });
    </script>
</head>
<body>
    <%@ include file="/common/admin/menu.jsp" %>

    <div id="right-panel" class="right-panel">
        <%@ include file="/common/admin/header.jsp" %>
        <dec:body/>
    </div>

    <!-- Right Panel -->
    <script src="<c:url value='/template/admin/vendors/datatables.net/js/jquery.dataTables.min.js'/>"></script>
    <script src="<c:url value='/template/admin/vendors/datatables.net-bs4/js/dataTables.bootstrap4.min.js'/>"></script>
    <script src="<c:url value='/template/admin/assets/js/init-scripts/data-table/datatables-init.js'/>"></script>
</body>
</html>
