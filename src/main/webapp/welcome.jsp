<%--
  Created by IntelliJ IDEA.
  User: piyushmittal
  Date: 5/9/15
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page language="java" import="java.util.*" %>
<%@ page import="Facebook.FController" %>
<%@page import="com.restfb.DefaultFacebookClient" %>
<%@page import="com.restfb.Version" %>
<%@ page import="FacebookUser.UPost" %>
<%@page import="com.restfb.types.Photo" %>
<%@page import="com.restfb.types.User" %>
<%@page import="javax.swing.JOptionPane" %>
<%@page import="java.text.DateFormatSymbols" %>
<%@page import="java.text.SimpleDateFormat" %>


<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>Facebook Moments</title>
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="css/styles.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="../profile.js"></script>
    <link rel="shortcut icon" type="image/ico" href="image/favicon.ico" />
    <script>
        function myFunction(i) {
            var str = "div"+i;
            //alert (str);
            if (document.getElementById(str).style.display == "none")
            {
                document.getElementById(str).style.display = "block";
                document.getElementById("testLink").innerText ="-";
            }
            else {
                document.getElementById(str).style.display = "none";
                document.getElementById("testLink").innerText = "+";
            }

            //document.getElementById("example").style.color = "red";
        }
        function myShare() {
                <%
                    HttpSession se = request.getSession();
                    if (se.getAttribute("token") != null)
                    {
                        FController fbc = new FController();
                        User me = fbc.getInfo();
                        String str = request.getParameter("mess");
                        fbc.publishStory(str, me.getEmail());
                    }

                %>
                alert ("You posted a message on your wall");
        }

    </script>
</head>
<body>
<%
    HttpSession tok = request.getSession();
    FController fb = new FController();
    if (tok.getAttribute("token") == null)
    {
        fb.token = fb.getFacebookUserToken(request.getParameter("code"),fb.redirectUrl);
        tok.setAttribute("token", fb.token);
    }
    fb.fbClient = new DefaultFacebookClient(fb.token.getAccessToken(),Version.VERSION_2_2);

%>

<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">




            <!-- main right col -->
            <div class="column" id="main">

                <!-- top nav -->
                <div class="navbar navbar-blue navbar-static-top" style="width: 100%" >
                    <div class="navbar-header">
                        <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand logo" style="font-size: xx-large;padding-top:8px;" >f</a>
                        <ul class="nav navbar-nav">
                            <li>
                                <a style="font-size: large; color: #ffffff" ><b>facebook</b></a>
                            </li>

                        </ul>
                    </div>
                    <nav class="collapse navbar-collapse" role="navigation">


                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a class="name-id"></a>
                            </li>
                            <li class="dropdown">
                                <a href="<%=fb.fbClient.getLogoutUrl("http://localhost:8080/index.jsp")%>" style="border-left-style: solid; border-left-width: 1px; border-color: #98AFC7" >Logout</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <!-- /top nav -->

                <div class="padding">
                    <div class="full col-sm-9">

                        <!-- content -->
                        <div class="row">

                            <!-- main col left -->
                            <div class="col-sm-5" style="width: 19%" >

                                <div class="panel panel-default">
                                    <div class="panel-thumbnail"><img id="profile-pic" class="img-responsive"></div>

                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading"> <h4>Information</h4></div>
                                    <div class="panel-body">

                                        <table>
                                            <tr>
                                                <td style="font-size: small; color: #2A4888">Birth Date:</td>
                                            </tr>
                                            <tr>

                                                <td class="birth-id"  style="font-size: small"><i></i></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: #2A4888">Hometown:</td>
                                            </tr>
                                            <tr>
                                                <td class="home-id" style="font-size: small"><i></i></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: #2A4888">Gender:</td>
                                            </tr>
                                            <tr>
                                                <td class="gender-id" style="font-size: small"><i></i></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: #2A4888">Interested In:</td>
                                            </tr>
                                            <tr>
                                                <td class="interest-id" style="font-size: small"><i></i></td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: small; color: #2A4888">Relationship Status:</td>
                                            </tr>
                                            <tr>
                                                <td class="relation-id" style="font-size: small"><i></i></td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading"> <h4>Friends</h4></div>
                                    <div id="friend-pics" class="panel-body" style="height:205px;overflow: auto" >


                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading"> <h4>Photos</h4></div>
                                    <div id="photo" class="panel-body" style="height:205px;overflow: auto" >


                                    </div>
                                </div>

                            </div>


                            <!-- main col right -->
                            <div class="col-sm-7" style="width: 75%">

                                <div class="well">
                                    <form class="form" action="#"  METHOD="POST">
                                        <h4>Write something...</h4>
                                        <div class="input-group text-center">
                                            <input type="text" class="form-control input-lg" id="mess" name="mess">
                                            <span class="input-group-btn"><button class="btn btn-lg btn-primary" onclick="myShare()"  type="submit">Share</button></span>
                                        </div>
                                    </form>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading"><h4>Top Moments</h4></div>
                                    <div id="moments" class="panel-body">


                                    </div>
                                </div>

                            </div>
                        </div><!--/row-->


                        <hr>




                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->

        </div>
    </div>
</div>


<!--post modal-->
<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                Update Status
            </div>
            <div class="modal-body">
                <form class="form center-block">
                    <div class="form-group">
                        <textarea class="form-control input-lg" autofocus="" placeholder="What do you want to share?"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div>
                    <button class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true">Post</button>
                    <ul class="pull-left list-inline"><li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li><li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li><li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li></ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- script references -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
</body>
</html>