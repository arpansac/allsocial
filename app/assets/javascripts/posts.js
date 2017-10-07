
function addAutocomplete(){
	$( "#user-search" ).autocomplete({
      source: "/users/filter_by_email",
      // minLength: 2,
      select: function( event, ui ) {
        console.log( "Selected: " + ui.item.value + " aka " + ui.item.id );
        window.location.href = "/users/" + ui.item.id;
      }
    });
}


window.addEventListener('load', addAutocomplete);
