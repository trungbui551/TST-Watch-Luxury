package com.tstwatchluxury.service;

import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.VerificationToken;

public interface IUserService {

    User getUser(String verificationToken);

    void saveRegisteredUser(User user);

    void createVerificationToken(User user, String token);

    VerificationToken getVerificationToken(String VerificationToken);
}
