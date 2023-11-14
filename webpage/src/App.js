import React, { useState, useEffect } from 'react';
import logo from './img/Olisipo_LogoWhite.png';
import app1 from './img/app1.png';
import app2 from './img/app2.png';
import qrcode from './img/qrcodeex.png';
import logotipo from './img/Olisipo_LogoBlack_branco_c.png';
import './App.css';
import { Navbar, Button } from 'react-bootstrap';

function App() {
  const [showDesenvolvimento, setShowDesenvolvimento] = useState(false);

  useEffect(() => {
    // Add event listener to track scroll position
    const handleScroll = () => {
      const scrollPosition = window.scrollY;
      const desenvolvimentoSection = document.getElementById('secaoDesenvolvimento');

      // Adjust the threshold as needed
      const threshold = desenvolvimentoSection.offsetTop - window.innerHeight / 2;

      // Update state based on scroll position
      setShowDesenvolvimento(scrollPosition > threshold);
    };

    window.addEventListener('scroll', handleScroll);

    // Clean up the event listener on component unmount
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);  return (
    <div className="App">
      <Navbar className='navbar fade-in'>
        <img alt="Logo" src={logo} className="logoinical"/>
        <Button className="botaodescarregar">
          Descarrega Aqui
        </Button>
      </Navbar>

      <header className="App-header slide-up">
        <h1 className="h1_heroi">PortalOlisipo: </h1>
        <p className="p_heroi">Tudo com<br></br>mais Facilidades </p>
        <div className="image-container">
          <img alt="app1" src={app1} className="fotoapp1"/>
          <img alt="app2" src={app2} className="fotoapp2"/>
        </div>
      </header>

   {/* Desenvolvimento */}
   <section id="secaoDesenvolvimento" className={`secaoDesenvolvimento fade-in ${showDesenvolvimento ? 'visible' : ''}`}>
        <h1>PortalOlisipo</h1>
        <p>O PortalOlisipo é a solução completa para tornar a gestão de recursos humanos eficiente e eficaz. Simplifique os processos, promova uma comunicação transparente e aumente a satisfação dos colaboradores. <br></br><br></br>
        Sucesso com facilidades é o que o PortalOlisipo oferece!<br></br><br></br>
        Experimente o PortalOlisipo já hoje.
        </p>
        <Button variant="light" className="botaodescarregar2">
          Descarrega Aqui
        </Button>
      </section>

      {/* QRCODE */}
      <section className="secaoQRCODE slide-up">
        <h1>DESCARREGUE AQUI O PORTALOLISIPO </h1>          
        <img alt="fotoqrcode" src={qrcode} className="qrcode"/>
      </section>

      {/* intervalo */}
      <section className="intervalo fade-in">
      </section>

      {/* NOTÍCIAS */}
      <section className="secaoNOTICIAS slide-up">
        <h1>NOTÍCIAS</h1>
      </section>

      {/* intervalo */}
      <section className="intervalo2 fade-in">
      </section>

      {/* FOOTER */}
      <section className="FOOTER slide-up">
        <h1></h1>
        <img alt="logotipo" src={logotipo} className="logotipoFOOTER"/>
        <p>Consulte a nossa <i><u>Politica de cookies</u></i> e a nossa <i><u>Politica de privacidade</u></i></p>
        <p>© Copyright 2023 - Olisipo. Todos os direitos reservados</p>
      </section>
    </div>
  );
}

export default App;
