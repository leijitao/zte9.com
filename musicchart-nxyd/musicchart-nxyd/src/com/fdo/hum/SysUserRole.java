package com.fdo.hum;

/**
 * SysUserRole entity. @author MyEclipse Persistence Tools
 */

public class SysUserRole implements java.io.Serializable {

	// Fields

	private SysUserRoleId id;

	// Constructors

	/** default constructor */
	public SysUserRole() {
	}

	/** full constructor */
	public SysUserRole(SysUserRoleId id) {
		this.id = id;
	}

	// Property accessors

	public SysUserRoleId getId() {
		return this.id;
	}

	public void setId(SysUserRoleId id) {
		this.id = id;
	}

}