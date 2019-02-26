//时间毫秒值转日期格式
function getzf(num) {
	if (parseInt(num) < 10) {
		num = '0' + num;
	}
	return num;
}

function getMyDate(str) {
	var oDate = new Date(str),
		oYear = oDate.getFullYear(),
		oMonth = oDate.getMonth() + 1,
		oDay = oDate.getDate(),
		oHour = oDate.getHours(),
		oMin = oDate.getMinutes(),
		oSen = oDate.getSeconds(),
		oTime = oYear + '-' + getzf(oMonth) + '-' + getzf(oDay) + ' ' + getzf(oHour) + ':' + getzf(oMin); //最后拼接时间  
	return oTime;
}