<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<title>Club Connect</title>
<meta charset="UTF-8">
<!-- Template modified from "https://www.w3schools.com/w3css/default.asp" target="_blank"-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet'
	href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="/js/jquerygroupsProfile.js""></script>



<!-------------------------------------------------------------------------------CSS------------------------------------------------------------------------------->
<style>
#text_post {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
	height: 25%;
}

html, body, h1, h2, h3, h4, h5 {
	font-family: "Open Sans", sans-serif
}

#coverTopSection {
	margin: 0;
	padding: 0;
}

.coverPic {
	display: block;
	position: relative;
	height: 415px;
	overflow: hidden;
	text-decoration: none;
}

.cover {
	height: 300px;
	position: relative;
	overflow: hidden;
}

.cover>img {
	position: absolute;
	display: block;
	max-width: 1400px;
	top: 0;
	left: 0;
}
</style>


<!------------------------------------------------------------------------------Body------------------------------------------------------------------------------->
<body class="w3-theme-l5">

	<!---------------------------------------Header, Container, Cover Photo, Menu Bar--------------------------------------->
	<jsp:include page="header.jsp" />

	<!-- Page Container -->
	<div class="w3-container w3-content" style="max-width: 1400px">

		<!--Background Image, Menu Bar -->
		<div class="cover">
			<img src="images/iu6.jpeg">
		</div>

		<!--The Grid-->
		<div class="w3-row">
			<jsp:include page="menuBar.jsp" />

			<!-------------------Left Column------------------->
			<div class="w3-col m3">
				<br>

				<!-- Profile Picture and brief info on club-->
				<div class="w3-card-2 w3-round w3-white">
					<div class="w3-container">
						<p class="w3-center">
							<img src="images/2.png" width="170" height="170">
						</p>
						<hr>
						<p>
							<i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i>
							Designer, UI
						</p>
						<p>
							<i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i>
							London, UK
						</p>
						<p>
							<i
								class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i>
							April 1, 1988
						</p>
					</div>
				</div>
				<br>

				<!-- Members List -->
				<div class="w3-card-2 w3-round w3-white w3-hide-small">
					<div class="w3-container">
						<h3>Membership</h3>
						<c:forEach items="${membersList}" var="ml">
							<label for="memberName"
								style="margin-top: 15%; font-size: 20px; left: 20%">
								${memberName.userId}<br>
							</label>
						</c:forEach>
					</div>
				</div>
			</div>

			<!-------------------Middle Column------------------->
			<div class="w3-col m7">
				<br>
				<!-- Container for club name and briefing -->
				<div class="w3-row-padding">
					<div class="w3-col m12">
						<div class="w3-card-2 w3-round w3-white">
							<div class="w3-container w3-padding">
								<h2>${groupSearched.groupName}</h2>
								<p>${groupSearched.about}</p>
							</div>
						</div>
					</div>
				</div>

				<!-- The following appears only to club members -->
				<c:if test="${fn:length(groupmember) > 0}">
					<!-- Make a new Post -->
					<div class="w3-container w3-card-2 w3-white w3-round w3-margin">
						<div class="w3-container w3-padding">
							<h6 class="w3-opacity">What would you like to share?</h6>

							<!--copied code from master branch...can't get it to work-->
							<form
								action="/createPost/${groupSearched.groupId }/${user.userId }"
								method="POST" class="form-inline" align="left">
								<label><b>Club Posts</b></label> <input type="hidden"
									name="groupId" id="groupId" value="${groupSearched.groupId }">
								<input type="text" placeholder="posts" name="postDesc"
									width="25%" height="25%" maxlength="150" required>
								<button type="submit" class="btn btn-default btn-block">
									Post</button>
							</form>
							<!--ATTEMPTED CODE FROM w3 schools, also doesn't work			<p contenteditable="true" class="w3-border w3-padding">My
								club update is...</p>
							<form
								action="/createPost/${groupSearched.groupId }/${user.userId }"
								method="POST" class="form-inline" align="left">
								<input type="hidden" name="groupId" id="groupId"
									value="${groupSearched.groupId }"> <input type="text"
									placeholder="posts" name="postDesc" width="25%" height="25%"
									maxlength="150" required>
								<button type="submit" class="w3-button w3-theme">
									<i class="fa fa-pencil"></i>  Post
								</button>
							</form>-->
						</div>
					</div>

					<!-- See existing posts, in reverse chrono order -->
					<c:if test="${fn:length(ps) > 0}">
						<c:forEach items="${ps}" var="post">

							<!-- Creates new container for each post on club all -->
							<div class="w3-container w3-card-2 w3-white w3-round w3-margin">
								<br> <span class="w3-right w3-opacity">${post.postedDatetime}</span>
								
								<h6 class="w3-opacity">The poster's name goes here!</h6>
								<hr class="w3-clear">
								<div>${post.postDesc}</div>
								<br>

								<button type="button"
									class="w3-button w3-theme-d1 w3-margin-bottom">
									<i class="fa fa-thumbs-up"></i>  Like
								</button>

								<button type="button"
									class="w3-button w3-theme-d2 w3-margin-bottom">
									<i class="fa fa-comment"></i>  Comment
								</button>

								<form
									action="/deletePost/${post.postId }/${user.userId }/${groupSearched.groupId }"
									method="post">

								<button type="submit">
									<img src="/images/deleteicon.png">
								</button></form>
								
							</div>

						</c:forEach>
					</c:if>
					<c:if test="${fn:length(ps) == 0}">
						<p>No posts</p>
					</c:if>
				</c:if>
			</div>

			<!-------------------Right Column------------------->
			<div class="w3-col m2">
				<br>
				<!-- Colleague Requests -->
				<div class="w3-card-2 w3-round w3-white w3-center">
					<div class="w3-container">
						<p>Friend Request</p>
						<img src="/w3images/avatar6.png" alt="Avatar" style="width: 50%"><br>
						<span>Jane Doe</span>
						<div class="w3-row w3-opacity">
							<div class="w3-half">
								<button class="w3-button w3-block w3-green w3-section"
									title="Accept">
									<i class="fa fa-check"></i>
								</button>
							</div>
							<div class="w3-half">
								<button class="w3-button w3-block w3-red w3-section"
									title="Decline">
									<i class="fa fa-remove"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<br>

				<!-- Ads -->
				<div class="w3-card-2 w3-round w3-white w3-padding-16 w3-center">
					<p>ADS</p>
				</div>
				<br>
			</div>
</html>
