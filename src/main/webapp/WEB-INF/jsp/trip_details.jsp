<jsp:include page="header.jsp" />
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div class="wrap">
    <!-- HEADER -->
    <div class="card mb-20" style="overflow: visible;">
        <div class="card-pad-lg" style="border-bottom: 1px solid var(--border);">
            <div style="display: flex; align-items: start; justify-content: space-between; gap: 20px;">
                <div style="flex: 1;">
                    <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 6px;">
                        <span class="tag type-${trip.tripType.toLowerCase()}">${trip.tripType.replace('_', ' ')}</span>
                        <span class="tag ${trip.status == 'ACTIVE' ? 'tag-green' : 'tag-amber'}">${trip.status}</span>
                    </div>
                    <div style="font-size: 22px; font-weight: 700; letter-spacing: -.3px; margin-bottom: 4px;">${trip.title}</div>
                    <div class="txt-sm txt-2" style="display: flex; align-items: center; gap: 6px;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                        <c:if test="${not empty trip.origin}">${trip.origin} &rarr; </c:if>${trip.destination}
                        &middot; ${trip.startDate} to ${trip.endDate}
                        &middot; by ${trip.creatorName}
                    </div>
                    <c:if test="${not empty trip.description}">
                        <div class="txt-sm txt-2 mt-8" style="line-height: 1.6;">${trip.description}</div>
                    </c:if>
                </div>
                <c:if test="${not empty sessionScope.user and !isParticipant}">
                    <form action="${pageContext.request.contextPath}/trip/${trip.id}/join" method="post">
                        <button type="submit" class="btn btn-brand btn-lg">Apply to join</button>
                    </form>
                </c:if>
            </div>
        </div>
        <c:if test="${not empty trip.hotelDetails or not empty trip.activities}">
            <div class="card-pad" style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                <c:if test="${not empty trip.hotelDetails}">
                    <div><div class="txt-xs txt-muted fw-600 mb-4" style="text-transform: uppercase; letter-spacing: .4px;">Stay</div><div class="txt-sm fw-600">${trip.hotelDetails}</div></div>
                </c:if>
                <c:if test="${not empty trip.activities}">
                    <div><div class="txt-xs txt-muted fw-600 mb-4" style="text-transform: uppercase; letter-spacing: .4px;">Activities</div><div class="txt-sm fw-600">${trip.activities}</div></div>
                </c:if>
            </div>
        </c:if>
    </div>

    <div class="detail-layout">
        <!-- LEFT -->
        <div>
            <div class="card card-pad mb-16">
                <div class="sec">
                    <div class="sec-icon" style="background: var(--brand-bg); color: var(--brand);">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                    </div>
                    <div class="sec-title">Participants (${trip.participantCount})</div>
                </div>
                <c:forEach var="p" items="${participants}">
                    <div class="member">
                        <div class="member-left">
                            <div class="member-av">${p.username.substring(0,1).toUpperCase()}</div>
                            <div>
                                <div class="member-name">${p.username}</div>
                                <c:if test="${p.userId == trip.creatorId}"><div class="member-sub">Organizer</div></c:if>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${p.status == 'APPROVED'}"><span class="tag tag-green">Joined</span></c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${isCreator}">
                                        <form action="${pageContext.request.contextPath}/trip/${trip.id}/approve" method="post"><input type="hidden" name="userId" value="${p.userId}"><button type="submit" class="btn btn-green btn-sm">Approve</button></form>
                                    </c:when>
                                    <c:otherwise><span class="tag tag-amber">Pending</span></c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>

            <!-- NOTES -->
            <div class="card card-pad">
                <div class="sec">
                    <div class="sec-icon" style="background: var(--amber-bg); color: var(--amber);">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                    </div>
                    <div class="sec-title">Notes & Updates</div>
                </div>
                <c:if test="${isApproved}">
                    <form action="${pageContext.request.contextPath}/trip/${trip.id}/note" method="post" style="margin-bottom: 12px;">
                        <div class="field" style="margin-bottom: 8px;">
                            <textarea name="content" rows="2" placeholder="Post an update..." style="font-size: 13px;"></textarea>
                        </div>
                        <button type="submit" class="btn btn-outline btn-sm">Post</button>
                    </form>
                </c:if>
                <c:choose>
                    <c:when test="${empty notes}"><div class="txt-sm txt-muted">No notes yet.</div></c:when>
                    <c:otherwise>
                        <c:forEach var="n" items="${notes}">
                            <div class="note">
                                <div class="note-head">
                                    <span class="note-author">${n.username}</span>
                                    <span class="note-time"><fmt:formatDate value="${n.createdAt}" pattern="MMM d, h:mm a" /></span>
                                </div>
                                <div class="note-body">${n.content}</div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- RIGHT -->
        <div>
            <div class="stats">
                <div class="stat">
                    <div class="stat-num" style="color: var(--text);">&#8377;<fmt:formatNumber value="${totalExpense}" type="number" minFractionDigits="0" maxFractionDigits="0" /></div>
                    <div class="stat-lbl">Total Spent</div>
                </div>
                <div class="stat">
                    <div class="stat-num" style="color: var(--brand);">&#8377;<fmt:formatNumber value="${perPerson != null ? perPerson : 0}" type="number" minFractionDigits="0" maxFractionDigits="0" /></div>
                    <div class="stat-lbl">Per Person</div>
                </div>
                <div class="stat">
                    <div class="stat-num" style="color: var(--text-2);">${trip.participantCount}</div>
                    <div class="stat-lbl">Members</div>
                </div>
            </div>

            <!-- BILL SPLIT -->
            <div class="card card-pad mb-16">
                <div class="sec">
                    <div class="sec-icon" style="background: var(--green-bg); color: var(--green);">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
                    </div>
                    <div class="sec-title">Bill Split</div>
                </div>
                <c:choose>
                    <c:when test="${empty balances}"><div class="txt-sm txt-muted">Add expenses to see the split.</div></c:when>
                    <c:otherwise>
                        <div class="grid-2">
                            <c:forEach var="entry" items="${balances}">
                                <div class="bal ${entry.value < 0 ? 'bal-owes' : (entry.value > 0 ? 'bal-gets' : 'bal-ok')}">
                                    <div style="display: flex; align-items: center; gap: 8px;">
                                        <div class="member-av" style="width: 28px; height: 28px; font-size: 11px;">
                                            <c:forEach var="p" items="${participants}"><c:if test="${p.userId == entry.key}">${p.username.substring(0,1).toUpperCase()}</c:if></c:forEach>
                                        </div>
                                        <span class="txt-sm fw-600"><c:forEach var="p" items="${participants}"><c:if test="${p.userId == entry.key}">${p.username}</c:if></c:forEach></span>
                                    </div>
                                    <div class="txt-r">
                                        <c:choose>
                                            <c:when test="${entry.value < 0}">
                                                <div class="txt-sm fw-700" style="color: var(--red);">Owes &#8377;<fmt:formatNumber value="${-entry.value}" type="number" minFractionDigits="2" /></div>
                                                <c:if test="${sessionScope.user.id == entry.key}">
                                                    <a href="${pageContext.request.contextPath}/trip/${trip.id}/pay?amount=${-entry.value}" class="btn btn-red btn-sm mt-4">Pay now</a>
                                                </c:if>
                                            </c:when>
                                            <c:when test="${entry.value > 0}">
                                                <div class="txt-sm fw-700" style="color: var(--green);">Gets &#8377;<fmt:formatNumber value="${entry.value}" type="number" minFractionDigits="2" /></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="txt-sm fw-700 txt-muted">Settled</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- EXPENSES -->
            <div class="card card-pad">
                <div class="sec">
                    <div class="sec-icon" style="background: var(--red-bg); color: var(--red);">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                    </div>
                    <div class="sec-title">Expenses</div>
                </div>
                <c:if test="${isApproved}">
                    <form action="${pageContext.request.contextPath}/trip/${trip.id}/expense/add" method="post" class="exp-form">
                        <div class="field" style="flex: 0 0 100px;">
                            <label>Amount</label>
                            <input type="number" name="amount" step="0.01" required placeholder="500">
                        </div>
                        <div class="field" style="flex: 0 0 120px;">
                            <label>Category</label>
                            <select name="category" required>
                                <option value="TRANSPORT">Transport</option>
                                <option value="FOOD">Food</option>
                                <option value="HOTEL">Hotel/Stay</option>
                                <option value="FUEL">Fuel</option>
                                <option value="TICKETS">Tickets</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="field" style="flex: 1;">
                            <label>Description</label>
                            <input type="text" name="description" required placeholder="What was it for?">
                        </div>
                        <button type="submit" class="btn btn-brand btn-sm" style="margin-bottom: 0;">Add</button>
                    </form>
                </c:if>
                <table class="tbl">
                    <thead><tr><th>Date</th><th>Description</th><th>Category</th><th>Paid by</th><th class="txt-r">Amount</th></tr></thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty expenses}"><tr><td colspan="5" class="txt-c txt-muted" style="padding: 24px;">No expenses yet.</td></tr></c:when>
                            <c:otherwise>
                                <c:forEach var="e" items="${expenses}">
                                    <tr>
                                        <td class="txt-muted"><fmt:formatDate value="${e.dateAdded}" pattern="MMM d" /></td>
                                        <td class="fw-600">${e.description}</td>
                                        <td><span class="tag tag-default">${e.category}</span></td>
                                        <td>${e.paidByName}</td>
                                        <td class="txt-r fw-700">&#8377;${e.amount}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body></html>
