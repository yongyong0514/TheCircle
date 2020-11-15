<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/schedule/fullcalendar/main.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.3.2/lib/moment.min.js'></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.3.2/lib/jquery.min.js'></script>
<script src="http://fullcalendar.io/js/fullcalendar-2.3.2/lib/jquery-ui.custom.min.js"></script>
<script src='http://fullcalendar.io/js/fullcalendar-2.3.2/fullcalendar.min.js'></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>       
<script src="${pageContext.request.contextPath}/resources/js/schedule/ko.js"></script>

      <script>
      
      		var base = "${pageContext.request.contextPath}";
      
      		//fullcalendar onload function
            $(function() {
            	var base = "${pageContext.request.contextPath}";
            	
            	//풀캘린더 로드
                $("#calendar").fullCalendar({
                	defaultView			: 'month',	//기본 뷰 설정
               	    header				: {
               	    						left	: 'today', // month/week뷰 변환 버튼
               	    						center	: 'prev, title, next',
               	    						right  	: 'month,agendaWeek,agendaDay'
               							    
               		},
               	 fixedWeekCount            : 'variable',
                	defaultDate			: moment(),//현재를 기준으로 생성
                	editable			: true,
                	eventLimit			: true,//이벤트 개수가 표시칸을 벗어나면 더보기 버튼 생성
            	 	dayClick			: function(date, jsEvent, view) {//날짜 클릭 기능 설정
            	 							//input 값 비우기
            	 							$('#edit-title').empty();
            	 							
            	 							//현재 시간 넣기
            	 							$('#edit-start').val(date.format());
            	 							$('#edit-end').val(date.format());
            	 							
            	 							//모달 띄우기
            	 							$('#add-eventModal').modal('show');
            	 							
            	 							//일정명에 오토포커스
            	 							$(".modal").on("shown.bs.modal", function () {
            	 								$('#edit-title').focus();
            	 							});

       				},
       				//event 클릭시 실행코드
                	eventClick			: function(event, jsEvent, view) {
                							$('#view-title').empty();
                							$('#view-start').empty();
                							$('#view-end').empty();
                		
                							$('#view-title').text(event.title);
                							$('#view-start').text(event.start.format('YYYY-MM-DD HH:mm'));
                							if(event.end != null) {
                								$('#view-end').text(event.end.format('YYYY-MM-DD HH:mm'));	
                							}; 
                							$('#eventModal').modal();
           			},
                	//이벤트 목록 불러오기
                 	events				: function(start, end, timezone, callback) {
                 								
						                    	$.ajax({
						                    		url			:base+"/schAjax/id",
						                    		type		:"get",
						                    		traditional : true,
						                    		data: {id 		: "200101090031"
						                    			  ,start	: start.format()
						                    			  ,end		: end.format() 
						                    		},
						                    		dataType:"json",
						                    		success:function(json){
						                    			
						        						events = [];
						        						$(json).each(function() {
						        							
						        							//true false 를 boolean 타입으로 변환
						        							var yn = true;
						        							
						        							if($(this).attr('allDay') == "false"){
						        								yn = false
						        							}
						        							
						        							//events 객체에 주입
						        							events.push({
						        								id	  			: $(this).attr('id'),
						        								title 			: $(this).attr('title'),
						        								start 			: $(this).attr('start'),
						        								end	  			: $(this).attr('end'),
						        								allDay			: yn,
						        								repeat 			: $(this).attr('repeat'),
						        								endRepeat 		: $(this).attr('endRepeat'),
						        								content			: $(this).attr('content'),
						        								security		: $(this).attr('security'),
						        								stat			: $(this).attr('stat'),
						        								writer 			: $(this).attr('writer'),
						        								writeDate		: $(this).attr('writeDate'),
						        								modifyDate		: $(this).attr('modifyDate'),
						        								backgroundColor	: $(this).attr('backgroundColor')
						        							});
						        						});
						        						
						        						//월, 년 변경되었거나 자료 변경에 따라 다시 불러오기
														callback(events);
														console.log(events)
						                    		}
                 							});
                 	},
                		
                });
            });
            
        //event insert script
        
        $(function () {
        	$.fn.serializeObject = function () {
                var o = {};
                this.find("[name]").each(function () {
                     o[this.name] = this.value;
                });
                return o;
            };
        	
            $('#save-event').on('click', function (e) {
                console.log("button click success");
                console.log($("form[name=insert-event]"))
                e.preventDefault();
                
                var insertEvent = $("form[name=insert-event]").serializeObject();
                console.log("object" + insertEvent);
                console.log(JSON.stringify(insertEvent));
                
                $.ajax({
                	type 		: 'post',
                	traditional : true,
                	url 		: base+"/schAjax/schInsert", 
                	data		: JSON.stringify(insertEvent),
                	dataType	: 'json',
                	contentType	:"application/json",
                	error		: function(error){
                		alert(error);
                	},
                	success		: function(insertEvent){
                		alert(insertEvent);
                	}
                })
                
            });

        });
        </script>


        
