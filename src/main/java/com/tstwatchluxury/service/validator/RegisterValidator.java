package com.tstwatchluxury.service.validator;

import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.dto.RegisterDTO;
import com.tstwatchluxury.repository.UserRepository;
import com.tstwatchluxury.service.UserService;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;

    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;
        // Check if password fields match
        if (!user.getPassword().equals(user.getRepeatPassword())) {
            context.buildConstraintViolationWithTemplate("Mật khẩu không trùng khớp!")
                    .addPropertyNode("repeatPassword")
                    .addConstraintViolation().disableDefaultConstraintViolation();

            valid = false;
        }
        if (this.userService.checkExistsEmail(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại!")
                    .addPropertyNode("email")
                    .addConstraintViolation().disableDefaultConstraintViolation();

            valid = false;
        }
        return valid;

    }
}
