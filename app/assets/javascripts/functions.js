function toggleNestedAttrinuteButton() {

	$(document).on('nested:fieldAdded', function(e) {
		var link = $(e.currentTarget.activeElement);
		if (!link.data('limit')) {
			return;
		};
		if (link.siblings('.fields:visible').length >= link.data('limit')) {
			link.hide();
		};
	});

	$(document).on('nested:fieldRemoved', function(e) {
		var link = $(e.target).siblings('a.add_nested_fields');
		if (!link.data('limit')) {
			return;
		}
		if (link.siblings('.fields:visible').length < link.data('limit')) {
			link.show();
		}
	});
};

function readURL(input, index) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('.imagePreview').eq(index).attr('src', e.target.result);
		};
		reader.readAsDataURL(input.files[0]);
	}
};