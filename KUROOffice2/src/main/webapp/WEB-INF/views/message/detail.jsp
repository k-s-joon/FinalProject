<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="email-app">
	<div class="left-part" style="width: 200px; background-color: #D2E0F5;">
		<a
			class="ri-menu-fill ri-close-fill btn btn-success show-left-part d-block d-md-none"
			href="javascript:void(0)"></a>
		<div class="scrollable" style="height: 100%">
			<div class="p-3">
				<a id="compose_mail"
					class="waves-effect waves-light btn btn-danger d-block"
					style="background-color: #2962FF;" onclick="openPopup()">쪽지 보내기</a>
			</div>
			<div class="divider"></div>
			<ul class="list-group">
				<li class="list-group-item"><a href="/message/home"
					class="list-group-item-action d-flex align-items-center"> <i
						data-feather="inbox" class="feather-sm fill-white me-2"></i> 받은쪽지
				</a></li>
				<li class="list-group-item"><a href="/message/list2"
					class="list-group-item-action d-flex align-items-center"> <i
						data-feather="send" class="feather-sm fill-white me-2"></i> 보낸쪽지
				</a></li>
				<li class="list-group-item"><a href="/message/store"
					class="list-group-item-action"> <i data-feather="star"
						class="feather-sm fill-white me-2"></i> 보관쪽지
				</a></li>
			</ul>
		</div>
	</div>

	<div class="right-part mail-details bg-white overflow-auto"
		style="width: calc(100% - 200px); margin-left: 200px;">


		<div class="content"
			style="background-color: #E9ECEF; height: 1000px;">
			<div style="height: 30px;"></div>
			<div class="col-xl-6 col-lg-6"
				style="margin-left: 30%; border: 1px solid #6C757D;">
				<div class="card">
					<div class="card-header">
						<div class="mb-3 row">
							<label class="col-sm-3 col-form-label">보낸사람</label><span style="color: #050099;"><fmt:formatDate
					value="${messageVO.mesDate }" pattern="yyyy/MM/dd HH:mm:ss"></fmt:formatDate></span>
							<div style="display: flex;">
								<input type="text" id="myInput" class="form-control"
									name="empName" value="${empVO.empName }"
									style="ime-mode: disabled; width: 85%; margin-right: 5px;"
									placeholder="이름"
									value="<c:if test="${not empty empName }">${empVO.empName }</c:if>"
									readonly>

							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="basic-form">
							<div class="mb-3">
								<textarea class="form-txtarea form-control" rows="8"
									style="background-color: #FFFFFF; color: black;"
									id="mesContent" placeholder="${messageVO.mesContent }"
									name="mesContent" readonly></textarea>

							</div>
						</div>
						<div>
							<input type="button" class="btn btn-primary" value="답장"
								onclick="openPopup()" style="margin-left: 84%;">

						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
		function openPopup() {
			window.open("/message/write", "popup",
					"width=600, height=400, top=100, left=300");
		}
	</script>