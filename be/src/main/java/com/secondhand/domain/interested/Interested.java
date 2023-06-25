package com.secondhand.domain.interested;

import com.secondhand.domain.member.Member;
import com.secondhand.domain.product.Product;
import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@Table(name = "INTERESTED")
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Interested {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RECRUIT_CATEGORY_ID")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    private boolean isLiked;

    public static Interested create(Member member, Product product, boolean liked) {
        return Interested.builder()
                .product(product)
                .member(member)
                .isLiked(liked)
                .build();
    }
}