</head>
<body>
	<div id='datepicker'></div>
	<div id="calendar"></div>
		
	<!-- 간단 일정보기 MoDal -->	
    <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">
                    	<i class="icon modal-title-planner"></i>
                    	일정
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-title">일정명</label>
                            <span class="inputModal" id="view-title"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-start">시작</label>
                            <span class="inputModal" id="view-start" ></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-end">끝</label>
                            <span class="inputModal" id="view-end" ></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-type">구분</label>
                            <span class="inputModal" id="view-type">부서 일정</span>
                        </div>


                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-desc">설명</label>
                            <textarea rows="4" cols="50" class="inputModal" name="view-desc"
                                id="view-desc">주말 등산 회식</textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modalBtnContainer-viewEvent">
                    <button type="button" class="btn btn-primary" id="updateEvent">수정</button>
                    <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
    		
    <!-- 일정 추가 MODAL -->
    <div class="modal fade" tabindex="-1" role="dialog" id="add-eventModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">
                    	<i class="icon modal-title-planner"></i>
                    	일정
                    </h4>
                </div>
                <div class="modal-body">
                	<form method="post" name="insert-event">
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-title">일정명</label>
	                            <input class="inputModal" type="text" name="edit-title" id="edit-title"
	                                required="required" />
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-type">구분</label>
	                            <select class="inputModal" type="text" name="edit-type" id="edit-type">
	                                <option value="카테고리1">내 일정</option>
	                                <option value="카테고리2">부서 일정</option>
	                                <option value="카테고리3">프로젝트 일정</option>
	                                <option value="카테고리4">동호회 일정</option>
	                            </select>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-start">시작</label>
	                            <input class="inputModal" type="date" name="edit-start" id="edit-start" />
	                            <input type="time" class="inputModal select time" name="start-time" id="start-time"/>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-end">끝</label>
	                            <input class="inputModal" type="date" name="edit-end" id="edit-end" />
	                            <input type="time" class="inputModal select time" name="end-time" id="end-time"/>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-allDay">하루종일</label>
	                            <input class='allDayNewEvent' id="edit-allDay" type="checkbox" onchange='allDayCheck();'>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-color">색상</label>
	                            <select class="inputModal" name="color" id="edit-color">
	                                <option value="#000080" style="color:#000080;">남색</option>
	                                <option value="#0080ff" style="color:#0080ff;">바다색</option>
	                                <option value="#50bcdf" style="color:#50bcdf;">하늘색</option>
	                                <option value="#3e91b5" style="color:#3e91b5;">담청색</option>
	                                <option value="#4aa8d8" style="color:#4aa8d8;">밝은파랑</option>
	                                <option value="#437299" style="color:#437299;">셰필드 스틸</option>
	                                <option value="#5e7e9b" style="color:#5e7e9b;">아쿠아마린</option>
	                                <option value="#00498c" style="color:#00498c;">코발트블루</option>
	                                <option value="#003458" style="color:#003458;">프러시안블루</option>
	                            </select>
	                        </div>
	                    </div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <label class="col-xs-4" for="edit-desc">설명</label>
	                            <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
	                                id="edit-desc"></textarea>
	                        </div>
	                    </div>
                    </form>
                </div>
                <div class="modal-footer modalBtnContainer-addEvent">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary" id="save-event" name="save-event">저장</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
</div>

</body>
</html>