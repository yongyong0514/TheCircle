
written by Yonggi Jeong<br>
reporting date 03.01.21

&nbsp;

![CIRCLE](/web/psd/circle.png)

### 중소기업을 위한 다양한 기능을 지원하는 그룹웨어 개발
### Development of ERP (enterprise resource planning) software that support small business

&nbsp;

## 개발환경 Environment
* JAVA 1.8
* Eclipse Oxygen 3
* Spring Framework 5.2.9
* Apache-Maven 3.6.3
* Oracle SQL Developer 18.3.0.277
* Apache-Tomcat 9.0
* JSP, JavaScript, jQuery, Json, Xml, Sql, HTML5, CSS, Ajax
* MyBatis
* DATAWARE DA#5

&nbsp;

## 링크 Link
### Notion Development Log https://www.notion.so/yongyong0514/Project_Circle-051afd18302a4608b01942588a3eec1f

### Figma UI https://www.figma.com/file/B1enCtQkGGS0FucyEQQV7e/Circle?node-id=0%3A1

&nbsp;

## 시연 영상 YouTube Clip
[![CIRCLE](https://img.youtube.com/vi/bitvKWigf6o/0.jpg)](https://www.youtube.com/watch?v=bitvKWigf6o&feature=emb_title)

&nbsp;

## 주요기능 Developed Functions
1. 회원가입 및 로그인, 동호회 커뮤니티 기능
<br>Sign-up, log-in and club pages

2. 전자결재 작성 및 편집, 조회, 파일 첨부 기능
<br>Create, edit, view and file attachment functions for electronic document approval process

3. 프로젝트 관리와 게시판 구현
<br>Project management and bulletin boards

4. 업무일정관리 캘린더와 설문조사 구현
<br>Project management and bulletin boards

5. 사원 주소록과 근태관리 설정
<br>Employee address book and vacation & absence status

&nbsp;

## DB 디자인 DataBase Design
![CIRCLEDB](/web/psd/circledb.png)

## 담당역할 및 기여도 Main Responsibilities in the Project
형상관리 - GitHub를 이용해 전체 프로젝트 형상관리를 수행했습니다.
<br>Responsible for software configuration management by using GitHub, main developer for electronic document approval system

* Figma를 활용한 전체 프로젝트 UI 설계 및 디자인
<br>Project User Interface (UI) Design by using Figma

* 전자결재 DB 및 UI 설계, CRUD 구현
<br>Development of CRUD for electronic document approval system and UI

* 문서관리 DB 및 설계, CRUD 구현
<br>Development of CRUD for document manager approval system and UI

&nbsp;

## 프로젝트 담당 주요 내용 Project Overview

### 등록된 전자결재 목록입니다. 결재 상태에 따라서 분류될 수 있습니다.
* 구현기능설명 
작성자와, 결재자, 참조자로 지정되면 나의 결재 목록에 결재가 나타나며, 진행 상태와 함께 남은 결재자와 결재자, 참조자를 미니 팝업으로 볼 수 있습니다.
진행 상황별로 분류된 결재 목록으로 왼쪽 메뉴바를 이용해 분류된 결재를 조회할 수 있으며, 게시글 목록을 페이징 처리해서 최대 9개씩 아래의 버튼으로 호출할 수 있습니다.
![F1](/web/psd/F1.jpg)

&nbsp;

### 전자결재 작성 화면입니다. 필드 값 입력과 결재자와 참조자를 선택합니다.
* 구현기능설명 
필드 값 입력을 체크합니다.
문서 유형을 선택해서 템플릿을 선택할 수 있으며 다수의 첨부파일 추가가 가능합니다.
TOAST UI MARKDOWN 편집기를 사용할 수 있습니다.
결재자와 참조자는 등록 버튼으로 구성원 목록에서 결재자, 참조자 목록으로 드래그해서 추가할 수 있으며, 중복되는 경우에는 알림이 발생합니다.
결재를 벗어나면 경고와 함께 모든 필드의 값과 세션이 삭제됩니다.
![F2](/web/psd/F2.jpg)

&nbsp;

### 작성한 전자결재의 화면입니다. 결재자로 등록되었을 경우 결재가 가능합니다
* 구현기능설명 
결재자는 활성화된 결재버튼으로 결재할 수 있습니다.
결재 승인 시 결재에 사용할 이미지를 설정하도록 전자결재 설정으로 이동합니다. 
결재 승인 시 남은 결재자 카운트가 감소하며, 상태는 대기-> 진행으로 변경되며 결재자가 없을 경우 완료처리 됩니다. 
반려처리시 결재는 중단되며, 작성자에게 수정할 수 있는 수정버튼이 활성화됩니다. 수정 후에는 다시 진행상태로 변경됩니다.
![F3](/web/psd/F3.jpg)

&nbsp;

### 전자결재 설정 페이지입니다. 결재에 사용할 이미지를 설정하기 위해 결재 화면에서 전자결재 설정으로 이동되어 결재용 이미지를 설정하고 있습니다.
* 구현기능설명&nbsp;
전자결재 설정 페이지에서는 사용자 전용으로 결재에 사용할 전자결재 이미지를 최대 5개까지 등록 가능하며 삭제할 수 있습니다.
필기 서명이 기본 서명으로 설정되어 이미지 삭제시에 기본 서명으로 대체됩니다(미구현).
전자결재 설정 페이지는 결재에 사용하는 문서 유형을 추가할 수 있습니다. 
![F4](/web/psd/F4.jpg)

&nbsp;

### 전자 결재의 한 건 화면입니다. 전자결재 서명 설정 후, 결재가 된 서명과 댓글입니다.
* 구현기능설명&nbsp;
결재화면에서 승인 시, 위의 슬라이드의 결재 이미지 목록이 뜨고 선택 시 승인 결재 처리됩니다.
본문 바로 아래 영역에 댓글 형식으로 결재 이미지가 추가되며, 동시에 결재자가 첫번째 결재자인 경우, 대기에서 진행상태로 변경되며, 남은 결재자 카운트가 감소합니다.
댓글은 Ajax로 비동기 목록 출력과 등록 처리되며, 본인만 삭제 가능합니다.
![F5](/web/psd/F5.jpg)

&nbsp;

### 전자 결재의 한 건을 수정하는 화면입니다. 반려 처리된 결재를 작성자가 수정하는 화면입니다.
* 구현기능설명&nbsp;
결재 버튼에서 반려 처리시, 한 건의 결재는 반려 처리되며 결재 참여자들은 결재를 할 수 없습니다. 
작성자에게 수정버튼이 활성화처리 됩니다.
모든 필드의 값을 수정할 수 있으며, 수정하기 버튼을 누르면 결재는 다시 진행 상태로 변경되어 결재 진행이 가능합니다. 모든 결재 진행상황은 데이터베이스에 결재 상태에 따른 진행상황이 기록됩니다.
![F6](/web/psd/F6.jpg)

&nbsp;

### 전자결재 설정 페이지입니다. 제목과 본문에 템플릿으로 출력할 데이터를 입력하는 화면입니다.
* 구현기능설명 
전자 결재를 작성할 때 선택하는 문서 유형을 만들 수 있습니다.
본문에 TOAST UI Editor를 이용해 MARKDOWN 형식으로 작성할 수 있으며, 해당 템플릿은 서버에 저장되어 다음 결재에서 문서 유형으로 선택 가능합니다. 
전자결재 양식 목록에서 삭제가 가능합니다.
![F7](/web/psd/F7.jpg)

&nbsp;

### 문서관리 페이지입니다. 최근 작성된 문서를 최대 5개까지 볼 수 있습니다.
* 구현기능설명&nbsp;
작성된 게시물의 문서 유형에 따라 개인용과 공용으로 나누어 표시됩니다.
최대 5개까지 표시되며, 최신순으로 업데이트 됩니다.
왼쪽 메뉴바를 이용해 분류된 문서 목록을 조회할 수 있으며 게시글 목록을 페이징 처리해서 최대 9개씩 하단 버튼을 이용해서 출력할 수 있습니다.
![F8](/web/psd/F8.jpg)

&nbsp;

### 문서관리 문서 작성 페이지입니다.
* 구현기능설명&nbsp;
보존 연한과 문서유형을 선택할 수 있으며 다중 파일 업로드 및 다운로드가 가능합니다.
TOAST UI Editor를 이용해서 본문을 작성할 수 있습니다.
문서 관리 페이지는 일반적인 게시판의 형태로 CRUD가 가능합니다.
게시물에 댓글 작성 및 삭제가 가능합니다.
![F9](/web/psd/F9.jpg)
