package com.wt.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wt.bean.Role;
import com.wt.serviceimp.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
@Autowired
private RoleService roleService;
@RequestMapping("/rolelist")
public String getRoleList(HttpServletRequest request){
	List<Role>roleList=roleService.getRoleList();
	request.setAttribute("roleList", roleList);
	return "/rolequery";
}
}
