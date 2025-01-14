<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Friends</title>
<t:base>
<script defer type="text/javascript" src="/js/tabs.js"></script>
<!--  Live Search -->
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script defer src="/js/searchBar.js"></script> 

<div id="username-page" class="fade-in d-flex align-items-center styled-text text-white">
    <div class="container username-page-container text-center pt-5 pb-3 vh-100">
        <div class="row pt-5">
            <h3>Add Friends</h3>

            <div class="d-flex justify-content-center">
            	<div class="input-group px-4 pb-4 pt-3 w-md-75 w-lg-50">
                	<input type="text" class="form-control rounded live-search-box regular" placeholder="Search Users" aria-label="Search Users"
                   		aria-describedby="search-addon" />
                	<button type="button" class="btn btn-primary"><i class="bi bi-search"></i></button>
            	</div>
            </div>
			
            <div class="tab-form">
                <div class="tab-header mb-4">
                    <div class="active">Your Friends</div>
                    <div>Other Users</div>
                    <div>Pending</div>
                </div>
                <div class="tab-body">
                    <div class="friends active">
                        <div class="d-flex justify-content-center">
                            <ul class="list-group users w-100 w-md-75 w-lg-50">
                                <!-- <c:forEach var="user" items="${users}">
                                    <c:choose>
                                        <c:when
                                            test="${user.id != loggedInUser.id && (loggedInUser.friendingUsers.contains(user) || loggedInUser.friendedUsers.contains(user))}">
                                            <li class="list-group-item live-search-list rounded mb-1 mx-3 mx-sm-0">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="username ps-1">${user.nickname}
                                                        (<small><em>@${user.username}</em></small>)</div>
                                                    <div class="d-flex justify-content-end align-items-center gap-1">
                                                        <form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection">
                                                            <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${user.id}">
                                                            <button type="submit" class="user-submit btn">Chat</button>
                                                        </form>
                                                        <form action="/users/removeConnect" method="post">
                                                            <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${user.id}">
                                                            <input class="btn btn-secondary" type="submit" value="Undo">
                                                        </form>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach> -->
                                <c:forEach var="friendship" items="${approvedFriendships}">
                                    <li class="list-group-item live-search-list rounded mb-1 mx-3 mx-sm-0">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <!-- TODO: this could be simplified using approvedFriends -->
                                            <c:choose>
                                                <c:when test="${friendship.user.id == loggedInUser.id}">
                                                    <div class="username ps-1">${friendship.friend.nickname}
                                                        (<small><em>@${friendship.friend.username}</em></small>)</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="username ps-1">${friendship.user.nickname}
                                                        (<small><em>@${friendship.user.username}</em></small>)</div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="d-flex justify-content-end align-items-center gap-1">
                                                <form action="/chatrooms/private/enter" method="post" name="privateChatForm" class="chatroomSelection">
                                                    <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                    <c:choose>
                                                        <c:when test="${friendship.user.id == loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${friendship.friend.id}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="hidden" name="userId" value="${friendship.user.id}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button type="submit" class="user-submit btn">Chat</button>
                                                </form>
                                                <form action="/users/removeConnect" method="post">
                                                    <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                    <c:choose>
                                                        <c:when test="${friendship.user.id == loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${friendship.friend.id}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="hidden" name="userId" value="${friendship.user.id}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <input class="btn btn-secondary" type="submit" value="Undo">
                                                </form>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
            
                    <div class="otherUsers">
                        <div class="d-flex justify-content-center">
                            <ul class="list-group users w-100 w-md-75 w-lg-50">
                                <c:forEach var="user" items="${users}">
                                    <c:choose>
                                        <c:when
                                            test="${user.id != loggedInUser.id && !(loggedInUser.friendingUsers.contains(user) || (loggedInUser.friendedUsers.contains(user)))}">
                                            <li class="list-group-item live-search-list rounded mb-1 mx-3 mx-sm-0">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="username ps-1">${user.nickname}
                                                        (<small><em>@${user.username}</em></small>)</div>
                                                    <div class="d-flex justify-content-end align-items-center gap-1">
                                                        <form action="/users/pendingConnect" method="post">
                                                            <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${user.id}">
                                                            <input class="user-submit btn" type="submit" value="Connect">
                                                        </form>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>


                    <div class="Pending">
                        <div class="d-flex justify-content-center">
                            <ul class="list-group users w-100 w-md-75 w-lg-50">
                                <!-- For all Pending Requests -->
                                Friend Requests <hr/>
                                <!-- TODO: show the number of pending requests and none if there is none-->
                                <c:forEach var="friendship" items="${pendingFriendships}">
                                    <c:choose>
                                        <c:when test="${friendship.user.id != loggedInUser.id}">
                                            <li class="list-group-item live-search-list rounded mb-1 mx-3 mx-sm-0">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="username ps-1">${friendship.user.nickname}
                                                        (<small><em>@${friendship.user.username}</em></small>)</div>
                                                    <div class="d-flex justify-content-end align-items-center gap-1"> 
                                                        <form action="/users/approveConnect" method="post">
                                                            <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${friendship.user.id}">
                                                            <input class="user-submit btn" type="submit" value="Confirm">
                                                        </form>
                                                        <form action="/users/removeConnect" method="post">
                                                            <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                            <input type="hidden" name="userId" value="${friendship.user.id}">
                                                            <input class="btn btn-secondary" type="submit" value="Delete">
                                                        </form>
                                                    </div>
                                                </div>
                                                

                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>

                                <!-- For all Pending Requests -->
                                <span class="mt-2">Your Pending Requests</span>

                                <hr />
                                <!-- TODO: show the number of pending requests and none if there is none-->
                                <c:forEach var="friendship" items="${pendingFriendships}">
                                    <c:choose>
                                        <c:when test="${friendship.user.id == loggedInUser.id}">
                                            <li class="list-group-item live-search-list rounded mb-1 mx-3 mx-sm-0">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="username ps-1">${friendship.friend.nickname}
                                                        (<small><em>@${friendship.friend.username}</em></small>)</div>
                                                    <form action="/users/removeConnect" method="post">
                                                        <input type="hidden" name="loggedInUserId" value="${loggedInUser.id}">
                                                        <input type="hidden" name="userId" value="${friendship.friend.id}">
                                                        <input class="btn btn-secondary" type="submit" value="Pending">
                                                    </form>
                                                </div>
                                            </li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</t:base>