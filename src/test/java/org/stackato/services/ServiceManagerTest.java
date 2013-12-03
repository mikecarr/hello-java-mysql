package org.stackato.services;

import org.junit.Test;

import java.net.URI;

/**
 * User: mcarr
 * Date: 12/2/13
 * <p/>
 * Qualcomm
 */
public class ServiceManagerTest {

    @Test
    public void testURIParsing() throws Exception {
        String uriString = "mysql://duvurabeqaqojuye:HOZEtOgogaCiWE565277@qcd7p2oisldqrp.c8rkwwpadgal.us-west-2.rds.amazonaws.com:3306/mydb";

        URI uri = URI.create(uriString);

        String hostname = uri.getHost();
        int port = uri.getPort();
        String path = uri.getPath();
        String[] credentials = uri.getUserInfo().split(":");
        String username = credentials[0];
        String password = credentials[1];


    }
}
