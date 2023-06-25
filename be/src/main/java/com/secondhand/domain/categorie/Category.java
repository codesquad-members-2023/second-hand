package com.secondhand.domain.categorie;

import lombok.Getter;

import javax.persistence.*;

@Entity
@Getter
public class Category {
    @Id
    @Column(name = "category_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 45, nullable = false)
    private String name;

    @Column(name = "img_url", length = 200, nullable = false)
    private String imgUrl;

    @Column(length = 300, nullable = false)
    private String placeholder;
}
