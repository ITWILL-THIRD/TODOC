<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
 	<link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />   
	<%--<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원 멤버십</title>
	<jsp:include page="../../css/payCss.jsp"/>     
	<jsp:include page="../../css/commonCss.jsp"/>
	<jsp:include page="../common/navigation.jsp"/>
	<jsp:include page="../../css/membershipCss.jsp"/>
    <!-- 결제위젯 SDK 추가 -->
    <script src="https://js.tosspayments.com/v1/payment-widget"></script> 
  </head>

  <body>
    <!-- 주문서 영역 -->
    <div class="wrapper">
      <div class="box_section" style="padding: 40px 30px 50px 30px; margin-top: 30px; margin-bottom: 50px">
      <!-- 멘트 -->
      	<div class="mtitle">토닥토닥 멤버십</div>
		<div class="center"> 한 달에 단 1000원으로 집에서 예약할 수 있어요</div>
      	<div class="umdiv">
		    <div>
		    </div>
		    <div>
		        <img src="https://i.ibb.co/BfnCRZ4/3d-casual-life-happy-man-with-laptop-showing-ok-hand-sign.png" alt="예약" border="0">
		    </div>
		</div>
		<c:choose>
			<c:when test="${isNotMember}">
		        <!-- 결제 UI -->
		        <div id="payment-method" class="checkable typography--p" style="padding-left: 25px">
		        </div>
		        <!-- 이용약관 UI -->
		        <div id="agreement"></div>
		        <!-- 쿠폰 체크박스
		        <div class="checkable typography--p" style="padding-left: 25px">
		          <label for="coupon-box" class="checkable__label typography--regular"
		            ><input id="coupon-box" class="checkable__input" type="checkbox" aria-checked="true" /><span class="checkable__label-text">5,000원 쿠폰 적용</span></label>
		        </div> -->
		        <!-- 결제하기 버튼 -->
		        <button class="button" id="payment-button" style="margin-top: 30px" disabled>결제하기</button>
		      	</div>
	    		</div>
			</c:when>
			
			<c:when test="${isMember}">
		        	이미	멤버십 회원입니다.
		    </c:when>
			
		</c:choose>	
    <script>
      const button = document.getElementById("payment-button");
      const coupon = document.getElementById("coupon-box");
      const generateRandomString = () => window.btoa(Math.random()).slice(0, 20);
      var amount = 1000;
      
      // ------  결제위젯 초기화 ------
      // TODO: clientKey는 개발자센터의 결제위젯 연동 키 > 클라이언트 키로 바꾸세요.
      // TODO: 구매자의 고유 아이디를 불러와서 customerKey로 설정하세요. 이메일・전화번호와 같이 유추가 가능한 값은 안전하지 않습니다.
      // @docs https://docs.tosspayments.com/reference/widget-sdk#sdk-설치-및-초기화
      const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
      const customerKey = generateRandomString();
      const paymentWidget = PaymentWidget(clientKey, customerKey); // 회원 결제
      // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS); // 비회원 결제

      // ------  결제 UI 렌더링 ------
      // @docs https://docs.tosspayments.com/reference/widget-sdk#renderpaymentmethods선택자-결제-금액-옵션
      paymentMethodWidget = paymentWidget.renderPaymentMethods(
        "#payment-method",
        { value: amount },
        // 렌더링하고 싶은 결제 UI의 variantKey
        // 결제 수단 및 스타일이 다른 멀티 UI를 직접 만들고 싶다면 계약이 필요해요.
        // @docs https://docs.tosspayments.com/guides/payment-widget/admin#멀티-결제-ui
        { variantKey: "DEFAULT" }
      );
      // ------  이용약관 UI 렌더링 ------
      // @docs https://docs.tosspayments.com/reference/widget-sdk#renderagreement선택자-옵션
      paymentWidget.renderAgreement("#agreement", { variantKey: "AGREEMENT" });

      //  ------  결제 UI 렌더링 완료 이벤트 ------
      paymentMethodWidget.on("ready", function () {
        button.disabled = false;
//       coupon.disabled = false;
      });

      // ------  결제 금액 업데이트 ------
      //@docs https://docs.tosspayments.com/reference/widget-sdk#updateamount결제-금액
//      coupon.addEventListener("change", function () {
//        if (coupon.checked) {
//          paymentMethodWidget.updateAmount(amount - 5000);
//        } else {
//          paymentMethodWidget.updateAmount(amount);
//        }
//      });

      // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
      // @docs https://docs.tosspayments.com/reference/widget-sdk#requestpayment결제-정보
      button.addEventListener("click", function () {
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
        paymentWidget.requestPayment({
          orderId: generateRandomString(),
          orderName: "토닥 회원 멤버십",
          successUrl: "http://localhost:8080/todoc/membership/usersuccess.do",
          failUrl: "http://localhost:8080/todoc/membership/userfail.do",
          customerEmail: "customer123@gmail.com",
          customerName: "김토스",
          customerMobilePhone: "01012345678",
        });
      });
    </script>
  </body>
</html>