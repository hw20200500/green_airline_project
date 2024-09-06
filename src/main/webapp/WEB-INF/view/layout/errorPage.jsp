<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.error--wrapper .err--tit:before {
	content: '';
	display: inline-block;
	width: 74px;
	height: 74px;
	margin-bottom: 20px;
	background: url(/images/errorIcon.png) 0 0 no-repeat;
}

.error--wrapper {
	margin: 100px 0 120px;
	text-align: center;
}

.error--wrapper .err--tit {
	font-size: 28px;
	line-height: 37px;
	margin-bottom: 60px;
}

.error--wrapper .error--cont .infobox {
	background: #f7f7f7;
	padding: 40px;
	border-radius: 5px;
}

.error--wrapper .error--cont .btn--wrap2 {
	margin-top: 40px;
}

.btn--M {
	padding: 11px 30px;
	font-size: 15px;
	min-height: 46px;
	line-height: 17px;
	text-align: center;
}

button {
	cursor: pointer;
}

button.blue {
	background-color: #7CB2D5;
	padding: 10px 12px 4px 15px;
	border: none;
	border-radius: 5px;
	color: white;
	font-size: 19px;
}

.error--wrapper.flcase .error_cont {
	width: 100%;
}

.error--wrapper .error--cont {
	width: 740px;
	margin: 0 auto;
}
</style>
<main>

	<div class="container">
		<div class="error--wrapper flcase">
			<div class="err--tit">
				<p>
					서비스 이용에 불편을 드려 죄송합니다. <br> 일시적인 오류가 발생했습니다.
				</p>

				<p>
					We apologize for any inconvenience. <br> A temporary error.
				</p>

				<p>
					サービスをご利用されるお客様にはご迷惑をおかけしております。 <br> 一時的にエラーが発生しました。
				</p>

				<p>
					给您使用带来的不便，我们深表歉意。 <br> 网页暂时无法连接。
				</p>

				<p>
					很抱歉，造成您的不便。 <br> 發生錯誤。
				</p>

				<p>
					Приносим извинения за доставленные неудобства. <br> Временная ошибка.
				</p>

				<p>
					Wir entschuldigen uns für entstandene Unannehmlichkeiten. <br> Vorübergehender Fehler.
				</p>

				<p>
					Nous vous prions de nous excuser pour la gêne occasionnée. <br> Une erreur momentanée.
				</p>

				<p>
					Sentimos las molestias causadas. <br> Un error temporal.
				</p>

			</div>
			<div class="error--cont">
				<div class="infobox">
					<p>
						서비스 처리과정에서 문제가 발생하여 이용이 원활하지 않습니다. <br> 잠시 후, 다시 이용해주시기 바랍니다.
					</p>

					<p>
						An error has occurred. <br> Please try again later.
					</p>

					<p>
						サービスの処理過程でトラブルが発生したため、円滑にご利用いただけません。 <br> しばらくしてから再度ご利用ください。
					</p>

					<p>
						服务处理过程中出现异常，暂无法使用。 <br> 请稍后重新尝试。
					</p>

					<p>
						很抱歉，造成您的不便。 <br> 發生錯誤。
					</p>

					<p>
						Произошел сбой. <br> Повторите попытку позднее.
					</p>

					<p>
						Ein Fehler ist aufgetreten. <br> Bitte versuchen Sie es später erneut.
					</p>

					<p>
						Une erreur s’est produite. <br> Veuillez réessayer plus tard.
					</p>

					<p>
						Se ha producido un error. <br> Inténtelo de nuevo más tarde o pregunte en el centro de atención al cliente.
					</p>

				</div>
				<div class="btn--wrap2">
					<button type="button" class="btn--M blue" onclick="location.href='/'">Green Airlines Home</button>
				</div>
			</div>
		</div>
	</div>

</main>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
