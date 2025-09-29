const getCine = async () => {
    const id = new URLSearchParams(window.location.search).get('id');
    const data = await fetch(`http://localhost/cinestar_sweb_php/cines/${id}`);

    if (data.status === 200) {
        const cine = await data.json();

        let html = `
            <h2>${cine.RazonSocial}</h2>
            <div class="cine-info">
                <div class="cine-info datos">
                    <p>${cine.Direccion}</p>
                    <p>Teléfono: ${cine.Telefonos}</p>
                    <br/>
                    <div class="tabla">
                        ${cine.Precios.map((precio, i) => `
                            <div class="fila ${i % 2 === 1 ? 'impar' : ''}">
                                <div class="celda-titulo">${precio.titulo}</div>
                                <div class="celda">S/. ${precio.monto}</div>
                            </div>
                        `).join('')}
                    </div>
                    <div class="aviso">
                        <p>${cine.Aviso}</p>
                    </div>
                </div>
                <img src="img/cine/${cine.id}.2.jpg"/>
                <br/><br/><h4>Los horarios de cada función están sujetos a cambios sin previo aviso.</h4><br/>
                <div class="cine-info peliculas">
                    <div class="tabla">
                        <div class="fila">
                            <div class="celda-cabecera">Películas</div>
                            <div class="celda-cabecera">Horarios</div>
                        </div>
                        ${cine.Peliculas.map((peli, i) => `
                            <div class="fila ${i % 2 === 1 ? 'impar' : ''}">
                                <div class="celda-titulo">${peli.titulo}</div>
                                <div class="celda">${peli.horarios.join(' / ')}</div>
                            </div>
                        `).join('')}
                    </div>
                </div>
            </div>
            <div>
                <img style="float:left;" src="img/cine/${cine.id}.3.jpg" alt="Imagen del cine"/>
                <span class="tx_gris">
                    ${cine.Extras}
                </span>		
            </div>
        `;

        document.getElementById('contenido-interno').innerHTML = html;
    }
};

getCine();
