package jdbc;

import java.util.Scanner;
import java.io.IOException;
import java.sql.*;

import static jdbc.UI.printResults;

/*
* 
* @author MP
* @version 1.0
* @since 2024-11-07
*/
public class Model {

    static String inputData(String str) throws IOException {
        // IMPLEMENTED
        /*
         * Gets input data from user
         * 
         * @param str Description of required input values
         * 
         * @return String containing comma-separated values
         */
        Scanner key = new Scanner(System.in); // Scanner closes System.in if you call close(). Don't do it
        System.out.println("Enter corresponding values, separated by commas of:");
        System.out.println(str);
        return key.nextLine();
    }

    static void addUser(User userData, Card cardData) {
        // PARCIALLY IMPLEMENTED
        /**
         * Adds a new user with associated card to the database
         * 
         * @param userData User information
         * @param cardData Card information
         * @throws SQLException if database operation fails
         */
        final String INSERT_PERSON = "INSERT INTO person(email, taxnumber, name) VALUES (?,?,?) RETURNING id";
        final String INSERT_CARD = "INSERT INTO card(credit, typeof, client) VALUES (?,?,?)";
        final String INSERT_USER = "INSERT INTO client(person, dtregister) VALUES (?,?)";

        try (
                Connection conn = DriverManager.getConnection(UI.getInstance().getConnectionString());
                PreparedStatement pstmtPerson = conn.prepareStatement(INSERT_PERSON, Statement.RETURN_GENERATED_KEYS);
                PreparedStatement pstmtCard = conn.prepareStatement(INSERT_CARD);
                PreparedStatement pstmtUser = conn.prepareStatement(INSERT_USER);
        ) {
            conn.setAutoCommit(false);

            // Insert the person record (email, tax number, name)
            pstmtPerson.setString(1, userData.getEmail());
            pstmtPerson.setInt(2, userData.getTaxNumber());
            pstmtPerson.setString(3, userData.getName());

            int affectedRows = pstmtPerson.executeUpdate();
            if (affectedRows == 0) {
                throw new RuntimeException("Creating person failed, no rows affected.");
            }

            int personId;
            try (ResultSet generatedKeys = pstmtPerson.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    personId = generatedKeys.getInt(1);
                } else {
                    throw new RuntimeException("Creating person failed, no ID obtained.");
                }
            }
            
            
            
            // CONTINUE ----|>  ADICIONADO
            pstmtUser.setInt(1, personId); //
            pstmtUser.setTimestamp(2, new Timestamp(System.currentTimeMillis()));//Data de Refisto
            pstmtUser.executeUpdate();



            conn.commit();
            if (pstmtUser != null)//sempre true por enquanto
                pstmtUser.close();
            if (pstmtCard != null)
                pstmtCard.close();
            if (pstmtPerson != null)//sempre true por enquanto
                pstmtPerson.close();
            if (conn != null) {//sempre true por enquanto
                conn.setAutoCommit(true);
                conn.close();
            }
            System.out.println("User added successfully!");
            Model.listUsers();
        } catch (SQLException e) {
            System.out.println("Error on insert values");
            // e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        }
    }
    //ADICIONADO
    static void listUsers() {
        final String QUERY = "SELECT * FROM person";  // Query to get all users from the person table
        try (
                Connection conn = DriverManager.getConnection(UI.getInstance().getConnectionString());
                PreparedStatement pstmt = conn.prepareStatement(QUERY);
                ResultSet rs = pstmt.executeQuery();
        ) {
            printResults(rs);
        } catch (SQLException e) {
            System.out.println("Error retrieving users");
            e.printStackTrace();
        }
    }


    /**
     * To implement from this point forward. Do not need to change the code above.
     * -------------------------------------------------------------------------------
     * IMPORTANT:
     * --- DO NOT MOVE IN THE CODE ABOVE. JUST HAVE TO IMPLEMENT THE METHODS BELOW
     * ---
     * -------------------------------------------------------------------------------
     **/

    static void listOrders(String[] orders) {
        /**
         * Lists orders based on specified criteria
         * 
         * @param orders Criteria for listing orders
         * @throws SQLException if database operation fails
         */
        //final String VALUE_CMD = " TO BE DONE";
        // try(
        // Connection conn =
        // DriverManager.getConnection(UI.getInstance().getConnectionString());
        // PreparedStatement pstmt1 = conn.prepareStatement(VALUE_CMD);
        // ){

        // }
        if (orders.length != 3) {
            System.out.println("Invalid input. Expected format: startDate,endDate,stationNumber");
            return;
        }

        String startDate = orders[0];
        String endDate = orders[1];
        int stationNumber;

        try {
            stationNumber = Integer.parseInt(orders[2]);
        } catch (NumberFormatException e) {
            System.out.println("Station number must be an integer.");
            return;
        }

        String query = "SELECT * FROM REPLACEMENTORDER WHERE dtorder >= CAST(? AS TIMESTAMP) AND dtorder <= CAST(? AS TIMESTAMP) AND station = ?";

        try (Connection conn = DriverManager.getConnection(UI.getInstance().getConnectionString());
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            pstmt.setInt(3, stationNumber);

            try (ResultSet rs = pstmt.executeQuery()) {
                UI.printResults(rs); // Exibir os resultados no console
            }

        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }

    }

    
    public static void listReplacementOrders(int stationId, Timestamp startDate, Timestamp endDate) throws SQLException {
        /**
         * Lists replacement orders for a specific station in a given time period
         * @param stationId Station ID
         * @param startDate Start date for period
         * @param endDate End date for period
         * @throws SQLException if database operation fails
         */
        // TO BE DONE
        System.out.print("EMPTY");
    }

    public static void travel(String[] values){
        /**
         * Processes a travel operation (start or stop)
         * @param values Array containing [operation, name, station, scooter]
         * @throws SQLException if database operation fails
         */
        // TO BE DONE  
    }
    
    public static int getClientId(String name) throws SQLException {
        /** Auxiliar method -- if you want
         * Gets client ID by name from database
         * @param name The name of the client
         * @return client ID or -1 if not found
         * @throws SQLException if database operation fails
         */
        return Integer.parseInt(name);//MARTELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
    }

    public static void startTravel(int clientId, int scooterId, int stationId) throws SQLException {
        /**
         * Starts a new travel
         * @param clientId Client ID
         * @param scooterId Scooter ID
         * @param stationId Station ID
         * @throws SQLException if database operation fails
         */
        System.out.print("EMPTY");
    }

    
    public static void stopTravel(int clientId, int scooterId, int stationId) throws SQLException {
        /**
         * Stops an ongoing travel
         * @param clientId Client ID
         * @param scooterId Scooter ID
         * @param stationId Destination station ID
         * @throws SQLException if database operation fails
         */
        System.out.print("EMPTY");
    }

    public static void updateDocks(/*FILL WITH PARAMETERS */) {
        // TODO
        System.out.println("updateDocks()");
    }

    public static void userSatisfaction(/*FILL WITH PARAMETERS */) {
        // TODO
        System.out.println("userSatisfaction()");
    }

    public static void occupationStation(/*FILL WITH PARAMETERS */) {
        // TODO
        System.out.println("occupationStation()");
    }    
}