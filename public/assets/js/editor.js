/* console.log("Editor.js carregado com sucesso!");

function initializeEditor() {
    const editorContent = document.getElementById("content");
    const toolbarButtons = document.querySelectorAll(".toolbar-btn");
    const headingSelect = document.getElementById("heading-select");
    const imageUploadBtn = document.getElementById("image-upload-btn");
    const imageUpload = document.getElementById("image-upload");
    const imagePreview = document.getElementById("image-preview");

    // Estados dos botões
    const buttonStates = {
        bold: false,
        italic: false,
        underline: false,
        insertUnorderedList: false,
        insertOrderedList: false,
        paragraph: false
    };

    // Verifica se o texto selecionado tem um estilo ou título aplicado
    function getCurrentStyle(tagName) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return false;
        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;
        while (node && node !== editorContent) {
            if (node.nodeType === 1 && node.tagName.toLowerCase() === tagName) {
                return true;
            }
            node = node.parentNode;
        }
        return false;
    }

    // Verifica o alinhamento atual do bloco
    function getCurrentAlignment() {
        const selection = window.getSelection();
        if (!selection.rangeCount) return "left";
        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;
        while (node && node !== editorContent) {
            if (node.nodeType === 1 && node.style.textAlign) {
                return node.style.textAlign;
            }
            node = node.parentNode;
        }
        return "left"; // Padrão
    }

    // Atualiza o estado visual dos botões e do select
    function updateToolbarState() {
        toolbarButtons.forEach((btn) => {
            const command = btn.getAttribute("data-command");
            const align = btn.getAttribute("data-align");
            if (command) {
                let isActive = false;
                switch (command) {
                    case "bold": isActive = getCurrentStyle("b"); break;
                    case "italic": isActive = getCurrentStyle("i"); break;
                    case "underline": isActive = getCurrentStyle("u"); break;
                    case "insertUnorderedList": isActive = getCurrentStyle("ul"); break;
                    case "insertOrderedList": isActive = getCurrentStyle("ol"); break;
                    case "paragraph": isActive = getCurrentStyle("p"); break;
                }
                btn.classList.toggle("active", isActive);
                buttonStates[command] = isActive;
            } else if (align) {
                const currentAlign = getCurrentAlignment();
                btn.classList.toggle("active", currentAlign === align);
            }
        });

        const headings = ["h1", "h2", "h3", "h4", "h5", "h6"];
        let currentHeading = "";
        for (const heading of headings) {
            if (getCurrentStyle(heading)) {
                currentHeading = heading;
                break;
            }
        }
        headingSelect.value = currentHeading || "";
    }

    // Aplica ou remove estilo no texto selecionado
    function applyStyle(command) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const range = selection.getRangeAt(0);
        const isActive = buttonStates[command];

        if (range.collapsed) {
            buttonStates[command] = !isActive;
            updateToolbarState();
            return;
        }

        const tagMap = {
            bold: "b",
            italic: "i",
            underline: "u",
            insertUnorderedList: "ul",
            insertOrderedList: "ol",
            paragraph: "p"
        };
        const tagName = tagMap[command];

        if (isActive) {
            const wrapper = range.commonAncestorContainer.parentElement;
            if (wrapper.tagName.toLowerCase() === tagName) {
                const parent = wrapper.parentNode;
                while (wrapper.firstChild) {
                    parent.insertBefore(wrapper.firstChild, wrapper);
                }
                parent.removeChild(wrapper);
            }
        } else {
            const element = document.createElement(tagName);
            range.surroundContents(element);
        }

        editorContent.focus();
        updateToolbarState();
    }

    // Aplica ou remove título
    function applyHeading(headingTag) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;

        while (node && node !== editorContent && !["H1", "H2", "H3", "H4", "H5", "H6", "P"].includes(node.tagName)) {
            node = node.parentNode;
        }

        if (node && node !== editorContent) {
            const parent = node.parentNode;
            const newNode = headingTag ? document.createElement(headingTag) : document.createTextNode(node.textContent);
            if (headingTag) {
                newNode.textContent = node.textContent;
            }
            parent.replaceChild(newNode, node);
        } else if (headingTag) {
            const heading = document.createElement(headingTag);
            range.surroundContents(heading);
        }

        editorContent.focus();
        updateToolbarState();
    }

    // Aplica alinhamento ao bloco atual
    function applyAlignment(align) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;

        while (node && node !== editorContent && !["P", "H1", "H2", "H3", "H4", "H5", "H6", "DIV"].includes(node.tagName)) {
            node = node.parentNode;
        }

        if (node && node !== editorContent) {
            node.style.textAlign = align;
        } else {
            const p = document.createElement("p");
            p.style.textAlign = align;
            range.surroundContents(p);
        }

        editorContent.focus();
        updateToolbarState();
    }

    // Eventos dos botões da toolbar
    toolbarButtons.forEach((btn) => {
        const command = btn.getAttribute("data-command");
        const align = btn.getAttribute("data-align");
        if (command) {
            btn.addEventListener("click", function (e) {
                e.preventDefault();
                applyStyle(command);
            });
        } else if (align) {
            btn.addEventListener("click", function (e) {
                e.preventDefault();
                applyAlignment(align);
            });
        }
    });

    // Evento do select de títulos
    if (headingSelect) {
        headingSelect.addEventListener("change", function () {
            const headingTag = this.value;
            applyHeading(headingTag);
            this.blur();
        });
    }

    // Botão de Link
    document.getElementById("link-btn").addEventListener("click", function (e) {
        e.preventDefault();
        const url = prompt("Digite a URL do link:");
        if (url) {
            const selection = window.getSelection();
            if (selection.rangeCount) {
                const range = selection.getRangeAt(0);
                const link = document.createElement("a");
                link.href = url;
                link.textContent = range.toString() || "Link";
                range.deleteContents();
                range.insertNode(link);
            }
            editorContent.focus();
            updateToolbarState();
        }
    });

    // Botão de Upload de Imagem
    if (imageUploadBtn && imageUpload) {
        imageUploadBtn.addEventListener("click", function () {
            imageUpload.click();
        });

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

                            const previewContainer = document.createElement("div");
                            previewContainer.classList.add("preview-container");
                            previewContainer.appendChild(img);
                            imagePreview.appendChild(previewContainer);

                            const editorImg = document.createElement("img");
                            editorImg.src = e.target.result;
                            editorImg.alt = file.name;
                            editorContent.appendChild(editorImg);
                        };
                        reader.readAsDataURL(file);
                    } else {
                        console.warn("Arquivo não é uma imagem:", file.name);
                    }
                });
            }
        });
    } else {
        console.warn("Elementos de upload de imagem não encontrados.");
    }

    // Monitorar mudanças na seleção
    document.addEventListener("selectionchange", () => {
        if (document.activeElement === editorContent) {
            updateToolbarState();
        }
    });

    // Atualizar estado ao digitar
    editorContent.addEventListener("keyup", updateToolbarState);
}

initializeEditor(); */

