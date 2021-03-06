package edu.iu.club.connect.model;
//vishi
import java.util.Date;

import javax.persistence.*;

/**
 * Created by walia on 2/19/2017.
 */

@Entity
@Table (name = "groups")
public class GroupModel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "groupsSequence")
    @SequenceGenerator(name ="groupsSequence",sequenceName = "groups_group_id_seq",allocationSize = 1)
    private @Column(name = "group_id")  Integer groupId;
    private @Column(name = "group_name") String groupName; //used in search feature
    private @Column(name = "group_about") String about;
    private @Column(name = "admin_id") Integer adminId;
    private @Column(name = "profile_pic") String profilePic;
    private @Column(name = "background_pic") String backgroundPic;
    private @Column(name = "type") String type;
    ///vishi
    private @Column(name = "clublocation") String clubclocation;
    private @Column(name = "clubemail") String clubemail;
    private @Column(name = "clubstartdate") Date clubstartdate;
   
    public String getClubclocation() {
		return clubclocation;
	}

	public void setClubclocation(String clubclocation) {
		this.clubclocation = clubclocation;
	}

	public String getClubemail() {
		return clubemail;
	}

	public void setClubemail(String clubemail) {
		this.clubemail = clubemail;
	}

	public Date getClubstartdate() {
		return clubstartdate;
	}

	public void setClubstartdate(Date clubstartdate) {
		this.clubstartdate = clubstartdate;
	}
///vishi
    public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}

	public String getBackgroundPic() {
		return backgroundPic;
	}

	public void setBackgroundPic(String backgroundPic) {
		this.backgroundPic = backgroundPic;
	}

	

  

	public Integer getAdminId() {
		return adminId;
	}

	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }


}
