<%@ page import="teammates.common.Common"%>
<%@ page import="teammates.common.datatransfer.CourseAttributes"%>
<%@ page import="teammates.common.datatransfer.EvaluationDetailsBundle"%>
<%@ page import="teammates.common.datatransfer.SubmissionAttributes"%>
<%@ page import="teammates.ui.controller.InstructorEvalSubmissionViewHelper"%>
<%
	InstructorEvalSubmissionViewHelper helper = (InstructorEvalSubmissionViewHelper)request.getAttribute("helper");
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="/favicon.png">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teammates - Instructor</title>
	<link rel="stylesheet" href="/stylesheets/common.css" type="text/css" media="screen">
	<link rel="stylesheet" href="/stylesheets/instructorEvalSubmissionView.css" type="text/css" media="screen">
	<link rel="stylesheet" href="/stylesheets/common-print.css" type="text/css" media="print">
    <link rel="stylesheet" href="/stylesheets/instructorEvalSubmissionView-print.css" type="text/css" media="print">
	
	<script type="text/javascript" src="/js/googleAnalytics.js"></script>
	<script type="text/javascript" src="/js/jquery-minified.js"></script>
	<script type="text/javascript" src="/js/tooltip.js"></script>
	<script type="text/javascript" src="/js/date.js"></script>
	<script type="text/javascript" src="/js/CalendarPopup.js"></script>
	<script type="text/javascript" src="/js/AnchorPosition.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript" src="/js/instructor.js"></script>
    <jsp:include page="../enableJS.jsp"></jsp:include>
</head>

<body>
	<div id="dhtmltooltip"></div>
	<div id="frameTop">
		<jsp:include page="<%=Common.JSP_INSTRUCTOR_HEADER%>" />
	</div>

	<div id="frameBody">
		<div id="frameBodyWrapper">
			<div id="topOfPage"></div>
			<div id="headerOperation">
				<h1>View Student's Evaluation</h1>
			</div>
			
			<table class="inputTable" id="studentEvaluationInfo">
				<tr>
					<td class="label rightalign bold" width="30%">Course ID:</td>
					<td class="leftalign"><%=helper.evaluationResults.evaluation.courseId%></td>
				</tr>
				<tr>
					<td class="label rightalign bold" width="30%">Evaluation Name:</td>
					<td class="leftalign"><%=InstructorEvalSubmissionViewHelper.escapeForHTML(helper.evaluationResults.evaluation.name)%></td>
				</tr>
			</table>
			

			<%
							for(boolean byReviewee = true, repeat=true; repeat; repeat = byReviewee, byReviewee=false){
						%>
			<h2 class="centeralign"><%=InstructorEvalSubmissionViewHelper.escapeForHTML(helper.student.name) + (byReviewee ? "'s Result" : "'s Submission")%></h2>
			<table class="resultTable">
				<thead><tr>
					<th colspan="2" width="10%" class="bold leftalign">
						<span class="resultHeader"><%=byReviewee ? "Reviewee" : "Reviewer"%>: </span><%=helper.student.name%></th>
					<th class="bold leftalign"><span class="resultHeader"
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_CLAIMED%>')"
							onmouseout="hideddrivetip()">
						Claimed Contribution: </span><%=InstructorEvalSubmissionViewHelper.printSharePoints(helper.result.summary.claimedToInstructor,true)%></th>
					<th class="bold leftalign"><span class="resultHeader"
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_PERCEIVED%>')"
							onmouseout="hideddrivetip()">
						Perceived Contribution: </span><%=InstructorEvalSubmissionViewHelper.printSharePoints(helper.result.summary.perceivedToInstructor,true)%></th>
				</tr></thead>
				<tr>
					<td colspan="4"><span class="bold">Self evaluation:</span><br>
							<%=InstructorEvalSubmissionViewHelper.printJustification(helper.result.getSelfEvaluation())%></td>
					</tr>
				<tr>
					<td colspan="4"><span class="bold">Comments about team:</span><br>
							<%=InstructorEvalSubmissionViewHelper.escapeForHTML(helper.result.getSelfEvaluation().p2pFeedback.getValue())%></td>
					</tr>
				<tr class="resultSubheader">
					<td width="15%" class="bold"><%=byReviewee ? "From" : "To"%> Student</td>
					<td width="5%" class="bold">Contribution</td>
					<td width="40%" class="bold">Confidential comments</td>
					<td width="40%" class="bold">Feedback to peer</td>
				</tr>
				<%
					for(SubmissionAttributes sub: (byReviewee ? helper.result.incoming : helper.result.outgoing)){ if(sub.reviewer.equals(sub.reviewee)) continue;
				%>
					<tr>
						<td><b><%=InstructorEvalSubmissionViewHelper.escapeForHTML(byReviewee ? sub.details.reviewerName : sub.details.revieweeName)%></b></td>
						<td><%=InstructorEvalSubmissionViewHelper.printSharePoints(sub.details.normalizedToInstructor,false)%></td>
						<td><%=InstructorEvalSubmissionViewHelper.printJustification(sub)%></td>
						<td><%=InstructorEvalSubmissionViewHelper.formatP2PFeedback(InstructorEvalSubmissionViewHelper.escapeForHTML(sub.p2pFeedback.getValue()), helper.evaluationResults.evaluation.p2pEnabled)%></td>
					</tr>
				<%
					}
				%>
			</table>
			<br><br>
			<%
				}
			%>
			<div class="centeralign">
				<input type="button" class="button" id="button_back" value="Close"
						onclick="window.close()">
				<input type="button" class="button" id="button_edit" value="Edit Submission"
						onclick="window.location.href='<%=helper.getInstructorEvaluationSubmissionEditLink(helper.evaluationResults.evaluation.courseId, helper.evaluationResults.evaluation.name, helper.student.email)%>'">
			</div>
			<br>
			<br>
			<br>
	
		</div>
	</div>

	<div id="frameBottom">
		<jsp:include page="<%= Common.JSP_FOOTER %>" />
	</div>
</body>
</html>