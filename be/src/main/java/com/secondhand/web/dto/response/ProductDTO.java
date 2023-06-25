package com.secondhand.web.dto.response;

import com.secondhand.domain.product.CountInfo;
import com.secondhand.domain.product.Status;

public class ProductDTO {
    private Long productId;
    private String title;
    private TownResponse town;
    private Status status;
    private Long price;
    private CountInfo countInfo;
    private String imgUrl;
}
