!SLIDE 
# Writing web apps with Ruby and Heroku #

## Tom Ward / @tomafro / tomafro.net ##

!SLIDE bullets incremental

# In this presentation I'll attempt to:

!SLIDE

# Explain why I like Ruby

!SLIDE

# Introduce some simple Ruby concepts

!SLIDE

# Attempt to build AND deploy a simple app using Ruby and Heroku (fingers crossed!)

!SLIDE

# About Me #

!SLIDE bullets incremental

# Developer for 10 years #

* 5 years with Java/J2EE
* 5 years with Ruby and Rails

!SLIDE

# So why leave Java for Ruby? #

!SLIDE

# Here's the Java code for a very simple Hello World web app, taken from an online tutorial... #

!SLIDE
  
## web.xml ##

    @@@ xml
    <?xml version="1.0" encoding="UTF-8"?>
    <web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
        http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">
        <servlet>
            <servlet-name>action</servlet-name>
            <servlet-class>org.apache.struts.action.ActionServlet</servlet-class>
            <init-param>
                <param-name>config</param-name>
                <param-value>/WEB-INF/struts-config.xml</param-value>
            </init-param>
            <init-param>
                <param-name>debug</param-name>
                <param-value>2</param-value>
            </init-param>
            <init-param>
                <param-name>detail</param-name>
                <param-value>2</param-value>
            </init-param>
            <load-on-startup>2</load-on-startup>
            </servlet>
        <servlet-mapping>
            <servlet-name>action</servlet-name>
            <url-pattern>*.do</url-pattern>
        </servlet-mapping>
        <session-config>
            <session-timeout>
                30
            </session-timeout>
        </session-config>
        <welcome-file-list>
            <welcome-file>index.jsp</welcome-file>
            </welcome-file-list>
        <jsp-config>
            <taglib>
                <taglib-uri>/WEB-INF/struts-bean.tld</taglib-uri>
                <taglib-location>/WEB-INF/struts-bean.tld</taglib-location>
            </taglib>
            <taglib>
                <taglib-uri>/WEB-INF/struts-html.tld</taglib-uri>
                <taglib-location>/WEB-INF/struts-html.tld</taglib-location>
            </taglib>
            <taglib>
                <taglib-uri>/WEB-INF/struts-logic.tld</taglib-uri>
                <taglib-location>/WEB-INF/struts-logic.tld</taglib-location>
            </taglib>
            <taglib>
                <taglib-uri>/WEB-INF/struts-nested.tld</taglib-uri>
                <taglib-location>/WEB-INF/struts-nested.tld</taglib-location>
            </taglib>
            <taglib>
                <taglib-uri>/WEB-INF/struts-tiles.tld</taglib-uri>
                <taglib-location>/WEB-INF/struts-tiles.tld</taglib-location>
            </taglib>
            </jsp-config>
        </web-app>

!SLIDE

## struts-config.xml ##

    @@@ xml
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE struts-config PUBLIC "-//Apache Software Foundation//DTD Struts Configuration 1.2//EN"  "http://jakarta.apache.org/struts/dtds/struts-config_1_2.dtd">
    <struts-config>
        <form-beans>
            <form-bean name="HelloWorldActionForm" type="com.vaannila.HelloWorldActionForm"/>
        </form-beans>
        <global-exceptions>
        </global-exceptions>
        <global-forwards>
            <forward name="welcome"  path="/Welcome.do"/>
        </global-forwards>
        <action-mappings>
            <action input="/index.jsp" name="HelloWorldActionForm" path="/HelloWorld" scope="session" type="com.vaannila.HelloWorldAction">
                <forward name="success" path="/helloWorld.jsp" />
            </action>
            <action path="/Welcome" forward="/welcomeStruts.jsp"/>
        </action-mappings>
        <controller processorClass="org.apache.struts.tiles.TilesRequestProcessor"/>
        <message-resources parameter="com/vaannila/ApplicationResource"/>
        <plug-in className="org.apache.struts.validator.ValidatorPlugIn">
            <set-property
                property="pathnames"
                value="/WEB-INF/validator-rules.xml,/WEB-INF/validation.xml"/>
        </plug-in>
    </struts-config>
    
!SLIDE

