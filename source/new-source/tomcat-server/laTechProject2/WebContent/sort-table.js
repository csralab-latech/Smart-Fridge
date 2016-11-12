/**
 * This is a JavaScript file for sorting tables.
 * 
 * Author: Evan Roberts
 * 
 * The original sorting concept and code is from "JavaScript & JQuery" by Jon Duckett 
 */

// This object holds data-types and their associated compare functions.
var compare = {
		// Use this data-type for sorting things alphabetically
		alpha: function(a, b) {
			a = a.toLowerCase();
			b = b.toLowerCase();
			
			if (a < b) {
				return -1;
			} else {
				return a > b ? 1 : 0;
			}
		}, // This is a spare data-type for sorting by time
		duration: function(a, b) {
			a = a.split(':');
			b = b.split(':');
			
			a = Number(a[0]) * 60 + Number(a[1]);
			b = Number(b[0]) * 60 + Number(b[1]);
			
			return a - b;
		}, // This is a spare data-type for sorting by date
		date: function(a, b) {
			a = new Date(a);
			b = new Date(b);
			
			return a - b;
		}, // This is a spare data-type for sorting numerically
		num: function(a, b) {
			a = Number(a);
			b = Number(b);
			
			return a - b;
		}, // Use this data-type for sorting days until expiration
		expire: function(a, b) {
			a = a.replace(' day(s)', '');
			b = b.replace(' day(s)', '');
			
			a = Number(a);
			b = Number(b);
			
			return a - b;
		},
};

// This code block adds an on click listener to each table column
$('.sortable').each(function() {
	var $table = $(this);
	var $tbody = $table.find('tbody');
	var $controls = $table.find('th');
	var rows = $tbody.find('tr').toArray();
	
	// This defines the on click listener for each header
	$controls.on('click', function() {
		var $header = $(this);
		var order = $header.data('sort');
		var column;
		
		// Toggle ascending/descending if the column is already sorted
		if ($header.is('.ascending') || $header.is('.descending')) {
			$header.toggleClass('ascending descending');
			$tbody.append(rows.reverse());
			
			// Change the headers of each column
			changeText();
		} else if (compare.hasOwnProperty(order)) { // Add ascending to the clicked column if it is unsorted
			$header.addClass('ascending');
			// Reset the other column classes
			$header.siblings().removeClass('ascending descending');
			 
			column = $controls.index(this);
			
			rows.sort(function(a,b) {
				a = $(a).find('td').eq(column).text();
				b = $(b).find('td').eq(column).text();
				return compare[order](a,b);
			});
			
			$tbody.append(rows);
			
			// Change the headers of each column
			changeText();
		}
	});
});

// This function defines how to change each column header
function changeText() {
	// Get each sortable column header
	var headers = document.getElementsByClassName("sortable-header");

	// For each header...
	for (var i = 0; i < headers.length; i++) {
		var header = headers[i];	// Get the current header
		var sort = header.getAttribute("data-sort");	// Get the data-type
		var span = header.getElementsByClassName("glyphicon")[0];	// Get the glyphicon span for the current header

		/*
		 * If the column is sorted ascending...
		 * 		and the data-type is alpha, use the alphabetical symbol
		 * 		otherwise, use the numerical symbol
		 * Else, if the column is sorted descending...
		 * 		and the data-type is alpha, use the alternate alphabetical symbol
		 * 		otherwise, use the alternate numerical symbol
		 * Otherwise, use the unsorted symbol
		 */
		if ($(header).hasClass("ascending")) {
			if (sort == "alpha") {
				span.className = "glyphicon glyphicon-sort-by-alphabet";
			} else {
				span.className = "glyphicon glyphicon-sort-by-order";
			}
		} else if ($(header).hasClass("descending")) {
			if (sort == "alpha") {
				span.className = "glyphicon glyphicon-sort-by-alphabet-alt";
			} else {
				span.className = "glyphicon glyphicon-sort-by-order-alt";
			}
		} else {
			span.className = "glyphicon glyphicon-sort";
		}
	}
}