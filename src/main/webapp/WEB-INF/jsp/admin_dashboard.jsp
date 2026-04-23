<jsp:include page="header.jsp" />
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="wrap">
    <div style="font-size: 20px; font-weight: 700; letter-spacing: -.3px; margin-bottom: 20px;">Admin Dashboard</div>

    <div class="grid-2 mb-20">
        <div class="card card-pad">
            <div class="txt-xs fw-700 txt-muted mb-12" style="text-transform: uppercase; letter-spacing: .4px;">Users</div>
            <table class="tbl">
                <thead><tr><th>Name</th><th>Username</th><th>Role</th></tr></thead>
                <tbody>
                    <c:forEach var="u" items="${usersList}">
                        <tr>
                            <td class="fw-600">${u.full_name}</td>
                            <td class="txt-2">${u.username}</td>
                            <td><span class="tag ${u.role == 'ADMIN' ? 'tag-red' : 'tag-brand'}">${u.role}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="card card-pad">
            <div class="txt-xs fw-700 txt-muted mb-12" style="text-transform: uppercase; letter-spacing: .4px;">Trips</div>
            <table class="tbl">
                <thead><tr><th>Trip</th><th>Type</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="trip" items="${allTrips}">
                        <tr>
                            <td class="fw-600"><a href="${pageContext.request.contextPath}/trip/${trip.id}">${trip.title}</a></td>
                            <td><span class="tag type-${trip.tripType.toLowerCase()}">${trip.tripType.replace('_', ' ')}</span></td>
                            <td><span class="tag ${trip.status == 'ACTIVE' ? 'tag-green' : 'tag-amber'}">${trip.status}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card card-pad">
        <div class="txt-xs fw-700 txt-muted mb-12" style="text-transform: uppercase; letter-spacing: .4px;">All Expenses</div>
        <table class="tbl">
            <thead><tr><th>Trip</th><th>Paid by</th><th>Category</th><th class="txt-r">Amount</th></tr></thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty globalExpenses}"><tr><td colspan="4" class="txt-c txt-muted" style="padding: 24px;">No expenses.</td></tr></c:when>
                    <c:otherwise>
                        <c:forEach var="e" items="${globalExpenses}">
                            <tr>
                                <td class="fw-600">${e.trip_title}</td>
                                <td>${e.paid_by}</td>
                                <td><span class="tag tag-default">${e.category}</span></td>
                                <td class="txt-r fw-700">&#8377;${e.amount}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

</body></html>