## validator-rules.xml ##

    @@@ xml
    <form-validation>
       <global>

          <validator name="required"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateRequired"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                      msg="errors.required"/>

          <validator name="requiredif"
                     classname="org.apache.struts.validator.FieldChecks"
                     method="validateRequiredIf"
                     methodParams="java.lang.Object,
                                   org.apache.commons.validator.ValidatorAction,
                                   org.apache.commons.validator.Field,
                                   org.apache.struts.action.ActionMessages,
                                   org.apache.commons.validator.Validator,
                                   javax.servlet.http.HttpServletRequest"
                     msg="errors.required"/>

          <validator name="validwhen"
              msg="errors.required"
                     classname="org.apache.struts.validator.validwhen.ValidWhen"
                     method="validateValidWhen"
                     methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"/>


          <validator name="minlength"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateMinLength"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.minlength"
               jsFunction="org.apache.commons.validator.javascript.validateMinLength"/>


          <validator name="maxlength"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateMaxLength"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.maxlength"
               jsFunction="org.apache.commons.validator.javascript.validateMaxLength"/>



          <validator name="mask"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateMask"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.invalid"/>


          <validator name="byte"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateByte"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.byte"
           jsFunctionName="ByteValidations"/>


          <validator name="short"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateShort"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.short"
           jsFunctionName="ShortValidations"/>


          <validator name="integer"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateInteger"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.integer"
           jsFunctionName="IntegerValidations"/>



          <validator name="long"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateLong"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.long"/>


          <validator name="float"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateFloat"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.float"
           jsFunctionName="FloatValidations"/>

          <validator name="double"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateDouble"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.double"/>


          <validator name="date"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateDate"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends=""
                      msg="errors.date"
           jsFunctionName="DateValidations"/>


          <validator name="intRange"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateIntRange"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends="integer"
                      msg="errors.range"/>


          <validator name="floatRange"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateFloatRange"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends="float"
                      msg="errors.range"/>

          <validator name="doubleRange"
                classname="org.apache.struts.validator.FieldChecks"
                   method="validateDoubleRange"
             methodParams="java.lang.Object,
                           org.apache.commons.validator.ValidatorAction,
                           org.apache.commons.validator.Field,
                           org.apache.struts.action.ActionMessages,
                           org.apache.commons.validator.Validator,
                           javax.servlet.http.HttpServletRequest"
                  depends="double"
                      msg="errors.range"/>
                      
!SLIDE bullets incremental

## Not to mention...

* validation.xml
* tile-defs.xml
* struts-tiles.tld
* struts-nested.tld
* struts-logic.tld
* struts-html.tld
* struts-bean.tld

!SLIDE

# All of these files before we even get to the code... #

!SLIDE

## HelloWorldAction.java ##

    @@@ java
    public class HelloWorldAction extends org.apache.struts.action.Action {

        @Override
        public ActionForward execute(ActionMapping mapping, ActionForm form,
                HttpServletRequest request, HttpServletResponse response)
                throws Exception {
            HelloWorldActionForm helloWorldForm = (HelloWorldActionForm) form;
            helloWorldForm.setMessage("Hello World!");
            return mapping.findForward(SUCCESS);
        }
    }
    
!SLIDE

## HelloWorldActionForm.java ##

    @@@ java
    
    public class HelloWorldActionForm extends org.apache.struts.action.ActionForm {

        private String message;

        public HelloWorldActionForm() {
            super();
        }

        public String getMessage() {
            return message;
        }
        
        public void setMessage(String message) {
            this.message = message;
        }
    }
    
!SLIDE

## helloworld.jsp ##

    @@@ xml
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
       "http://www.w3.org/TR/html4/loose.dtd">

    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Hello World</title>
        </head>
        <body>
            <h1><bean:write name="HelloWorldActionForm" property="message"></bean:write></h1>
        </body>
    </html>
    
!SLIDE

# And the equivalent in Ruby + Sinatra.... #

!SLIDE

## config.ru ##

    @@@ ruby
    require 'sinatra'
    require 'erb'
    
    get '/' do
      @message = "Hello World!"
      erb :index
    end

    run Sinatra::Application

!SLIDE

## views/index.erb

    @@@ html
    
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Hello World</title>
        </head>
        <body>
            <h1><%= @message %></h1>
        </body>
    </html>
    
!SLIDE

# This isn't a totally fair comparison #

!SLIDE

# But the point still stands: #

# I can write applications in ruby that are FAR more concise than Java #

