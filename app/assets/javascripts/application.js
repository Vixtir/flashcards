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
	$('.check_page').on('click', '.start_exam', function(){
	  	
		window.d = 0;
      	setInterval(myTimer, 1000);
      	
      	function myTimer() {     		  
        	  window.d = d + 1;
        	  document.getElementById('timer').innerHTML = window.d;
      	}

		$(this).hide();
		$.ajax('/', {
			type: 'POST',
			dataType: 'json',
			success: function(response){
				var id = response.id;
				var question = response.original_text;
				$('.card_id').html(id);
				$('.question').html(question);
				$('.question_form').fadeIn();
			}
		});
	});

    $('.question_form').on('click', '.check_button', function(){
		var id = $('.card_id').text();
		var answer = $('.answer').val();
		var time = $('#timer').text();
		$('.alert').hide();
		$.ajax('/check', {
			type: 'POST',
			dataType: 'json',
			data: { 'id': id, 'answer': answer, 'time': time },
			success: function(response){
				window.d = 0; 
				if( response.card ){
					var nId = response.card.id;
				  	var nAnswer = response.card.original_text;
				
					$('.card_id').html(nId);
					$('.question').html(nAnswer);
					$('.alert').html(response.message).fadeIn();
					
				} else {
					$('.question_form').hide();
					$('.alert').fadeIn(100);
				}

			}
		});
	});
});