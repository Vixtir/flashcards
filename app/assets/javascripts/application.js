// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('page:change', function(){
	var d = 0;
    setInterval(myTimer, 1000);
      	
    function myTimer() {     		  
      document.getElementById('timer').innerHTML = d++;
    }

    var clear = function(){
    	d = 0;
    }

	$('.question_form').on('click', '.check_button', function(){
		$('.alert').hide();
		$.ajax('/check', {
			type: 'POST',
			dataType: 'json',
			data: { 'id': $('.card_id').text(), 'answer': $('.answer').val(), 'time': $('#timer').text() },
			success: function(response){
				if( response.card ){
					clear()
					$('.card_id').html(response.card.id);
					$('.question').html(response.card.original_text);
					$('.alert').html(response.message).fadeIn();
					
				} else {
					$('.question_form').hide();
					$('.alert').fadeIn(100);
				}
			}
		});
	});
});
