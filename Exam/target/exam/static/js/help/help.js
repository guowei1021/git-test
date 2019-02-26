$(function(){
	//加班帮助文档
	$(".overtime-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="overtime-help">'+
			  '<div class="am-modal-dialog" style="width:100%;height:100%;background:#fff;">'+
			    '<div class="am-modal-hd" style="font-size:16px;">加班申请'+
			      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
			    '</div>'+
			    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
				     '<ol>'+
	                      '<li>加班申请最小单位为1小时;</li>'+
	                      '<li>加班申请的时间段必须为非工作时间；</li>'+
	                      '<li>当天的加班，晚上24点前都可以提交申请，但前一天的加班不可以提交申请；</li>'+
	                      '<li>考勤结果中记录的加班时长将根据加班申请和实际上下班签到时间来计算，其计算逻辑是两个时间段交叉的部分。如申请17点到19点加班，而实际下班签到是18点，将按照加班1小时计算;</li>'+
	                      '<li>考勤结果计算加班时间的单位是1小时，超过半小时的按照1小时处理，不足半小时的分钟将被舍去。</li>'+
		             '</ol>'+
		             '<div style="margin-top:20px;text-align:center;">'+
	                      '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
	                 '<div>'+
			    '</div>'+
			  '</div>'+
			'</div>'+
			'</div>')
	$(".overtime-help img").click(function(){$("#overtime-help").modal()})
	//出差帮助文档
	$(".trip-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="trip-help">'+
			  '<div class="am-modal-dialog" style="width:100%;background:#fff;">'+
			    '<div class="am-modal-hd" style="font-size:16px;">出差申请'+
			      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
			    '</div>'+
			    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
				     '<ol>'+
				     '<li>出差申请的时间最小单位是1天，申请以事为单位申请，一件事或一个任务提交一个申请，而非一趟出行；</li>'+
				     '<li>出差涉及到后期差旅票据报销、差旅补助等要求的，请走此出差申请，如果短期的（如半天）只是为了记考勤，可以提交“外出”申请；</li>'+
				     '<li>出差申请必须事前申请，事后不允许补申请。最迟当天（晚上24点前）可以请当天的出差，而前一天的已经不可以请了；</li>'+
				     '<li>出差申请领导审批通过后才会生效，但已产生的考勤结果不会当时就修改，审批通过后第二天才会将此申请涉及的考勤结果进行修改更新；</li>'+
				     '<li>出差申请只是作为考勤签到结果的预判条件，一旦后期有提交了的差旅报销单关联该出差申请，此出差申请将不作为预判因素，之前产生的预判考勤结果也都不再有效；</li>'+
				     '<li>出差申请日期的第一天和最后一天将暂时按照“出行日”处理，出行日的考勤结果都会显示为“出勤”；</li>'+
				     '<li>事后员工提交差旅报销申请并审批通过后，出差申请单的出差日期将不再起作用，“出行日”将以报销单中的交通出行信息和差旅补助日期的第一天和最后一天为准，“出差日”也已报销单中出差日期为准，此时会再次更新涉及的出差日期的考勤结果；</li>'+
				     '<li>申请单中“非工作时间”是指在出差期间不工作的时间，比如出差且休息的周末；</li>'+
				     '<li>申请单中“出差地”可选多个，将作为出差期间考勤签到地点核对的依据；</li>'+
				     '<li>申请单中“出差预算”只包含差旅费用（城市间交通费、室内交通费、住宿费、各类补助），该金额会作为后期报销费用的约束条件，不宜填写过少。</li>'+
		             '</ol>'+
		             '<div style="margin-top:20px;text-align:center;">'+
                     '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
                '<div>'+
			    '</div>'+
			  '</div>'+
			'</div>'+
			'</div>')
	$(".trip-help img").click(function(){$("#trip-help").modal()})
	//签到帮助文档		
	$(".sign-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="sign-help">'+
			  '<div class="am-modal-dialog" style="width:100%;background:#fff;">'+
			    '<div class="am-modal-hd" style="font-size:16px;">签到'+
			      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
			    '</div>'+
			    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
				     '<ol>'+
				     '<li>签到操作应遵循，实际开始工作前上班签到，工作结束后下班签到。非工作期间（如出差路途中）签到没有实际意义；</li>'+
				     '<li>签到分为上班签到和下班签到，完整的签到信息必须拥有正确时间和地点上班签到和下班签到，否则都会按照“缺勤”处理；</li>'+
				     '<li>签到时会记录员工当前的地点和时间，如发现签到时间地点不合适可更新签到，上班、下班签到都以最后一次签到为准；</li>'+
				     '<li>下班签到后，上班签到将不可再更新；</li>'+
				     '<li>请假期间，员工不要上下班签到，其考勤结果会在第二天自动按请假（根据请假类型来显示）记录考勤结果，如果是年休假或调休还会自动扣除其剩余的天数；</li>'+
				     '<li>申请外出后，公务外出期间不要签到。如果是外出半天，请在离开协会外出时签下班到，或外出回来到协会签上班到；</li>'+
				     '<li>请假期间、出差申请期间或外出申请期间，如果正常在办公区域上下班签到，将不会按请假、出差、外出处理，仍按照正常上班记录考勤；</li>'+
				     '<li>早上加班请在加班前在办公区域上班签到，下班签到仍按正常下班时间点操作；晚上加班，上班签到仍按正常上班时间点操作，加班结束后在办公区域下班签到。</li>'+
		             '</ol>'+
		             '<div style="margin-top:10px;text-align:center;">'+
		             '<img src="../static/images/sign.png">'+
		             '<div>'+
		             '<div style="margin-top:20px;text-align:center;">'+
                     '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
                '<div>'+
			    '</div>'+
			  '</div>'+
			'</div>'+
			'</div>')
	$(".sign-help img").click(function(){$("#sign-help").modal()})
	//考勤修改帮助文档		
	$(".revise-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="revise-help">'+
			  '<div class="am-modal-dialog" style="width:100%;height:100%;background:#fff;">'+
			    '<div class="am-modal-hd" style="font-size:16px;">考勤修改'+
			      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
			    '</div>'+
			    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
				     '<ol>'+
				     '<li>考勤修改申请的最小单位是半天；</li>'+
				     '<li>考勤修改流程除了需要直属领导审批外还需要人力资源部的审批，该申请除考勤结果与实际有偏差的情况外请慎用；</li>'+
				     '<li>考勤修改提交后，审批中和审批通过的时间段（半天）不能再此申请修改。</li>'+
		             '</ol>'+
		             '<div style="margin-top:20px;text-align:center;">'+
                     '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
                '<div>'+
			    '</div>'+
			  '</div>'+
			'</div>'+
			'</div>')
	$(".revise-help img").click(function(){$("#revise-help").modal()})
	var urls=window.location.href;
	var url=urls.split("&")[0];	   
	var flag=url.split("?")[1].split("=")[1];
	if(flag==1){
		//请假帮助文档		
		$(".leave-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="leave-help">'+
				  '<div class="am-modal-dialog" style="width:100%;background:#fff;">'+
				    '<div class="am-modal-hd" style="font-size:16px;">请假（外出）'+
				      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
				    '</div>'+
				    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
					     '<ol>'+
					     '<li>请休假最小单位为半天；</li>'+
					     '<li>请休假必须事前申请，事后不允许补申请。最迟当天（晚上24点前）可以请当天的假，而前一天的假已经不可以请了；</li>'+
					     '<li>请假领导审批通过后才会生效，但已产生的考勤结果不会当时就修改，审批通过后第二天才会将此申请涉及的考勤结果进行修改更新；</li>'+
					     '<li>请假期间，员工不要上下班签到，其考勤结果会在第二天自动按请假（根据请假类型来显示）记录考勤结果；</li>'+
					     '<li>已经批准过的申请不允许修改和撤销，如果申请假期的日期又不准备休了，请在当天按时上下班签到，其考勤结果将会按照正常出勤处理；</li>'+
					     '<li>已经批准过的申请，如果申请假期的类型不对，请再提交一份正确类型的申请，同一时间（半天）后提交的请假类型会覆盖之前的申请。如果申请的日期不够，请再提交一个申请补充新增的日期；</li>'+
					     '<li>请年休假时，如果当前年假池中没有足够的年假可供休假，用户仍然可以提交申请，但系统将提醒用户到时候年假可能不够用，超出的部分将会按照“缺勤”处理；</li>'+
					     '<li>年假申请提交后，不会扣除其年假池中的剩余天数，但会记为“已请未休”，到实际请假那天未上下班签到后，第二天将按照“年假”记为考勤结果，年假池中的年假也会自动扣除1天（如果请的是1整天年假的话）；</li>'+
					     '<li>请年休假时，当前年假池中剩余天数可供此次申请，同时事前还提交过其他的年假申请，此时如果“申请天数>年假剩余天数-已请未休天数”，将提醒用户到时候年假可能不够用，超出的部分将会按照“缺勤”处理；</li>'+
					     '<li>请调休的时候，如果当前调休池中没有足够的调休可用，将不能提交申请。</li>'+
			             '</ol>'+
			             '<div style="margin-top:20px;text-align:center;">'+
	                     '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
	                '<div>'+
				    '</div>'+
				  '</div>'+
				'</div>'+
				'</div>')
		$(".leave-help img").click(function(){$("#leave-help").modal()})
	}else{
		//请假帮助文档		
		$(".leave-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="leave-help">'+
				  '<div class="am-modal-dialog" style="width:100%;background:#fff;">'+
				    '<div class="am-modal-hd" style="font-size:16px;">请假（外出）'+
				      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
				    '</div>'+
				    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
					     '<ol>'+
					     '<li>外出申请的时间最小单位是半天；</li>'+
					     '<li>外出申请必须事前申请，事后不允许补申请。最迟当天（晚上24点前）可以提交当天的外出，而前一天的已经不可以申请了；</li>'+
					     '<li>外出申请领导审批通过后才会生效，但已产生的考勤结果不会当时就修改，审批通过后第二天才会将此申请涉及的考勤结果进行修改更新；</li>'+
					     '<li>申请外出后，公务外出期间不要签到。如果是外出半天，请在离开协会外出时签下班到，或外出回来到协会签上班到。</li>'+
			             '</ol>'+
			             '<div style="margin-top:20px;text-align:center;">'+
	                     '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
	                '<div>'+
				    '</div>'+
				  '</div>'+
				'</div>'+
				'</div>')
		$(".leave-help img").click(function(){$("#leave-help").modal()})
	}
	
	//差旅报销帮助文档
	 $(".business-help").append('<div class="am-modal am-modal-no-btn" tabindex="-1" id="business-help">'+
			  '<div class="am-modal-dialog" style="width:100%;height:100%;background:#fff;">'+
			    '<div class="am-modal-hd" style="font-size:16px;">差旅费报销单'+
			      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
			    '</div>'+
			    '<div class="am-modal-bd" style="text-align:left;font-size:14px;">'+
				     '<ol>'+
				     '<li>差旅报销申请是为了出差过后确认出差实际日期、申请出差相关补助、报销相关票据提供依据；</li>'+
				     '<li>未提交差旅报销申请之前，出差申请作为考勤签到结果的预判条件，一旦后期有提交了的差旅报销单关联该出差申请，此出差申请将不作为预判因素，之前产生的预判考勤结果也都不再有效；</li>'+
		             '</ol>'+
		             '<div style="margin-top:20px;text-align:center;">'+
                     '<button data-am-modal-close style="width:70px;height:30px;line-height:30px;text-align:center;background:#2d7bbd;color:#fff;border:none;border-radius:5px;">关&nbsp;&nbsp;&nbsp;闭</button>'+
                '<div>'+
			    '</div>'+
			  '</div>'+
			'</div>'+
			'</div>')
	$(".business-help img").click(function(){$("#business-help").modal()})
})  




var getParam = function (name) {
    var search = document.location.search;
    //alert(search);
    var pattern = new RegExp("[?&]" + name + "\=([^&]+)", "g");
    var matcher = pattern.exec(search);
    var items = null;
    if (null != matcher) {
        try {
            items = decodeURIComponent(decodeURIComponent(matcher[1]));
        } catch (e) {
            try {
                items = decodeURIComponent(matcher[1]);
            } catch (e) {
                items = matcher[1];
            }
        }
    }
    return items;
};