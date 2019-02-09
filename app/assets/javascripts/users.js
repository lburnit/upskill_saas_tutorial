/* global $, Stripe */
//Document Ready
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  //Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content'));
  
  //When user clicks form submit button
  submitBtn.click(function (event){
    //Prevent default submission behavior.  
    event.preventDefault();
    submitBtn.val("Processing").prop('disabled', true);
    
    //collect credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    //use stripe js library to check for card errors
    var error = false;
    //validate card number
    if(!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert('The credit card number appears to be invalid');
    }
    
    //Validate CVC number
    if(!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert('The CVC number appears to be invalid');
    }
    
    //validate Expiry number
    if(!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert('The Expiration date appears to be invalid');
    }
    
    if (error) {
      //if any errors, DO NOT send to stripe
      submitBtn.prop('disabled', false).val("Sign Up");
    } else {
        //send the card info to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
        
  
    
    return false;
  });
  
  //Stripe will return back with a card token.
  function stripeResponseHendler(status, response) {
    // Get the token from the response
    var token = response.id;
    
    //Inject card token in hidden field
    theForm.append( $('<input type="hidden" name="user[stripe_card_token]>').val(token));
    
    //Submit form to our Rails app
    theForm.get(0).submit();
  }
  
  
  
  
}); 