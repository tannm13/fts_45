$(function () {
  $(document).on("click", ".remove_fields",function(){
    $(this).parent().parent().children(".removable")[0].value = 1;
    $(this).parent().parent().hide();
    return false;
  });
  $(document).on("click", ".add_child", function() {
    var association = $(this).attr("data-association");
    var regexp = new RegExp("new_" + association, "g");
    var new_id = new Date().getTime();
    $($(this).attr("target")).append(window[association+"_form"]
      .replace(regexp, new_id));
    return false;
  });
  $(document).on("click", "#question_type", function(){
    if($("#question_type option:selected").val()==0){
      $("#answer_form").replaceWith("<%= j render 'admin/questions/answer_form' %>");
    }else if($("#question_type option:selected").val()==1){
    }else{
    }
  });
});
