document.addEventListener("turbolinks:load", function() {

	$('#user_datatable').DataTable({
		columnDefs: [
      { width: 200, targets: 0 }
    ],
    "order": [[ 1, "asc" ]]
	});

	$('#query_datatable').DataTable({
		columnDefs: [
      { width: 200, targets: 0 }
    ]
	});
	
});