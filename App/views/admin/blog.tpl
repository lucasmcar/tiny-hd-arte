<style>

body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    padding-top: 80px;
}

 .title-input {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        font-size: 18px;
    }

    .save-button {
        display: block;
        margin-top: 10px;
        padding: 10px 15px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .save-button:hover {
        background-color: #218838;
    }

			.main-container {
				width: 795px;
				margin-left: auto;
				margin-right: auto;
			}
		</style>
        <div class="main-container">
        <input type="text" id="title" class="title-input" placeholder="Digite o título aqui">
			<div id="editor">
				<p>Hello from CKEditor 5!</p>
			</div>
            <button class="save-button" id="saveBtn">Salvar</button>
		</div>
		<script type="importmap">
			{
				"imports": {
					"ckeditor5": "/assets/ckeditor/ckeditor5.js",
					"ckeditor5/": "/assets/ckeditor/"
				}
			}
		</script>
		<script type="module">
			import {
				ClassicEditor,
				Essentials,
				Paragraph,
				Bold,
				Italic,
				Font
			} from 'ckeditor5';

            ClassicEditor
                .create( document.querySelector( '#editor' ), {
                    licenseKey: 'GPL', // Or <YOUR_LICENSE_KEY>
                    plugins: [ Essentials, Paragraph, Bold, Italic, Font ],
                    toolbar: [
						'undo', 'redo', '|', 'bold', 'italic', '|',
						'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor'
					],
					licenseKey: 'GPL'
				} )
				.then( editor => {
					window.editor = editor;
				} )
				.catch( error => {
					console.error( error );
				} );
		</script>
		<!-- A friendly reminder to run on a server, remove this during the integration. -->
		<script>
				window.onload = function() {
					if ( window.location.protocol === "file:" ) {
						alert( "This sample requires an HTTP server. Please serve this file with a web server." );
					}
				};
		</script>
<script src='/assets/js/fetch.js'></script>

<script>
let fetch = new Fetch("http://localhost:8000")
    fetch.post()
</script>