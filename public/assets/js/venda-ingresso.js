payButton.addEventListener('click', (e) => {
    e.preventDefault();

    document.querySelector('#spinner').style.display = 'block';

    const data = {
        cliente_nome: document.querySelector('[name="cliente_nome"]').value,
        cliente_email: document.querySelector('[name="cliente_email"]').value,
        cliente_cpf: document.querySelector('[name="cliente_cpf"]').value,
        quantity: hiddenQuantity.value,
        event_id: document.querySelector('[name="event_id"]').value,
        event_title: document.querySelector('[name="event_title"]').value,
        
    };

    fetch('/criar-pagamento', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
        .then(response => response.text())
  .then(text => {
     try {
         const data = JSON.parse(text);
         document.querySelector('#spinner').style.display = 'none';
         
         if (data.pix.qrcode) { 
                // Mostra QRCode na modal
                document.querySelector('.modal-body').innerHTML += `
                <div class="pix-payment">
                    <h4>Pagamento via PIX</h4>
                    <img src="${data.pix.qrcode}" alt="QR Code PIX" />
                    <p><strong>Copia e Cola:</strong></p>
                    <textarea readonly style="width:100%;height:80px;">${data.pix.copiaECola}</textarea>
                </div>
            `;
            //adicionado
            const idCompra = data.compraId; // você retorna isso no backend
        const interval = setInterval(() => {
            fetch(`/status-pagamento/${idCompra}`)
                .then(res => res.json())
                .then(statusData => {
                    if (statusData.status === 'pago') {
                        document.querySelector('#statusPagamento').innerHTML = `
                            ✅ Pagamento confirmado! 
                            <a href="${statusData.ingresso}" target="_blank">Baixar ingresso</a>
                        `;
                        clearInterval(interval);
                    }
                });
        }, 5000);
         } 
     } catch (e) {
         console.error("Resposta não-JSON:", text);
         alert("Erro no servidor, verifique os logs.");
     }
  })
  .catch(error => {
      console.error("Erro fetch:", error);
  });


});
