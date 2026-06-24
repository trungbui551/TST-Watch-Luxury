package com.tstwatchluxury.service;

import org.springframework.stereotype.Service;
import com.tstwatchluxury.domain.Review;
import com.tstwatchluxury.repository.ReviewRepository;
import java.util.List;

@Service
public class ReviewService {
    
    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public List<Review> getReviewsByProductId(long productId) {
        return this.reviewRepository.findByProductIdOrderByCreatedAtDesc(productId);
    }

    public Review saveReview(Review review) {
        return this.reviewRepository.save(review);
    }
}
