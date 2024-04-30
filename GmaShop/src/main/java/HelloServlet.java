import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HelloServlet")
public class HelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Ciao</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div style=\"position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);\">");
        out.println("<h1>Ciao</h1>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}

