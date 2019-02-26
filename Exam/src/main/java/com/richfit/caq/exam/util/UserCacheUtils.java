package com.richfit.caq.exam.util;
import com.richfit.caq.comm.exception.BusinessException;

/**
 * 工具类：获取redis中缓存的用户数据
 * @author XueMancang (If you want to change this class, please contact me first!)
 */
public class UserCacheUtils {
	/**
	 * 获取当前登录人登录名
	 * @return
	 * @throws BusinessException
	 */
	public static String getUserLoginName() throws BusinessException {
/*		String loginName = UserUtils.getLoginName();
		if(loginName==null || loginName==""){
			throw new BusinessException("已离线，请重新登陆！");
		}
		return "loginName";*/
		return "tangl";
	}
	
	/**
	 * 获取当前登录人用户id
	 * @return
	 * @throws BusinessException
	 */
	public static String getUserId() throws BusinessException {
/*		String UserId = UserUtils.getUser().getId();
		if(UserId==null || UserId==""){
			throw new BusinessException("已离线，请重新登陆！");
		}
		return UserId;*/
		return "b1dfd5b5ef9a4cb4a269c4c753a08c71";
	}
	
	/**
	 * 获取当前登录人员工姓名
	 * @return
	 * @throws BusinessException
	 */
	public static String getUserEmployeeName() {
/*		String employeeName = UserUtils.getEmployeeName();
		return employeeName;*/
		return "汤黎";
	}
	
	/**
	 * 获取当前登录人员工ucode
	 * @return
	 * @throws BusinessException
	 */
	public static String getUserEmployeeUcode() {
		/*		String employeeUcode = UserUtils.getEmployeeUcode();
		return employeeUcode;*/
		return "574146a9d4fc41b1a6f45ec20380d502";
	}
	
}
