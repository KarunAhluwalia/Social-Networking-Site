package edu.iu.club.connect.controller;

import edu.iu.club.connect.model.GroupMembersModel;
import edu.iu.club.connect.model.GroupModel;
import edu.iu.club.connect.model.PostModel;
import edu.iu.club.connect.model.RequestModel;
import edu.iu.club.connect.model.UserModel;
import edu.iu.club.connect.service.serviceInterface.GroupService;
import edu.iu.club.connect.service.serviceInterface.JoinRequestService;
import edu.iu.club.connect.service.serviceInterface.PostService;
import edu.iu.club.connect.service.serviceInterface.UserService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;


/**
 * Created by walia on 2/19/2017.
 */

@Controller
@SessionAttributes ({"admin_id" , "group" , "groupSearched" , "myGroups" ,"myFriends"})

public class GroupController {

	
	@Autowired
	PostService postService;

	@Autowired
	GroupService groupService;

	@Autowired
	UserService userService;
	
	@Autowired
	JoinRequestService joinRequestService;
	
	@RequestMapping(value = "/createGroup")
	public String creategroup(){
		return "group";
	}
	
	
	
	@RequestMapping(value = "/groupPage/{groupId}/{userId}" , method = RequestMethod.GET)
	public ModelAndView openGroupPage(@PathVariable("groupId") int groupId, @PathVariable("userId") int userId , ModelMap modelMap, PostModel postModel){
		ModelAndView mv=new ModelAndView("groupsProfile");
		List<GroupMembersModel> alreadyFriend = joinRequestService.isAlreadyJoined(userId , groupId);
		List<GroupMembersModel> groupmembers = joinRequestService.groupMembers( groupId);
    	postModel.setGroupId(groupId);
    	List<PostModel> ps= postService.search(postModel);
    	if (ps.size()>10){
    	ps.subList(10,ps.size()).clear(); 	
    	}
    	boolean isadmin=groupService.isadmin(userId, groupId);
    	List<UserModel> userList=new ArrayList<UserModel>();
    	for (GroupMembersModel gp:groupmembers){
    		 userList.add(userService.listUserName(gp.getUserId()));
    	}
		List<RequestModel> requestModel = joinRequestService.findAllRequests(userId);
		mv.addObject("friendRequests", requestModel);
    	mv.addObject("isadmin", isadmin);
       	mv.addObject("ps",ps); 
       	mv.addObject("membersList",userList);
    	mv.addObject("groupmember",alreadyFriend);
		GroupModel group = groupService.findGroup(groupId);
		String clubstartdate=(group.getClubstartdate()).toString();
		clubstartdate=clubstartdate.substring(0,10);
		mv.addObject("clubstartdate",clubstartdate);
		mv.addObject("groupSearched", group);
		return mv;
	}
	
		@RequestMapping(value = "/groupInformation/{admin_id}",method = RequestMethod.POST)
	public String createGroup(@PathVariable("admin_id") int admin_id , GroupModel groupModel){
	//vishi
		Date date=new  Date();
		
		groupModel.setClubstartdate(date);
		///vishi end -also import date
		groupModel.setAdminId(admin_id);
		groupModel.setType("group");
		groupService.saveOne(groupModel);
		
		return "redirect:/profile";
	}
	///vishi start
	@RequestMapping(value = "/editGroupDetails/{userId}",method = RequestMethod.POST)
	public String editGroup(@PathVariable("userId") int userId, GroupModel groupModel){		
		groupService.updateOne(groupModel);
		int groupId=groupModel.getGroupId();
		
		return "redirect:/groupPage/"+groupId+"/"+userId;
	}
	
	@RequestMapping(value = "/yourGroups/{adminId}", method = RequestMethod.GET)
	public String seeYourGroups(@PathVariable("adminId") int adminId , ModelMap modelMap){
		
		List<GroupModel> myGroups = groupService.findAllGroupsById(adminId);
		modelMap.put("myGroups", myGroups);
		
		return "MyGroups";
	}
	
	@RequestMapping(value = "/friends/{userId}", method = RequestMethod.GET)
	public String myFriends(@PathVariable("userId") int userId , ModelMap modelMap){
		
		List<UserModel> myFriends = groupService.MyFriends(userId);
		modelMap.put("myFriends", myFriends);
		return "MyFriends";
	}




}
