<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="APIurl" value="/api-admin-payment"/>
<c:url var="PaymentURL" value="/quan-tri/phuong-thuc-thanh-toan"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý phương thức thanh toán</title>
</head>
<body>

<div class="content mt-3">
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Danh sách phương thức thanh toán</strong>
                    </div>
                    <div class="card-header">
                        <c:if test="${not empty message}">
                            <div class="text-center float-left alert alert-${alert}">${message}</div>
                        </c:if>
                        <div class="float-right">
                            <a href="#addPaymentModal" class="btn btn-success" data-toggle="modal"><i
                                    class="fa fa-plus-circle" aria-hidden="true"></i> <span>Thêm</span></a>
                            <a href="#deletePaymentModal" class="btn btn-danger" data-toggle="modal"><i
                                    class="fa fa-trash-o" aria-hidden="true"></i> <span>Xóa</span></a>
                        </div>
                    </div>
                    <div class="card-body">
                        <table id="bootstrap-data-table-export" class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="text-center">
                                                <span class="custom-checkbox">
                                                    <input type="checkbox" id="selectAll">
                                                    <label for="selectAll"></label>
                                                </span>
                                </th>
                                <th class="text-center">Tên phương thức</th>
                                <th class="text-center">Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${payments}">
                                <tr>
                                    <td class="text-center">
                                                <span class="custom-checkbox">
                                                    <input type="checkbox" id="checkbox_${item.id}"value=${item.id}>
                                                    <label for="checkbox_${item.id}"></label>
                                                </span>
                                    </td>
                                    <td>${item.name}</td>
                                    <c:if test="${item.status == 1}">
                                        <td class="text-center"><span class="status text-success">&bull;</span>Hoạt động
                                        </td>
                                    </c:if>
                                    <c:if test="${item.status == 0}">
                                        <td class="text-center"><span class="status text-danger">&bull;</span>Tạm ngưng
                                        </td>
                                    </c:if>
                                    <td class="text-center">
                                        <a href="<c:url value='/quan-tri/phuong-thuc-thanh-toan?id=${item.id}'/>" class="edit"><i
                                                class="fa fa-pencil"
                                                aria-hidden="true"
                                                data-toggle="tooltip"
                                                title="Chỉnh sửa"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- .animated -->
</div><!-- .content -->


<!-- Add Modal HTML -->
<div id="addPaymentModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="formSubmit">
                <div class="modal-header">
                    <h4 class="modal-title">Thêm phương thức thanh toán</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Tên phương thức</label>
                        <input type="text" class="form-control" name="name" required oninvalid="this.setCustomValidity('Hãy nhập tên phương thức thanh toán!')"
                               oninput="this.setCustomValidity('')" autofocus>
                    </div>
                    <div class="form-group">
                        <label>Trạng thái</label>
                        <select name="status" id="status"  class="form-control">
                            <option value="1">Hoạt động</option>
                            <option value="2">Tạm khóa</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                    <button id="addPayment" type="submit" class="btn btn-success">Thêm</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Delete Modal HTML -->
<div id="deletePaymentModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form>
                <div class="modal-header">
                    <h4 class="modal-title">Xóa phương thức thanh toán </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Bạn chắc chắn muốn xóa những phương thức thanh toán này?</p>
                    <p class="text-warning"><small>Hành động này sẽ không thể khôi phục lại.</small></p>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Hủy">
                    <button id="deletePayment" type="submit" class="btn btn-danger" >Xoá</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<script>
    $('#addPayment').click(function (e) {
        if($('#formSubmit')[0].checkValidity()) {
            e.preventDefault();
            let data = {}; // mang object name: value
            let formData = $('#formSubmit').serializeArray();
            // vong lap
            $.each(formData, function (i, v) {
                data['' + v.name] = v.value
            });
            addPayment(data);
        }
    })

    $('#deletePayment').click(function (e) {
        e.preventDefault();
        let data = {}; // mang object name: value
        // lay data khi check vao cac checkbox
        let dataArray = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val(); // lay value cua input checked
        }).get();
        if (dataArray.length != 0) {
            data['ids'] = dataArray;
            deletePayment(data);
        }
    })

    function deletePayment(data) {
        $('.load').show();
        $.ajax({
            url: '${APIurl}',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                $('.load').hide();
                if(result)
                    window.location.href = "${PaymentURL}?message=delete_success&alert=success";
                else
                    window.location.href = "${PaymentURL}?message=delete_fail&alert=danger";
            },
            error: function (error) {
                $('.load').hide();
                window.location.href = "${PaymentURL}?message=system_error&alert=danger";
            }
        })
    }

    function addPayment(data) {
        $('.load').show();
        $.ajax({
            url: '${APIurl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                $('.load').hide();
                if(result !== null)
                    window.location.href = "${PaymentURL}?id="+result.id+"&message=insert_success&alert=success";
                else
                    window.location.href = "${PaymentURL}?message=insert_fail&alert=danger";
            },
            error: function (error) {
                $('.load').hide();
                window.location.href = "${PaymentURL}?message=system_error&alert=danger";
            }
        })
    }
</script>
</body>
</html>
