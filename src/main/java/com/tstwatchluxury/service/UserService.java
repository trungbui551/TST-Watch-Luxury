package com.tstwatchluxury.service;

import java.util.List;


import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.CartDetail;
import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.Role;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.VerificationToken;
import com.tstwatchluxury.domain.dto.RegisterDTO;
import com.tstwatchluxury.repository.CartDetailRepository;
import com.tstwatchluxury.repository.CartRepository;
import com.tstwatchluxury.repository.OrderRepository;
import com.tstwatchluxury.repository.ReviewRepository;
import com.tstwatchluxury.repository.RoleRepository;
import com.tstwatchluxury.repository.UserRepository;
import com.tstwatchluxury.repository.VerificationTokenRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService implements IUserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final VerificationTokenRepository tokenRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final ReviewRepository reviewRepository;


    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            VerificationTokenRepository tokenRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, OrderRepository orderRepository,
            ReviewRepository reviewRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.tokenRepository = tokenRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.orderRepository = orderRepository;
        this.reviewRepository = reviewRepository;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }


    public User getUsersByID(long Id) {
        return this.userRepository.findById(Id);
    }

    public User handleSaveUser(User user) {
        User newUser = this.userRepository.save(user);
        return newUser;
    }

    @Transactional
    public void deleteAnUser(long id) {
        User user = this.userRepository.findById(id);
        if (user != null) {
            // 1. Delete VerificationToken if exists
            VerificationToken token = this.tokenRepository.findByUser(user);
            if (token != null) {
                this.tokenRepository.delete(token);
            }

            // 2. Delete Cart and CartDetails if exists
            Cart cart = this.cartRepository.findByUser(user);
            if (cart != null) {
                List<CartDetail> cartDetails = this.cartDetailRepository.findByCart(cart);
                if (cartDetails != null && !cartDetails.isEmpty()) {
                    this.cartDetailRepository.deleteAll(cartDetails);
                }
                this.cartRepository.delete(cart);
            }

            // 3. Disassociate Orders (set user to null)
            List<Order> orders = this.orderRepository.findByUser(user);
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
                    order.setUser(null);
                }
                this.orderRepository.saveAll(orders);
            }

            // 4. Disassociate Reviews (set user to null)
            this.reviewRepository.disassociateUser(user);

            // 5. Delete the User
            this.userRepository.delete(user);
        }
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassWord((registerDTO.getPassword()));
        return user;
    }

    public boolean checkExistsEmail(String Email) {
        return this.userRepository.existsByEmail(Email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findOneByEmail(email);
    }



    @Override
    public User getUser(String verificationToken) {
        User user = tokenRepository.findByToken(verificationToken).getUser();
        return user;
    }

    @Override
    public VerificationToken getVerificationToken(String VerificationToken) {
        return tokenRepository.findByToken(VerificationToken);
    }

    @Override
    public void saveRegisteredUser(User user) {
        userRepository.save(user);
    }

    @Override
    @Transactional
    public void createVerificationToken(User user, String token) {
        VerificationToken existingToken = tokenRepository.findByUser(user);

        if (existingToken != null) {
            existingToken.upDate(token);
            this.tokenRepository.save(existingToken);
        } else {
            // Nếu chưa có, tạo một token mới
            VerificationToken myToken = new VerificationToken(token, user);
            tokenRepository.save(myToken);
        }
    }

}
