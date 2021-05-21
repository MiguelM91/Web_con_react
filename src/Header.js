import React from 'react'
import logo from "./images/Logo-sobrio2.JPG"
import "./header.css"

function Header() {
    return (
        <div className="header">
            <div className="header__menu">

                <a href="" className="header__menu__logo"><img src={logo} alt="logo"/></a>

                <div className="header__nav">
                    <nav>
                        <a href="/contacto">Contacto</a>
                        <a href="https://github.com/MiguelM91">GitHub</a>
                        <a href="https://www.linkedin.com/in/miguel-arturo-mu%C3%B1oz-segura-342458184/">LinkedIn</a>
                    </nav>

                </div>

            </div>
        </div>
    )
}

export default Header
