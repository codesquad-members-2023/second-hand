package team4.codesquad.secondhand.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import team4.codesquad.secondhand.domain.Product;
import team4.codesquad.secondhand.domain.User;
import team4.codesquad.secondhand.domain.dto.ProductDTO;
import team4.codesquad.secondhand.domain.dto.ProductDetailDTO;
import team4.codesquad.secondhand.domain.dto.ProductListDTO;
import team4.codesquad.secondhand.repository.ProductRepository;
import team4.codesquad.secondhand.repository.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public ProductListDTO buildProductListDTO() {
        List<Product> products = productRepository.findAll();
        return new ProductListDTO(products.stream()
                                    .map(ProductDTO::new)
                                    .collect(Collectors.toList()));
    }

    public ProductDetailDTO findById(Integer productId){
        Product product = productRepository.findByIdWithRelatedFields(productId);
        return new ProductDetailDTO(product);
    }

}
