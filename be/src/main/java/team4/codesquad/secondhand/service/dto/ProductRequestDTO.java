package team4.codesquad.secondhand.service.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;


import javax.validation.constraints.NotBlank;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ProductRequestDTO {
    @NotBlank(message = "제목을 입력해주세요")
    private String title;
    private Integer price;
    @NotBlank(message = "내용을 입력해주세요")
    private String contents;
    private List<String> productImages;
    private int categoryId;
    private int locationId;

}
