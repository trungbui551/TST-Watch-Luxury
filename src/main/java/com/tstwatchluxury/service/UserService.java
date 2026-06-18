package com.tstwatchluxury.service;

import java.util.List;


import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.Role;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.VerificationToken;
import com.tstwatchluxury.domain.dto.RegisterDTO;
import com.tstwatchluxury.repository.RoleRepository;
import com.tstwatchluxury.repository.UserRepository;
import com.tstwatchluxury.repository.VerificationTokenRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService implements IUserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private VerificationTokenRepository tokenRepository;


    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            VerificationTokenRepository tokenRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.tokenRepository = tokenRepository;
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

    public void deleteAnUser(long id) {
        this.userRepository.deleteById(id);
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
