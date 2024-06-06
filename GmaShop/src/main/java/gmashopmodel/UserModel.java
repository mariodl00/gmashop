package gmashopmodel;

public class UserModel {
	private int id;
	private String name;
	private String email;
	private String password;
	private int usersType;
	
	public UserModel() {
	
	}

	public UserModel(int id, String name, String email, String password, int usersType) {
	
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.usersType= usersType;
	}

	public int getUsersType() {
		return usersType;
	}

	public void setUsersType(int usersType) {
		this.usersType = usersType;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
}
