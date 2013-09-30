// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require_tree .
$(function() {
  $('#check_all').click (function (){
    var checkedStatus = this.checked;
    $('.table tbody tr').find('td:first :checkbox').each(function(){
       $(this).prop('checked', checkedStatus);
    });
  });


});
function callAjax(resource,url_path,http_action,resource_type){
  var dataObj = {};
  var selected = $(resource).val();
  dataObj['resource_id']=selected;
  dataObj['resource_type']=resource_type;
  $.ajax({
    type: http_action,
    data: dataObj,
    url: url_path//,
    //success: function(result){
      // var options = '';
      // options += '<option value="">'+default_text+'</option>';
      //   for (var i = 0; i < result.length; i++) {
      //       options += '<option value="' + result[i][1] + '">' + result[i][0] + '</option>';
      //   }
      // $("#"+update_id).html(options);
      // var options=$("#"+update_id)[0]
      // $(options[0]).attr('disabled','true')
        //if ($("#"+mydata.id).prop("multiple") && $("#"+update_id).prop("multiple")) {$("#"+update_id).append(options);} else{$("#"+update_id).html(options);}
    //}
  })
}