<jsp:include page="header.jsp" />
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="wrap">
    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px;">
        <div>
            <div style="font-size: 20px; font-weight: 700; letter-spacing: -.3px;">Dashboard</div>
            <div class="txt-sm txt-2">Browse trips or create your own</div>
        </div>
        <a href="${pageContext.request.contextPath}/trip/create" class="btn btn-brand">New Trip</a>
    </div>

    <c:choose>
        <c:when test="${empty allTrips}">
            <div class="card">
                <div class="empty">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="color: var(--text-3); margin-bottom: 8px;"><path d="M17.8 19.2 16 11l3.5-3.5C21 6 21.5 4 21 3c-1-.5-3 0-4.5 1.5L13 8 4.8 6.2c-.5-.1-.9.1-1.1.5l-.3.5c-.2.4-.1.9.3 1.1l5.5 3.3-3.7 3.7-2-.7c-.4-.1-.7 0-.9.3l-.2.4c-.2.3-.1.7.2.9l3.1 2 2 3.1c.2.3.6.4.9.2l.4-.2c.3-.2.4-.6.3-.9L9.1 16l3.7-3.7 3.3 5.5c.2.4.7.5 1.1.3l.5-.3c.4-.2.6-.6.5-1.1Z"/></svg>
                    <div class="fw-700 mb-4">No trips yet</div>
                    <div class="txt-sm txt-muted mb-16">Be the first to create a trip!</div>
                    <a href="${pageContext.request.contextPath}/trip/create" class="btn btn-brand">Create a trip</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid-3">
                <c:forEach var="trip" items="${allTrips}">
                    <div class="card trip-card" onclick="window.location.href='${pageContext.request.contextPath}/trip/${trip.id}'">
                        <div class="trip-card-accent"></div>
                        <div class="trip-card-body">
                            <div class="trip-card-meta">
                                <span class="tag type-${trip.tripType.toLowerCase()}">${trip.tripType.replace('_', ' ')}</span>
                                <span class="tag ${trip.status == 'ACTIVE' ? 'tag-green' : 'tag-amber'}">${trip.status}</span>
                            </div>
                            <div class="trip-card-title">${trip.title}</div>
                            <div class="trip-card-route">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                                <c:if test="${not empty trip.origin}">${trip.origin} &rarr; </c:if>${trip.destination}
                            </div>
                            <div class="trip-card-footer">
                                <span>${trip.creatorName}</span>
                                <span>${trip.participantCount} member<c:if test="${trip.participantCount != 1}">s</c:if> &middot; ${trip.startDate}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body></html>
