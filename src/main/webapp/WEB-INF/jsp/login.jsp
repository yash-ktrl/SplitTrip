<jsp:include page="header.jsp" />

<div class="wrap-sm auth">
    <div class="card card-pad-lg">
        <h2>Welcome back</h2>
        <p class="sub">Log in to your NIET Trips account</p>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="field">
                <label>Username</label>
                <input type="text" name="username" placeholder="e.g. alice" required autofocus>
            </div>
            <div class="field">
                <label>Password</label>
                <input type="password" name="password" placeholder="Your password" required>
            </div>
            <button type="submit" class="btn btn-brand btn-block btn-lg mt-8">Log in</button>
        </form>
        <hr class="sep">
        <p class="txt-c txt-sm txt-muted">No account? <a href="${pageContext.request.contextPath}/register">Create one</a></p>
    </div>
</div>

</body></html>
