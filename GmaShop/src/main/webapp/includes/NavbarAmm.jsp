<link rel="stylesheet" type="text/css" href="css/Navbar.css">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark custom-navbar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="d-flex">
            <a class="navbar-brand" href="indexAmm.jsp">GMAshop</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>

        <a class="navbar-logo" href="indexAmm.jsp">
            <img src="product-images/logo.jpg" alt="Logo" class="logo-img">
        </a>

        <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="indexAmm.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="orders.jsp">Ordini</a></li>
                <li class="nav-item"><a class="nav-link" href="aggiungiProdotto.jsp">Aggiungi Prodotto</a></li>
                <%
                    if (auth != null) {
                %>
                <li class="nav-item"><a class="nav-link" href="log-out">Logout</a></li>
                <%
                    } else {
                %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>
