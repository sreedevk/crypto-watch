// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function navbarToggle(){
  $("#nav-toggle").click(function(){
    $('.sidebar').toggleClass("active-sidebar");
    $('.main-panel').toggleClass("active-main");
  });
}

function newsSearch(){
  $('.news-search').on("keyup", function(){
    $.ajax({
      type: 'GET',
      url: '/crypto_news?keyword=' + $(this).val(),
      dataType: "script"
    });
  });
}

function currencySelect(){
  $('.currency-select').select2({
    placehoder: 'Select A Currency'
  });
  $('.currency-select').on("change", function(){
    window.location.href="/currency_summary?currency_id=" + $(this).val();
  });
};

function currencyTableSelect(){
  $('.currency-item').click(function(){
    window.location.href="/currency_summary?currency_id=" + $(this).attr('data-attr');
  });
}

function ajaxPagination(){
  $('.pagination a').each(function(){
    $(this).attr("data-remote", 'true');
  });
}

function socialIcon(){
  $('.social-icon').mouseover(function(){
    $(this).toggleClass("social-icon-hover");
  }).mouseout(function(){
    $(this).toggleClass("social-icon-hover");
  });
}

function socialTip(){
  tippy(".social-icon", {
    delay: 100,
    arrow: true,
    size: 'large',
    animation: 'shift-toward',
    placement: 'bottom'
  });
}

function tooltip(){
  tippy('.tooltip-block', {
    delay: 100,
    arrow: true,
    size: 'large',
    animation: 'shift-toward',
    placement: 'bottom'
  });
}

function subscription(){
  $('#subscription-form').submit(function(e){
    if($(this).find('input[type="email"]').val().length > 1){
      $.ajax({
        type: 'POST',
        url: '/newsletter',
        data: {'email': $(this).find("input[name='email']").val(), 'name': $(this).find("input[name='name']").val()},
        success: function(e){
          toastr.success(e.message); 
          console.log(e);
        },
        error: function(xhr){
          var message = JSON.parse(xhr.responseText).message 
          toastr.error(message);
        }
      });
    }else{
      toastr.warning("Please Enter Valid Details");
    }
    
    e.preventDefault();
  });
}

function currencySummaryTable(){
  //$('#currency-history-table').DataTable({
  //});
}

$(document).on('turbolinks:load', function(){
  navbarToggle();
  newsSearch(); 
  currencySelect();
  currencyTableSelect();
  socialIcon();
  socialTip();
  tooltip();
  subscription();
  ajaxPagination();
  //currencySummaryTable();
});
