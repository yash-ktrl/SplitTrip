<jsp:include page="header.jsp" />

<div class="wrap-md mt-24">
    <div class="card card-pad-lg">
        <div style="font-size: 18px; font-weight: 700; margin-bottom: 4px;">Create a trip</div>
        <div class="txt-sm txt-muted mb-20">Leisure getaway, daily carpool, college transport — anything goes.</div>

        <form action="${pageContext.request.contextPath}/trip/create" method="post">
            <div class="field">
                <label>Trip Title</label>
                <input type="text" name="title" required placeholder="e.g. Daily Carpool — Noida to NIET">
            </div>

            <div class="field">
                <label>Trip Type</label>
                <select name="tripType" required>
                    <option value="LEISURE">Leisure / Vacation</option>
                    <option value="COMMUTE">Daily Commute / Carpool</option>
                    <option value="COLLEGE_TRANSPORT">College Transport (Home ↔ Campus)</option>
                    <option value="WEEKEND">Weekend Trip</option>
                    <option value="OTHER">Other</option>
                </select>
            </div>

            <div class="field-row">
                <div class="field">
                    <label>From (Origin)</label>
                    <input type="text" name="origin" placeholder="e.g. Sector 62, Noida">
                </div>
                <div class="field">
                    <label>To (Destination)</label>
                    <input type="text" name="destination" required placeholder="e.g. NIET Campus, Greater Noida">
                </div>
            </div>

            <div class="field-row">
                <div class="field">
                    <label>Start Date</label>
                    <input type="date" name="startDate" required>
                </div>
                <div class="field">
                    <label>End Date</label>
                    <input type="date" name="endDate" required>
                </div>
            </div>

            <div class="field">
                <label>Description</label>
                <textarea name="description" placeholder="Tell people what this trip is about, timings, pickup points, etc."></textarea>
            </div>

            <div class="field">
                <label>Hotel / Stay Details (optional)</label>
                <input type="text" name="hotelDetails" placeholder="e.g. Taj Resort, North Goa">
            </div>

            <div class="field">
                <label>Activities (optional)</label>
                <input type="text" name="activities" placeholder="e.g. Trekking, Scuba Diving">
            </div>

            <button type="submit" class="btn btn-brand btn-block btn-lg mt-8">Create trip</button>
        </form>
    </div>
</div>

</body></html>
