
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Ref;
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
 * Servlet implementation class ProvaServlet
 */
@WebServlet("/ServletStampaInfoPremium")
public class ServletStampaInfoPremium extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletStampaInfoPremium() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String user = "parcheggio";
		String pass = "parcheggio";
		String sid = "orcl";
		String host = "localhost";
		int port = 1521;
		
		String url = "jdbc:oracle:thin:@" + host + ":" + port + ":" + sid;
		System.out.println(url);
		try 
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(url, user, pass);
			PreparedStatement pstmt=conn.prepareStatement("SELECT * FROM parcheggio.utentepremium");
			ResultSet result= pstmt.executeQuery();
			response.setContentType("text/html");
		
			ResultSet result1 = null;
			PreparedStatement pstmt1 = conn.prepareStatement("SELECT deref(ppc).nome AS park, dataInizio AS dataI, dataFine AS dataF FROM parcheggio.sosta WHERE deref(utente).cf=?");
			ResultSet result2 = null;
			PreparedStatement pstmt2 = conn.prepareStatement("SELECT COUNT(*) AS c FROM parcheggio.sosta WHERE deref(utente).cf=?");
			ResultSet result3 = null;
			PreparedStatement pstmt3 = conn.prepareStatement("SELECT COUNT(*) AS c FROM parcheggio.pass WHERE deref(utente).cf=?");
			ResultSet result4 = null;
			PreparedStatement pstmt4 = conn.prepareStatement("SELECT scadenza,nomezona FROM parcheggio.pass WHERE deref(utente).cf=?");
			
			
			PrintWriter out= response.getWriter(); 
			out.println("<HTML>");
			out.println("<BODY>");
			out.println("<H1> Utenti Premium: </H1>");
			
			Date d = null;
			Date d1 = null;
			int count = 0;
			SimpleDateFormat date_format = new SimpleDateFormat("dd-MM-yy HH:mm");
			while (result.next()) 
			{
				pstmt2.setString(1, result.getString("CF"));
				result2 = pstmt2.executeQuery();
				result2.next();
				count = Integer.parseInt(result2.getString("C"));
				out.println("<P>Nome utente: ");
				out.print(result.getString("NOME"));	
				out.println("</P>");
				out.println("<p style=\"text-indent: 5em;\">Soste effettuate: " + count + "</p>" );
				if(count>0){
				pstmt1.setString(1, result.getString("CF"));
				result1 = pstmt1.executeQuery();
			    for(int j=1; result1.next(); j++){
			    	d = date_format.parse(result1.getString("dataI"));
			    	d1 = date_format.parse(result1.getString("dataF"));
			    	out.println("<p style=\"text-indent: 5em;\">"+ j  +". Presso "+ result1.getString("park") + 
			    			" dal " + date_format.format(d) + " fino al " + date_format.format(d1) +"</p>");
			    }
			    pstmt3.setString(1, result.getString("CF"));
				result3 = pstmt3.executeQuery();
				result3.next();
				count = Integer.parseInt(result3.getString("C"));
				out.println("<p style=\"text-indent: 5em;\">Pass acquistati: " + count + "</p>" );
				if(count>0){
					pstmt4.setString(1, result.getString("CF"));
					result4 = pstmt4.executeQuery();
				    for(int j=1; result4.next(); j++){
				    	d = date_format.parse(result4.getString("scadenza"));
				    	out.println("<p style=\"text-indent: 5em;\">"+ j  +". In zona "+ result4.getString("nomezona") + 
				    			", valido fino al " + date_format.format(d) +"</p>");
				    }
				}
				}
			}
			out.println("</BODY>");
			out.println("</HTML>");
			result.close();
			pstmt.close();
			conn.close();
	    }
	    catch(ClassNotFoundException e){
               throw new ServletException(e);
	     }
	    catch(SQLException e){
               throw new ServletException(e);
	     } catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
