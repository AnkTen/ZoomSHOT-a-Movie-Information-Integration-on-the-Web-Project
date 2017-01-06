
/*
Name: Ankeet Tendulkar
USC CSCI 548 Fall 2016
Servlet for representing the integrated information
*/

package Project;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchResultPage
 */
@WebServlet("/SearchResultPage")
public class SearchResultPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  private Connection connection = null;
	  private Statement statement = null;
	  private PreparedStatement preparedStatement = null;
	  private ResultSet resultSet = null;
	  private static String forward;

	  final private String host = "127.0.0.1";
	  final private String user = "Username";
	  final private String passwd = "Password";

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchResultPage() {
        super();
        // TODO Auto-generated constructor stub
        System.out.println("I am in constructor");
        // This will load the MySQL driver, each DB has its own driver
        try {
        	System.out.println("Driver Accepted");
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("Driver Accepted");
	        // Setup the connection with the DB
	        connection = DriverManager.getConnection("jdbc:mariadb://localhost:3360", "Username", "Password");
	        System.out.println("Connection Established");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("I am in post");
		try
		  {
	        // Statements allow to issue SQL queries to the database
	        statement = connection.createStatement();
	        System.out.println("Statement Created");
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String MovieName = request.getParameter("MovieName");
			request.setAttribute("MovieName_String", MovieName);
			System.out.println(MovieName);
		 	
			if(MovieName.equals(""))
			{
				response.sendRedirect("Search.jsp");
			}
		    else
		    {
			   	PreparedStatement statement = connection.prepareStatement("select * from iiwproject.finalresulttable where iiwproject.finalresulttable.Title="+ "\"" + MovieName + "\"");    
		        ResultSet rst1 = statement.executeQuery();
		        System.out.println("Result Set 1 Created");
		        
		        int Year = 0;
		        
		        ArrayList Inner_ArrayList_Object = new ArrayList();
		        while (rst1.next()) {
			    	
					Integer i1=new Integer(rst1.getInt(1));
					Inner_ArrayList_Object.add(i1);
					Year = i1;
					
					String s2  = new String(rst1.getString(2));
					Inner_ArrayList_Object.add(s2);
					String s3  = new String(rst1.getString(3));
					Inner_ArrayList_Object.add(s3);
					String s4  = new String(rst1.getString(4));
					Inner_ArrayList_Object.add(s4);
					String s5  = new String(rst1.getString(5));
					Inner_ArrayList_Object.add(s5);
					String s6  = new String(rst1.getString(6));
					Inner_ArrayList_Object.add(s6);
					String s7  = new String(rst1.getString(7));
					Inner_ArrayList_Object.add(s7);
					String s8  = new String(rst1.getString(8));
					Inner_ArrayList_Object.add(s8);
					String s9  = new String(rst1.getString(9));
					Inner_ArrayList_Object.add(s9);
					String s10  = new String(rst1.getString(10));
					Inner_ArrayList_Object.add(s10);					
					String s11  = new String(rst1.getString(11));
					Inner_ArrayList_Object.add(s11);			
		
					Integer ProfLevel =new Integer(rst1.getInt(12));
					Inner_ArrayList_Object.add(ProfLevel);
					Integer SNLevel =new Integer(rst1.getInt(13));
					Inner_ArrayList_Object.add(SNLevel);
					Integer VGLevel =new Integer(rst1.getInt(14));
					Inner_ArrayList_Object.add(VGLevel);
					
					String ProfCom  = new String(rst1.getString(15));
					Inner_ArrayList_Object.add(ProfCom);
					String SNCom  = new String(rst1.getString(16));
					Inner_ArrayList_Object.add(SNCom);					
					String VGCom  = new String(rst1.getString(17));
					Inner_ArrayList_Object.add(VGCom);			
		
					
					Integer BechResult =new Integer(rst1.getInt(18));
					Inner_ArrayList_Object.add(BechResult);
					Integer CastM =new Integer(rst1.getInt(19));
					Inner_ArrayList_Object.add(CastM);
					Integer CastF =new Integer(rst1.getInt(20));
					Inner_ArrayList_Object.add(CastF);
					Integer DirectorM =new Integer(rst1.getInt(21));
					Inner_ArrayList_Object.add(DirectorM);
					Integer DirectorF =new Integer(rst1.getInt(22));
					Inner_ArrayList_Object.add(DirectorF);
					Integer WriterM =new Integer(rst1.getInt(23));
					Inner_ArrayList_Object.add(WriterM);
					Integer WriterF =new Integer(rst1.getInt(24));
					Inner_ArrayList_Object.add(WriterF);
					Integer SoundM =new Integer(rst1.getInt(25));
					Inner_ArrayList_Object.add(SoundM);
					Integer SoundF =new Integer(rst1.getInt(26));
					Inner_ArrayList_Object.add(SoundF);
					Integer EditorM =new Integer(rst1.getInt(27));
					Inner_ArrayList_Object.add(EditorM);
					Integer EditorF =new Integer(rst1.getInt(28));
					Inner_ArrayList_Object.add(EditorF);
					Integer CameraM =new Integer(rst1.getInt(29));
					Inner_ArrayList_Object.add(CameraM);
					Integer CameraF =new Integer(rst1.getInt(30));
					Inner_ArrayList_Object.add(CameraF);
					Integer ProducerM =new Integer(rst1.getInt(31));
					Inner_ArrayList_Object.add(ProducerM);
					
					String ProducerF  = new String(rst1.getString(32));
					Inner_ArrayList_Object.add(ProducerF);

		  	    	System.out.println("Collected Data");
		  	    	break;
		  	    }
		        
		        PreparedStatement statement2 = connection.prepareStatement("Select Count(*) FROM iiwproject.finalresulttable WHERE iiwproject.finalresulttable.year = \"" + Year + "\"" + " Group By iiwproject.finalresulttable.Bechdel_Results ");    
		        ResultSet rst2 = statement2.executeQuery();
		        System.out.println("Result Set 2 Created");
		        
		        String counts[] = new String[4];
		        int i = 0;
		        while(rst2.next()){
		        	Integer i1=new Integer(rst2.getInt(1));
					Inner_ArrayList_Object.add(i1);	
					counts[i] = i1 + "";
					i++;
		        }
		        String fileHeader = "Number,Count";
		        FileWriter filewriter = new FileWriter("C:\\XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\\WebContent\\" + Year + ".csv");
		        filewriter.append(fileHeader);
		        filewriter.append("\n");
		        filewriter.append("0,");
		        filewriter.append(counts[0]);
		        filewriter.append("\n");
		        filewriter.append("1,");
		        filewriter.append(counts[1]);
		        filewriter.append("\n");
		        filewriter.append("2,");
		        filewriter.append(counts[2]);
		        filewriter.append("\n");
		        filewriter.append("3,");
		        filewriter.append(counts[3]);
		        filewriter.append("\n");
		        
		        filewriter.flush();
		        filewriter.close();
		        
		        request.setAttribute("Outer_ArrayList", Inner_ArrayList_Object); 
			    forward="MovieInfoPage.jsp";
			    RequestDispatcher view = request.getRequestDispatcher(forward);
			    view.forward(request, response);
			    out.close();		        
		    }
		  }
		  catch(Exception e){
			  System.out.println(e);
		  }		
	}

}
