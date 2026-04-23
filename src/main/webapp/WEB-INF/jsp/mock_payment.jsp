<jsp:include page="header.jsp" />

<div class="wrap-sm mt-24">
    <div class="card pay-card">
        <div class="pay-head">
            <div class="pay-lbl">Amount due</div>
            <div class="pay-amt">&#8377;${amount}</div>
            <div class="pay-lbl mt-4">Settle your share of the trip expenses</div>
        </div>
        <div class="pay-body">
            <form action="${pageContext.request.contextPath}/trip/${tripId}/pay/process" method="post">
                <input type="hidden" name="amount" value="${amount}">
                <div class="field">
                    <label>Cardholder name</label>
                    <input type="text" required placeholder="Your full name">
                </div>
                <div class="field">
                    <label>Card number</label>
                    <input type="text" required placeholder="4242 4242 4242 4242" maxlength="19">
                </div>
                <div class="field-row">
                    <div class="field">
                        <label>Expiry</label>
                        <input type="text" required placeholder="MM / YY" maxlength="7">
                    </div>
                    <div class="field">
                        <label>CVV</label>
                        <input type="text" required placeholder="123" maxlength="4">
                    </div>
                </div>
                <button type="submit" class="btn btn-brand btn-block btn-lg mt-8">Pay &#8377;${amount}</button>
                <p class="txt-c txt-xs txt-muted mt-12">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: -1px;"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                    Simulated payment gateway for demo purposes
                </p>
            </form>
        </div>
    </div>
</div>

</body></html>
