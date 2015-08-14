(function (window) {
	'use strict';

	// get an empty <div>
	var container = document.getElementById('todo-container');

	// embed our Elm program in that <div>
	Elm.embed(Elm.Main, container);

})(window);
