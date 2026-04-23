<jsp:include page="header.jsp" />

<div class="wrap-sm auth">
    <div class="card card-pad-lg">
        <h2>Create your account</h2>
        <p class="sub">Join NIET Trips and start coordinating travel</p>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="field">
                <label>Full Name</label>
                <input type="text" name="fullName" placeholder="e.g. Rahul Kumar" required autofocus>
            </div>
            <div class="field">
                <label>Username</label>
                <input type="text" name="username" placeholder="Pick a username" required>
            </div>
            <div class="field">
                <label>Password</label>
                <input type="password" name="password" placeholder="Create a password" required>
            </div>
            <button type="submit" class="btn btn-brand btn-block btn-lg mt-8">Create account</button>
        </form>
        <hr class="sep">
        <p class="txt-c txt-sm txt-muted">Already have an account? <a href="${pageContext.request.contextPath}/login">Log in</a></p>
    </div>
</div>

</body></html>