console.log("Editor.js carregado com sucesso!");

function initializeEditor() {
    const editorContent = document.getElementById("content");
    const toolbarButtons = document.querySelectorAll(".toolbar-btn");
    const headingSelect = document.getElementById("heading-select");
    const imageUploadBtn = document.getElementById("image-upload-btn");
    const imageUpload = document.getElementById("image-upload");
    const imagePreview = document.getElementById("image-preview");

    // Estados persistentes dos botões
    const buttonStates = {
        bold: false,
        italic: false,
        underline: false,
        insertUnorderedList: false,
        insertOrderedList: false,
        paragraph: false,
        alignLeft: false,
        alignCenter: false,
        alignRight: false,
        alignJustify: false
    };

    // Verifica se o texto selecionado tem um estilo ou título
    function getCurrentStyle(tagName) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return false;
        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;
        while (node && node !== editorContent) {
            if (node.nodeType === 1 && node.tagName.toLowerCase() === tagName) {
                return true;
            }
            node = node.parentNode;
        }
        return false;
    }

    // Verifica o alinhamento atual do bloco
    function getCurrentAlignment() {
        const selection = window.getSelection();
        if (!selection.rangeCount) return "left";
        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;
        while (node && node !== editorContent) {
            if (node.nodeType === 1 && node.style.textAlign) {
                return node.style.textAlign;
            }
            node = node.parentNode;
        }
        return "left";
    }

    // Atualiza o estado visual dos botões
    function updateToolbarState() {
        const selection = window.getSelection();
        const hasSelection = selection.rangeCount && !selection.getRangeAt(0).collapsed;

        toolbarButtons.forEach((btn) => {
            const command = btn.getAttribute("data-command");
            const align = btn.getAttribute("data-align");

            if (command) {
                if (hasSelection) {
                    const isStyled = getCurrentStyle({ bold: "b", italic: "i", underline: "u", insertUnorderedList: "ul", insertOrderedList: "ol", paragraph: "p" }[command]);
                    btn.classList.toggle("active", isStyled);
                } else {
                    btn.classList.toggle("active", buttonStates[command]);
                }
            } else if (align) {
                const alignKey = `align${align.charAt(0).toUpperCase() + align.slice(1)}`;
                if (hasSelection) {
                    const currentAlign = getCurrentAlignment();
                    btn.classList.toggle("active", currentAlign === align);
                } else {
                    btn.classList.toggle("active", buttonStates[alignKey]);
                }
            }
        });

        const headings = ["h1", "h2", "h3", "h4", "h5", "h6"];
        let currentHeading = "";
        for (const heading of headings) {
            if (getCurrentStyle(heading)) {
                currentHeading = heading;
                break;
            }
        }
        headingSelect.value = currentHeading || "";
    }

    // Aplica ou remove estilo no texto selecionado
    function toggleStyle(command) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const range = selection.getRangeAt(0);
        const tagMap = { bold: "b", italic: "i", underline: "u", insertUnorderedList: "ul", insertOrderedList: "ol", paragraph: "p" };
        const tagName = tagMap[command];

        if (range.collapsed) {
            buttonStates[command] = !buttonStates[command];
        } else {
            const isStyled = getCurrentStyle(tagName);
            if (isStyled) {
                let node = range.commonAncestorContainer;
                while (node && node !== editorContent) {
                    if (node.nodeType === 1 && node.tagName.toLowerCase() === tagName) {
                        const parent = node.parentNode;
                        while (node.firstChild) {
                            parent.insertBefore(node.firstChild, node);
                        }
                        parent.removeChild(node);
                        break;
                    }
                    node = node.parentNode;
                }
            } else {
                const element = document.createElement(tagName);
                range.surroundContents(element);
            }
        }

        editorContent.focus();
        updateToolbarState();
    }

    // Aplica ou remove título
    function applyHeading(headingTag) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;

        while (node && node !== editorContent && !["H1", "H2", "H3", "H4", "H5", "H6", "P"].includes(node.tagName)) {
            node = node.parentNode;
        }

        if (node && node !== editorContent) {
            const parent = node.parentNode;
            const newNode = headingTag ? document.createElement(headingTag) : document.createTextNode(node.textContent);
            if (headingTag) {
                newNode.textContent = node.textContent;
            }
            parent.replaceChild(newNode, node);
        } else if (headingTag) {
            const heading = document.createElement(headingTag);
            range.surroundContents(heading);
        }

        editorContent.focus();
        updateToolbarState();
    }

    // Aplica alinhamento ao bloco atual
    function toggleAlignment(align) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const alignKey = `align${align.charAt(0).toUpperCase() + align.slice(1)}`;
        buttonStates[alignKey] = !buttonStates[alignKey];

        const alignKeys = ["alignLeft", "alignCenter", "alignRight", "alignJustify"];
        alignKeys.forEach(key => {
            if (key !== alignKey) buttonStates[key] = false;
        });

        const range = selection.getRangeAt(0);
        let node = range.commonAncestorContainer;

        while (node && node !== editorContent && !["P", "H1", "H2", "H3", "H4", "H5", "H6", "DIV"].includes(node.tagName)) {
            node = node.parentNode;
        }

        if (node && node !== editorContent) {
            node.style.textAlign = buttonStates[alignKey] ? align : "";
        } else if (buttonStates[alignKey]) {
            const p = document.createElement("p");
            p.style.textAlign = align;
            range.surroundContents(p);
        }

        editorContent.focus();
        updateToolbarState();
    }

    // Aplica estilos ativos ao texto novo
    function wrapNewTextWithStyles(node) {
        let currentNode = node;
        if (buttonStates.underline) {
            const u = document.createElement("u");
            u.appendChild(currentNode);
            currentNode = u;
        }
        if (buttonStates.italic) {
            const i = document.createElement("i");
            i.appendChild(currentNode);
            currentNode = i;
        }
        if (buttonStates.bold) {
            const b = document.createElement("b");
            b.appendChild(currentNode);
            currentNode = b;
        }
        return currentNode;
    }

    // Eventos dos botões da toolbar
    toolbarButtons.forEach((btn) => {
        const command = btn.getAttribute("data-command");
        const align = btn.getAttribute("data-align");
        if (command) {
            btn.addEventListener("click", function (e) {
                e.preventDefault();
                toggleStyle(command);
            });
        } else if (align) {
            btn.addEventListener("click", function (e) {
                e.preventDefault();
                toggleAlignment(align);
            });
        }
    });

    // Evento do select de títulos
    if (headingSelect) {
        headingSelect.addEventListener("change", function () {
            const headingTag = this.value;
            applyHeading(headingTag);
            this.blur();
        });
    }

    // Botão de Link
    document.getElementById("link-btn").addEventListener("click", function (e) {
        e.preventDefault();
        const url = prompt("Digite a URL do link:");
        if (url) {
            const selection = window.getSelection();
            if (selection.rangeCount) {
                const range = selection.getRangeAt(0);
                const link = document.createElement("a");
                link.href = url;
                link.textContent = range.toString() || "Link";
                range.deleteContents();
                range.insertNode(link);
            }
            editorContent.focus();
            updateToolbarState();
        }
    });

    // Botão de Upload de Imagem com Redimensionamento
    if (imageUploadBtn && imageUpload) {
        imageUploadBtn.addEventListener("click", function () {
            imageUpload.click();
        });

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
                            img.style.maxWidth = "200px"; // Tamanho inicial

                            const previewContainer = document.createElement("div");
                            previewContainer.classList.add("preview-container");
                            previewContainer.appendChild(img);
                            imagePreview.appendChild(previewContainer);

                            const editorImg = document.createElement("img");
                            editorImg.src = e.target.result;
                            editorImg.alt = file.name;
                            editorImg.classList.add("resizable-img");
                            editorImg.style.maxWidth = "200px";
                            editorImg.contentEditable = false; // Evita edição direta
                            editorImg.draggable = true;

                            // Adiciona redimensionamento
                            editorImg.addEventListener("mousedown", function (event) {
                                if (event.ctrlKey) { // Ctrl + clique para redimensionar
                                    event.preventDefault();
                                    const startX = event.clientX;
                                    const startWidth = editorImg.offsetWidth;

                                    function onMouseMove(e) {
                                        const newWidth = startWidth + (e.clientX - startX);
                                        editorImg.style.maxWidth = `${newWidth}px`;
                                    }

                                    function onMouseUp() {
                                        document.removeEventListener("mousemove", onMouseMove);
                                        document.removeEventListener("mouseup", onMouseUp);
                                    }

                                    document.addEventListener("mousemove", onMouseMove);
                                    document.addEventListener("mouseup", onMouseUp);
                                }
                            });

                            editorContent.appendChild(editorImg);
                        };
                        reader.readAsDataURL(file);
                    } else {
                        console.warn("Arquivo não é uma imagem:", file.name);
                    }
                });
            }
        });
    } else {
        console.warn("Elementos de upload de imagem não encontrados.");
    }

    // Aplica estilos ao digitar
    editorContent.addEventListener("input", function (e) {
        const selection = window.getSelection();
        if (!selection.rangeCount) return;

        const range = selection.getRangeAt(0);
        if (e.inputType === "insertText" || e.inputType === "insertLineBreak") {
            if (range.collapsed && (buttonStates.bold || buttonStates.italic || buttonStates.underline)) {
                const lastNode = range.startContainer;
                if (lastNode.nodeType === 3 && lastNode.parentNode !== editorContent) {
                    const styledNode = wrapNewTextWithStyles(lastNode);
                    if (styledNode !== lastNode) {
                        const parent = lastNode.parentNode;
                        parent.insertBefore(styledNode, lastNode.nextSibling);
                        parent.removeChild(lastNode);
                        range.setStart(styledNode, styledNode.textContent.length);
                        range.setEnd(styledNode, styledNode.textContent.length);
                    }
                }
            }
        }
        updateToolbarState();
    });

    // Monitorar mudanças na seleção
    document.addEventListener("selectionchange", () => {
        if (document.activeElement === editorContent) {
            updateToolbarState();
        }
    });
}

initializeEditor();