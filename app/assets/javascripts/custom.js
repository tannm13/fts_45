var question_type;

ready_var = function() {
  question_type = $(".question_type").val();
  if(question_type == "text"){
    disable_btn_add(true);
  }
}

$(document).ready(ready_var);
$(document).on("page:load",ready_var);

$(function () {
  $(document).on("change", ".question_type", function(){
    question_type = $(".question_type").val();
    if(question_type == "single"){
      $("input.checkbox").each(function(){
        $(this).prop("checked", false);
      });
      disable_btn_add(false)
    }else if(question_type == "text"){
      disable_btn_add(true)
      $(".single_answer:first", function(){
        $(this).find(".remove_fields").hide();
        $(this).find(".checkbox").hide();
        $(this).find(".checkbox-inline").hide();
      });
      $(".single_answer:not(:first)").each(function(){
        $(this).find(".removable").val(1);
        $(this).find(".content_answer").val("");
        $(this).find(".checkbox").prop("checked", false);
        $(this).hide();
      });
    }else if(question_type == "multiple"){
      disable_btn_add(false)
    }
  });

  $(document).on("click", ".checkbox", function(){
    question_type = $(".question_type").val();
    checkbox = this;
    if (question_type == "single"){
      if (checkbox.checked){
        $("input.checkbox").each(function(){
          if (checkbox != this) {
            $(this).prop("checked", false);
          }
        });
      }
    }
  });

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

});
function disable_btn_add(status){
  $(".add_child").prop("disabled", status);
  if(status){
    $(".add_child").hide();
  }else{
    $(".add_child").show();
  }
}

