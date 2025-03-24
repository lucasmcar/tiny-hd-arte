console.log("Editor.js carregado com sucesso!");

function initializeEditor() {
  const editorContent = document.getElementById("content");
  const toolbarButtons = document.querySelectorAll(".toolbar-btn");

  // Mapeamento dos botões e comandos
  const buttonStates = {
    bold: false,
    italic: false,
    underline: false,
    insertUnorderedList: false,
    insertOrderedList: false,
  };

  // Atualiza o estado visual dos botões conforme a formatação aplicada
  function updateToolbarState() {
    toolbarButtons.forEach((btn) => {
      const command = btn.getAttribute("data-command");
      if (command) {
        const isActive = document.queryCommandState(command);
        btn.classList.toggle("active", isActive);
      }
    });
  }

  // Aplica estilo ao texto selecionado e mantém estado ativo para novas digitações
  function applyStyle(command, btn) {
    document.execCommand(command, false, null);
    editorContent.focus();
    updateToolbarState();
  }

  // Adiciona evento de clique aos botões da toolbar
  toolbarButtons.forEach((btn) => {
    const command = btn.getAttribute("data-command");
    if (command) {
      btn.addEventListener("click", function (e) {
        e.preventDefault();
        applyStyle(command, this);
      });
    }
  });

  // Botão de link
  document.getElementById("link-btn").addEventListener("click", function (e) {
    e.preventDefault();
    const url = prompt("Digite a URL do link:");
    if (url) {
      document.execCommand("createLink", false, url);
      editorContent.focus();
      updateToolbarState();
    }
  });

  // Monitorar mudanças na seleção para atualizar os botões ativos
  document.addEventListener("selectionchange", updateToolbarState);

  // Aplicar estilos ao digitar
  editorContent.addEventListener("keyup", updateToolbarState);

  // Upload e pré-visualização de imagens (suporte a múltiplas imagens)
  const imageUpload = document.getElementById("image-upload");
  const imagePreview = document.getElementById("image-preview");

  if (imageUpload && imagePreview) {
    imageUpload.addEventListener("change", function () {
      const files = this.files;
      if (files && files.length > 0) {
        Array.from(files).forEach(file => {
          if (file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = function (e) {
              const img = document.createElement("img");
              img.src = e.target.result;
              img.alt = file.name;
              img.classList.add("preview-img");

              // Adicionar ao preview
              const previewContainer = document.createElement("div");
              previewContainer.classList.add("preview-container");
              previewContainer.appendChild(img);
              imagePreview.appendChild(previewContainer);

              
            };
            reader.readAsDataURL(file);
          } else {
            console.warn("Arquivo não é uma imagem:", file.name);
          }
        });
        // Não limpar o input para permitir múltiplos uploads
        // this.value = ''; // Remova isso se quiser manter os arquivos selecionados
      }
    });
  } else {
    console.warn("Elementos de upload de imagem não encontrados.");
  }
}

initializeEditor();
