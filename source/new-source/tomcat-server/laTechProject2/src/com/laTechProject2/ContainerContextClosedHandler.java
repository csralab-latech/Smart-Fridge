package com.laTechProject2;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import com.mysql.jdbc.AbandonedConnectionCleanupThread;

@WebListener // register it as you wish
public class ContainerContextClosedHandler implements ServletContextListener {
    //private static final Logger logger = LoggerFactory.getLogger(ContainerContextClosedHandler.class);

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // nothing to do
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        Enumeration<Driver> drivers = DriverManager.getDrivers();     

        Driver driver = null;

        // clear drivers
        while(drivers.hasMoreElements()) {
            try {
                driver = drivers.nextElement();
                DriverManager.deregisterDriver(driver);

            } catch (SQLException ex) {
                // deregistration failed, might want to do something, log at the very least
            }
        }

        // MySQL driver leaves around a thread. This static method cleans it up.
        try {
            AbandonedConnectionCleanupThread.shutdown();
        } catch (InterruptedException e) {
            // again failure, not much you can do
        }
    }

}