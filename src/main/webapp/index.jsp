<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="java.sql.*,javax.sql.*"%><%@page import="org.stackato.services.*"%><%
    String query = "Select * FROM users";
%>
<%@page import="org.apache.log4j.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">

    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">

            /* Sticky footer styles
            -------------------------------------------------- */

        html,
        body {
            height: 100%;
            /* The html and body elements cannot have any padding or margin. */
        }

            /* Wrapper for page content to push down footer */
        #wrap {
            min-height: 100%;
            height: auto !important;
            height: 100%;
            /* Negative indent footer by it's height */
            margin: 0 auto -60px;
        }

            /* Set the fixed height of the footer here */
        #push,
        #footer {
            height: 60px;
        }
        #footer {
            background-color: #f5f5f5;
        }

            /* Lastly, apply responsive CSS fixes as necessary */
        @media (max-width: 767px) {
            #footer {
                margin-left: -20px;
                margin-right: -20px;
                padding-left: 20px;
                padding-right: 20px;
            }
        }



            /* Custom page CSS
            -------------------------------------------------- */
            /* Not required for template or sticky footer method. */

        .container {
            width: auto;
            max-width: 680px;
        }
        .container .credit {
            margin: 20px 0;
        }

    </style>

    <title>runQ with Simple Java</title>
</head>

<body>
    <div id="wrap">
        <div class="container">
            <div class="page-header">

                <h1>Welcome to the simple web application on runQ...</h1>

                <p class="lead">Simple Java app using Heroku Buildpack</p>
            </div>


    <%
        Logger logger = Logger.getLogger("");
        Connection connection = null;

        try {
            // establish connection to MySQL Service
            ServiceManager services = ServiceManager.INSTANCE;
            //connection = (Connection) services.getInstance(StackatoServices.MYSQL);
            connection = (Connection) services.getInstance(StackatoServices.APCERA);
            logger.info("after connection");

            if (connection != null && !connection.isClosed()) {
                out.println("<p>Successfully connected to MySQL service</p>");

                // creating a database table and populating some values
                Statement s = connection.createStatement();
                int count;
                s.executeUpdate("DROP TABLE IF EXISTS animal");
                s.executeUpdate("CREATE TABLE animal (" + "id INT UNSIGNED NOT NULL AUTO_INCREMENT," + "PRIMARY KEY (id)," + "name CHAR(40), category CHAR(40))");

                out.println("<p>[1] Table successfully created.</p>");

                count = s.executeUpdate("INSERT INTO animal (name, category)" + " VALUES" + "('snake', 'reptile')," + "('frog', 'amphibian')," + "('tuna', 'fish')," + "('racoon', 'mammal')");

                out.println("<p>[2] " + count + " rows were inserted.</p>");

                count = 0;
                ResultSet rs = s.executeQuery("select * from animal");
                out.println("<table class='table table-bordered'>");
                out.println("<thead>");
                out.println("<tr>");
                out.println("<th>Id</th>");
                out.println("<th>Animal</th>");
                out.println("<th>Type</th>");
                out.println("</tr>");
                out.println("</thead>");
                while (rs.next()) {
                    count++;
                    out.println("<tr>");
                    out.println("<td>");
                    out.println(rs.getString(1));
                    out.println("</td>");
                    out.println("<td>");
                    out.println(rs.getString(2));
                    out.println("</td>");
                    out.println("<td>");
                    out.println(rs.getString(3));
                    out.println("</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                out.println("<p>[3] " + count + " rows were fetched.</p>");

                s.close();
            }else{
                out.println("Oops! Something is wrong! Connection closed: " + connection.isClosed()) ;
            }
        } catch (Exception e) {
            out.println(e.getMessage());
        } finally {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }

            connection = null;
        }
    %>
        </div>
        <div id="push"></div>

    </div>
    <div id="footer">
        <div class="container">
            <p>Qualcomm IT / EA/SSAT runQ</p>
        </div>
    </div>

    <!-- javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-js"></script>

</body>
</html>