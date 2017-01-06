/*
Name: Ankeet Tendulkar
USC CSCI 548 Fall 2016
Servlet which gets movies made by the Director Producer Writer combination.
*/


package Project;

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
 * Servlet implementation class CombinedSearchResultPage
 */
@WebServlet("/CombinedSearchResultPage")
public class CombinedSearchResultPage extends HttpServlet {
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
    public CombinedSearchResultPage() {
        super();
        // TODO Auto-generated constructor stub
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
				
		try
		  {
	        statement = connection.createStatement();
	        System.out.println("Statement Created");
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String Director = request.getParameter("Director");
			request.setAttribute("Director_String", Director);
			System.out.println(Director);
			
			String Producer = request.getParameter("Producer");
			request.setAttribute("Producer_String", Producer);
			System.out.println(Producer);
			
			String Writer = request.getParameter("Writer");
			request.setAttribute("Writer_String", Writer);
			System.out.println(Writer);
		 	
			if(Director.equals(""))
			{
				response.sendRedirect("Search.jsp");
			}
		    else
		    {
			   	PreparedStatement statement = connection.prepareStatement("select * from iiwproject.finalresulttable where iiwproject.finalresulttable.Directors LIKE "+ "\"%" + Director + "%\"" +
			   			"or iiwproject.finalresulttable.Producers LIKE "+ "\"%" + Producer + "%\"" + "or iiwproject.finalresulttable.Writers LIKE "+ "\"%" + Writer + "%\"");
		        ResultSet rst1 = statement.executeQuery();
		        System.out.println("Result Set Created");
		       
		        ArrayList Inner_ArrayList_Object = new ArrayList();
				
		        while (rst1.next()) {
			    	
					String s2  = new String(rst1.getString(2));
					Inner_ArrayList_Object.add(s2);
					System.out.println(s2);
					
					Integer BechResult =new Integer(rst1.getInt(18));
					System.out.println(BechResult);
					Inner_ArrayList_Object.add(BechResult);
					
		  	    	System.out.println("Collected Data");
		  	    	
		  	    }
		        
		        PreparedStatement statement2 = connection.prepareStatement("select iiwproject.finalresulttable.Results, Count(*) from iiwproject.finalresulttable where iiwproject.finalresulttable.Directors LIKE " + "\"" + Director + "\"" + " or iiwproject.finalresulttable.Producers LIKE "+ "\"" + Producer + "\"" + " or iiwproject.finalresulttable.Writers LIKE "+ "\"" + Writer + "\"" + " GROUP BY iiwproject.finalresulttable.Results");
		        ResultSet rst2 = statement2.executeQuery();
		        System.out.println("Result Set 2 Created");
		        		       
		        ArrayList Second_Inner_ArrayList_Object = new ArrayList();
				
		        while (rst2.next()) {
			    						
					String s2  = new String(rst2.getString(1));
					Second_Inner_ArrayList_Object.add(s2);
					System.out.println(s2);
					
					Integer NumBechResult =new Integer(rst2.getInt(2));
					System.out.println(NumBechResult);
					Second_Inner_ArrayList_Object.add(NumBechResult);
					
		        }
		        		        
		        request.setAttribute("Outer_ArrayList", Inner_ArrayList_Object);
		        request.setAttribute("Second_Outer_ArrayList", Second_Inner_ArrayList_Object);
		      
			    forward="DirProdWriResultPage.jsp";
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
