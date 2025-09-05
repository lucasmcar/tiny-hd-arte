// Funções globais para serem acessadas pelo onclick
function openBuyModal() {
    console.log('Abrindo modal...');
    const modal = document.getElementById('buyModal');
    if (modal) {
        modal.style.display = 'block';
        updateTotal();
    } else {
        console.error('Modal não encontrada!');
    }
}

function closeBuyModal() {
    console.log('Fechando modal...');
    const modal = document.getElementById('buyModal');
    const pixPayment = document.querySelector(".pix-payment");
    if (modal) {
        modal.style.display = 'none';
        pixPayment.style.display= 'none';

    }
}

function decreaseQuantity() {
    console.log('Diminuindo quantidade...');
    const quantityInput = document.getElementById('quantity');
    if (quantityInput && quantityInput.value > 1) {
        quantityInput.value = parseInt(quantityInput.value) - 1;
        updateTotal();
    }
}

function increaseQuantity() {
    console.log('Aumentando quantidade...');
    const quantityInput = document.getElementById('quantity');
    if (quantityInput && quantityInput.value < 100) {
        quantityInput.value = parseInt(quantityInput.value) + 1;
        updateTotal();
    }
}

function updateTotal() {
    console.log('Atualizando total...');
    const quantityInput = document.getElementById('quantity');
    const totalPrice = document.getElementById('totalPrice');
    const unitPrice = document.getElementById('unitPrice');
    const hiddenQuantity = document.getElementById('hiddenQuantity');
    const hiddenTotal = document.getElementById('hiddenTotal');
    const payButton = document.getElementById('payButton');

    if (quantityInput && totalPrice && unitPrice && hiddenQuantity && hiddenTotal && payButton) {
        const pricePerTicket = parseFloat(unitPrice.textContent);
        const quantity = parseInt(quantityInput.value);
        const total = (quantity * pricePerTicket).toFixed(2);
        totalPrice.textContent = total;
        hiddenQuantity.value = quantity;
        hiddenTotal.value = total;
        payButton.disabled = quantity === 0;
    } else {
        console.error('Elementos não encontrados para updateTotal!');
    }
}

// Adicionar event listeners após o DOM carregar
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM carregado, configurando eventos...');
    const buyButton = document.querySelector('.btn-buy-large');
    const closeButton = document.querySelector('.modal-close');
    const modal = document.getElementById('buyModal');
    

    if (buyButton) {
        buyButton.addEventListener('click', openBuyModal);
    } else {
        console.error('Botão de compra não encontrado!');
    }

    if (closeButton) {
        closeButton.addEventListener('click', closeBuyModal);
    }

    if (modal) {
        window.addEventListener('click', (e) => {
            if (e.target === modal) closeBuyModal();
        });
    }

    // Inicializar valores
    updateTotal();
});