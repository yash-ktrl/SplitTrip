<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NIET Trips</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script>
        (function(){var t=localStorage.getItem('theme');if(t)document.documentElement.setAttribute('data-theme',t);})();
    </script>
</head>
<body>
    <div class="nav">
        <div class="nav-inner">
            <a href="${pageContext.request.contextPath}/" class="nav-brand">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M17.8 19.2 16 11l3.5-3.5C21 6 21.5 4 21 3c-1-.5-3 0-4.5 1.5L13 8 4.8 6.2c-.5-.1-.9.1-1.1.5l-.3.5c-.2.4-.1.9.3 1.1l5.5 3.3-3.7 3.7-2-.7c-.4-.1-.7 0-.9.3l-.2.4c-.2.3-.1.7.2.9l3.1 2 2 3.1c.2.3.6.4.9.2l.4-.2c.3-.2.4-.6.3-.9L9.1 16l3.7-3.7 3.3 5.5c.2.4.7.5 1.1.3l.5-.3c.4-.2.6-.6.5-1.1Z"/></svg>
                <span>NIET Trips</span>
            </a>
            <div class="nav-right">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/" class="nav-link">Dashboard</a>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin" class="nav-link">Admin</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/trip/create" class="btn btn-brand btn-sm">New Trip</a>
                        <span class="nav-av">${sessionScope.user.username.substring(0,1).toUpperCase()}</span>
                        <span class="nav-name">${sessionScope.user.fullName != null ? sessionScope.user.fullName : sessionScope.user.username}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="nav-link">Log in</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-brand btn-sm">Sign up</a>
                    </c:otherwise>
                </c:choose>
                <button class="theme-btn" onclick="toggleTheme()" title="Toggle dark mode">
                    <svg class="icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>
                    <svg class="icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="5"/><line x1="12" y1="1" x2="12" y2="3"/><line x1="12" y1="21" x2="12" y2="23"/><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"/><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"/><line x1="1" y1="12" x2="3" y2="12"/><line x1="21" y1="12" x2="23" y2="12"/><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"/><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"/></svg>
                </button>
            </div>
        </div>
    </div>
    <c:if test="${not empty error}"><div class="wrap"><div class="alert alert-err">${error}</div></div></c:if>
    <c:if test="${not empty success}"><div class="wrap"><div class="alert alert-ok">${success}</div></div></c:if>
    <script>
        function toggleTheme(){var h=document.documentElement;var t=h.getAttribute('data-theme')==='dark'?'light':'dark';h.setAttribute('data-theme',t);localStorage.setItem('theme',t);}
    </script>
