

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ServletInserimentoSosta
 */
@WebServlet("/ServletInserimentoSosta")
public class ServletInserimentoSosta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletInserimentoSosta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			response.setContentType("text/html");

			PrintWriter out= response.getWriter(); 
			out.println("<HTML>");
			out.println("<BODY>");
			out.println("<form name=\"InserimentoSosta\" method=\"post\" action=\"ServletInserimentoSosta\">");
			out.println("<fieldset>");
			out.println("<legend>Inserimento sosta:</legend>");
			out.println("Nome ppc:<br>");
			out.println("<input type=\"text\" name=\"ppc\"<br>");
			out.println("<br>CF utente:<br>");
			out.println("<input type=\"text\" name=\"cfutente\"<br>");
			out.println("<br>Data inzio:<br>");
			out.println("<input type=\"text\" name=\"datai\" value=\"dd-Mon-yyyy\"<br>");
			out.println("<br>Data fine:<br>");
			out.println("<input type=\"text\" name=\"dataf\" value=\"dd-Mon-yyyy\"<br>");
			out.println("<br>Targa auto:<br>");
			out.println("<input type=\"text\" name=\"targa\"><br><br>");
			out.println("<input type=\"submit\" value=\"Submit\">");
			out.println("</fieldset>");
			out.println("</form>");
			out.println("</BODY>");
			out.println("</HTML>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String ppc = request.getParameter("ppc");
		String cfutente = request.getParameter("cfutente");
		String datai = request.getParameter("datai");
		String dataf = request.getParameter("dataf");
		String targa = request.getParameter("targa");
		System.out.println(ppc + "\n" + cfutente + "\n" + datai + "\n" + dataf + "\n" + targa);
		
		String user = "parcheggio";
		String pass = "parcheggio";
		String sid = "orcl";
		String host = "localhost";
		int port = 1521;
		
		String url = "jdbc:oracle:thin:@" + host + ":" + port + ":" + sid;
		System.out.println(url);
		
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection conn = DriverManager.getConnection(url, user, pass);
				
				PreparedStatement pstmt=conn.prepareStatement(""+
				"INSERT INTO sosta select sosta_ty(dbms_random.string('X',5),?,?,0,?,ref(p),ref(u)) from ppc p,utente u where p.nome = ? AND u.cf = ?");
				pstmt.setString(1, datai);
				pstmt.setString(2, dataf);
				pstmt.setString(3, targa);
				pstmt.setString(4, ppc);
				pstmt.setString(5, cfutente);
								
				int i = pstmt.executeUpdate();
				response.setContentType("text/html");
				PrintWriter out= response.getWriter(); 
				if(i==1)		
					out.println("SOSTA INSERITA CORRETTAMENTE");
				else
					out.println("SOSTA NON INSERITA");
				
				//SZMFUQYNIA
				//CBY5NMPOOICDLH8F
							
			
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
	}

}
