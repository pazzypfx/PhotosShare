$(document).ready(function() {
    $('#datatable').DataTable({
        lengthChange: false,
        searching: false,
    });
});

$('.form-file-multiple .inputFileVisible, .form-file-multiple .input-group-btn').click(function() {
    $(this).parent().parent().find('.inputFileHidden').trigger('click');
    $(this).parent().parent().addClass('is-focused');
});
