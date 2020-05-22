package ${packageName}.manager;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;

public class PermissionTrans {
	
	public List<String> getPermissions(JSONObject permissionJson) {
		List<String> permissionList = new ArrayList<String>();
		String permission = (String) permissionJson.get("part")+"-";
		int permission8421 = (int) permissionJson.get("permission");
		switch(permission8421) {
		case 0:
			permissionList=null;
			break;
		case 1:
			permissionList.add(permission+"d");
			break;
		case 2:
			permissionList.add(permission+"u");
			break;
		case 3:
			permissionList.add(permission+"u");
			permissionList.add(permission+"d");
			break;
		case 4:
			permissionList.add(permission+"r");
			break;
		case 5:
			permissionList.add(permission+"r");
			permissionList.add(permission+"d");
			break;
		case 6:
			permissionList.add(permission+"r");
			permissionList.add(permission+"u");
			break;
		case 7:
			permissionList.add(permission+"r");
			permissionList.add(permission+"u");
			permissionList.add(permission+"d");
			break;
		case 8:
			permissionList.add(permission+"c");
			break;
		case 9:
			permissionList.add(permission+"c");
			permissionList.add(permission+"d");
			break;
		case 10:
			permissionList.add(permission+"c");
			permissionList.add(permission+"u");
			break;
		case 11:
			permissionList.add(permission+"c");
			permissionList.add(permission+"u");
			permissionList.add(permission+"d");
			break;
		case 12:
			permissionList.add(permission+"c");
			permissionList.add(permission+"r");
			break;
		case 13:
			permissionList.add(permission+"c");
			permissionList.add(permission+"r");
			permissionList.add(permission+"d");
			break;
		case 14:
			permissionList.add(permission+"c");
			permissionList.add(permission+"r");
			permissionList.add(permission+"u");
			break;
		case 15:
			permissionList.add(permission+"c");
			permissionList.add(permission+"r");
			permissionList.add(permission+"u");
			permissionList.add(permission+"d");
			break;
		}		
		return permissionList;
	}

}
