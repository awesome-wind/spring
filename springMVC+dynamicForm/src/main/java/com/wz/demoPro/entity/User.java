package com.wz.demoPro.entity;



import javax.persistence.*;

import java.util.List;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;

    private String name;

    private String job;

    @Column(length = 11)
    private String phone;

    private String address;

//    @JsonIgnore
    @OneToMany(mappedBy = "userById",cascade = CascadeType.ALL,fetch = FetchType.EAGER)//
//    @ElementCollection cascade=CascadeType.ALL,fetch=FetchType.LAZY
    private List<Work> worksById;

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

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }



    public List<Work> getWorksById() {
        return worksById;
    }

    public void setWorksById(List<Work> worksById) {
        this.worksById = worksById;
    }
}
