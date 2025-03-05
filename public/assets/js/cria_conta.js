function previewImage(event) {
    const imgPreview = document.getElementById('imgPreview');
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            imgPreview.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}