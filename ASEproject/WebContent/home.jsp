<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Home Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
                <script type='text/javascript' src='//cdnjs.cloudflare.com/ajax/libs/angular.js/1.1.1/angular.min.js'></script>

<!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
        <script type="text/javascript" src="http://oauth.googlecode.com/svn/code/javascript/oauth.js"></script>
        <script type="text/javascript" src="http://oauth.googlecode.com/svn/code/javascript/sha1.js"></script>
        <script type="text/javascript">
            
              function Load($scope) {
                  $scope.logins = [];
                  $scope.login = function () {
                $scope.logins.push( localStorage.getItem("name") + " was logged in.");
        };
    }
            var auth = {
                //
                // Update with your auth tokens.
                //
                consumerKey : "jt0oPdDr63AG2Wt_CUVzmw",
                consumerSecret : "-VYw0JDITsgueWYbC05BqxIm8Xk",
                accessToken : "3zZudhTh2F2sKckMAg8bxoOIVW-ArW-c",
                accessTokenSecret : "KfLzlFQJM06yq8tdROhdAutGdCo",
                serviceProvider : {
                    signatureMethod : "HMAC-SHA1"
                }
            };

            $(document).ready(function() {
                console.log("Hello")
                
                $("#search-btn").click(function(event) {
                    var keyword = $("#search-entry").val()
                    
                    console.log(keyword);
                    var terms = keyword;
                    var near = 'Kansas+City';

                    var accessor = {
                        consumerSecret : auth.consumerSecret,
                        tokenSecret : auth.accessTokenSecret
                    };
                    parameters = [];
                    parameters.push(['term', terms]);
                    parameters.push(['location', near]);
                    parameters.push(['callback', 'cb']);
                    parameters.push(['oauth_consumer_key', auth.consumerKey]);
                    parameters.push(['oauth_consumer_secret', auth.consumerSecret]);
                    parameters.push(['oauth_token', auth.accessToken]);
                    parameters.push(['oauth_signature_method', 'HMAC-SHA1']);

                    var message = {
                        'action' : 'http://api.yelp.com/v2/search',
                        'method' : 'GET',
                        'parameters' : parameters
                    };

                    OAuth.setTimestampAndNonce(message);
                    OAuth.SignatureMethod.sign(message, accessor);

                    var parameterMap = OAuth.getParameterMap(message.parameters);
                    console.log(parameterMap);

                    $.ajax({
                        'url' : message.action,
                        'data' : parameterMap,
                        'dataType' : 'jsonp',
                        'jsonpCallback' : 'cb',
                        'success' : function(output, textStats, XMLHttpRequest) {
                            console.log(output);
                            $("#results").empty();
                            var items = output.businesses
                            for(i = 0; i< items.length; i++) {
                                var item = items[i];
                                console.log(item.name);
                                var phone = item.display_phone;
                                var location = item.location.display_address;
                                var ratings = "<img src="+item.rating_img_url+">"+"</img>";
                                var image = "<img src="+item.image_url+">"+"</img>";
                                $("#results").append("<p>"+item.name+"</p>"+image+"<p>"+phone+"</p>"+"<a href=\"directions.jsp?address="+item.name+" "+location+"\">"+location+"</a>"+"<p>"+ratings+"</p>"+"</div>");
                                       
                            }
                        }
                    });
                });
            })
        </script>
        <style>
            body {
	           background: url(http://mymaplist.com/img/parallax/back.png);
	           background-color: #444;
	           background: url(http://mymaplist.com/img/parallax/pinlayer2.png),
		      url(http://mymaplist.com/img/parallax/pinlayer1.png),
		      url(http://mymaplist.com/img/parallax/back.png);	
            }

            .vertical-offset-100 {
	         padding-top: 100px;
            }
        </style>
    </head>
    <body>
     
    
    
        <br></br>
        <div align="center">
            <div  class=" col-md-12" >
                <div class="panel panel-default">
                    <div class="panel-heading">
                    <h1 style="color:green">Plan B</h1>
                        <h1><center>Hello ${username }</center> 
                        </h1> <h4> <u><a href="Login.html">Logout</a></u></h4>
                    </div>
                    <div class="panel-body">
                        <div align="center">
                            <input type="text" id="search-entry" placeholder="Resturant/Place/Movie"/>
                            <button id="search-btn" type="button" class="btn">Search</button>
                            <div id="results">               
                            </div>
                        </div>
                    </div>            
                </div>
            </div>
        </div>   
    </body>
</html>