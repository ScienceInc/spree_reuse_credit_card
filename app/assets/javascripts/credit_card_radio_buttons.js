// BILLING INFO
$(document).ready(function (){
  if ($("#use_existing_card_yes").val() == "yes"){
    $("#the-card").hide();
    if ($("#existing_cards input[type=radio]:checked").length > 0) {
      $('#cta-submit').removeClass('bg-disabled').addClass('bg-primary');
    }
  }
  $("#use_existing_card_yes").on("click", function(){
    $("#the-card").hide();
    $("#existing_cards").show();
  });
  $("#use_existing_card_no").on("click", function(){
    $("#existing_cards input[type=radio]:checked").removeAttr('checked');
    $("#existing_cards").hide();
    $("#the-card").show();
    if( $('#cart-billing .input-text-wrap.incomplete-flag input, #cart-billing .input-dropdown-wrap.incomplete-flag select').size() > 0 ){
      $('#cta-submit').removeClass('bg-primary').addClass('bg-disabled');
    }
  });
  $("#existing_cards input[type=radio]").on("click", function(){
    $('#cta-submit').removeClass('bg-disabled').addClass('bg-primary');
  });
});
