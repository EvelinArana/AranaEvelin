const getResultados = async() => {
    const id = ( new URLSearchParams(window.location.search)).get('id')
    const data = await fetch(`http://localhost/onpe_sweb_php/participacion/${id}`)
    if (data.status != 200) return

    const aID = id.split('/') // ["Nacional", "Amazononas", "Bagua", "Bagua"]
    const mDPD = [["Departamento", "Provincia", "Distrito"], ["Continente", "País", "Ciuda"]]
    const bNacional = aID[0] == "Nacional"
    const length = aID.length

    let ambito = "Ámbito : " + aID[0]
    if (length > 1) ambito += "<br>" + mDPD[bNacional ? 0 : 1][0] + " : " + aID[1]
    if (length > 2) ambito += "<br>" + mDPD[bNacional ? 0 : 1][1] + " : " + aID[2]
    if (length > 3) ambito += "<br>" + mDPD[bNacional ? 0 : 1][2] + " : " + aID[3]
    document.getElementById('ambito').innerHTML = ambito

    if ( length == 4 ){
        
    }

    const votos = await data.json()
    let resultados = `
    <tr class="titulo_tabla">
                        <td>${ (mDPD[ bNacional ? 0 : 1 ][ length -1 ]).toUpperCase() }</td>
                        <td>TOTAL ASISTENTES</td>
                        <td>% TOTAL ASISTENTES</td>
                        <td>TOTAL AUSENTES</td>
                        <td>% TOTAL AUSENTES</td>
                        <td>ELECTORES HÁBILES</td>
                        </tr>`
    votos.data.forEach(voto=> {
        resultados += `
        <tr onclick="location.href='./participacion_total.html?id=${id}/${voto.DPD}" onmouseover="this.style.cursor = &quot;pointer&quot;; this.style.color = &quot;grey&quot;" onmouseout="this.style.color = &quot;black&quot;" style="cursor: pointer; color: black;">
                    <td>${voto.DPD}</td>
                    <td>${voto.TY}</td>
                    <td>${voto.PTV}</td>
                    <td>${voto.TA}</td>
                    <td>${voto.PTA}</td>
                    <td>${voto.EH}</td>
                    </tr>
                <tr>`
        
    });
    resultados += `
            <td>TOTALES</td>
                <td>17,953,367</td>
                <td>81.543%</td>
                <td>4,063,663</td>
                <td>18.457%</td>
                <td>22,017,030</td>
            </tr> 
        `

    document.getElementById('resultados').innerHTML = resultados
}



getResultados()


// Ambito: Ncional


/*


                        <tr onclick="location.href='./participacion_total.html?id=nacional,AMAZONAS'" onmouseover="this.style.cursor = &quot;pointer&quot;; this.style.color = &quot;grey&quot;" onmouseout="this.style.color = &quot;black&quot;" style="cursor: pointer; color: black;">
                        <td>AMAZONAS</td>
                        <td>182,570</td>
                        <td>67.575%</td>
                        <td>87,605</td>
                        <td>32.425%</td>
                        <td>270,175</td>
                        </tr>
                        <tr>
                        <td>TOTALES</td>
                        <td>17,953,367</td>
                        <td>81.543%</td>
                        <td>4,063,663</td>
                        <td>18.457%</td>
                        <td>22,017,030</td>
                        </tr> 
*/


