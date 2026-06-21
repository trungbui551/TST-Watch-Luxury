package com.tstwatchluxury.controller.client;

import java.util.Calendar;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.VerificationToken;
import com.tstwatchluxury.domain.dto.RegisterDTO;
import com.tstwatchluxury.event.OnRegistrationCompleteEvent;
import com.tstwatchluxury.event.OnResetPasswordEvent;
import com.tstwatchluxury.service.IUserService;
import com.tstwatchluxury.service.UploadService;
import com.tstwatchluxury.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class ClientController {
    @Autowired
    private UserService userService;
    @Autowired
    private UploadService uploadService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private IUserService service;
    @Autowired
    private MessageSource messages;
    @Autowired
    ApplicationEventPublisher eventPublisher;

    // update information
    @GetMapping("/client/update/{id}")
    public String getUpdateInformationPage(Model model, @PathVariable long id) {
        User user = this.userService.getUsersByID(id);
        model.addAttribute("presentUser", user);
        return "client/update/information";
    }

    // nhan request va xu ly
    @PostMapping("/client/update")
    public String updateInformation(Model model, @ModelAttribute("presentUser") User user,
            @RequestParam("newimg") MultipartFile file, RedirectAttributes redirectAttributes) {

        User currentUser = this.userService.getUsersByID(user.getId());
        if (currentUser != null) {
            currentUser.setAddress(user.getAddress());
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());
            if (!file.isEmpty()) {
                String avatarFile = this.uploadService.handleSaverUploadFile(file, "avatar");
                currentUser.setAvatar(avatarFile);
            }

            System.out.println();
            this.userService.handleSaveUser(currentUser);
            redirectAttributes.addFlashAttribute("message", "cập nhật thành công!");
        }
        return "redirect:/";
    }

    @GetMapping("/resetPassword")
    public String getResetPasswordPage(@RequestParam("token") String token, Model model) {
        model.addAttribute("token", token);
        return "client/auth/resetPassword";
    }

    @PostMapping("/resetPassword")
    public String postMethodName(@RequestParam("token") String token,
            @RequestParam("password") String password,
            Model model) {
        String password1 = passwordEncoder.encode(password);
        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            return "redirect:/badUser"; // Token không hợp lệ
        }

        User user = verificationToken.getUser();
        if (user != null) {
            String encodedPassword = passwordEncoder.encode(password);
            User user1 = this.userService.getUserByEmail(user.getEmail());
            user1.setPassWord(encodedPassword);

            return "redirect:/login?resetSuccess";
        } else {
            return "redirect:/badUser";
        }
    }

    @GetMapping("/regitrationConfirm")
    public String confirmRegistration(WebRequest request, RedirectAttributes redirectAttributes, @RequestParam("token") String token) {

        Locale locale = request.getLocale();

        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            String message = messages.getMessage("auth.message.invalidToken", null, locale);
            redirectAttributes.addAttribute("message", message);
            return "redirect:/badUser?lang=" + locale.getLanguage();
        }

        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            String messageValue = messages.getMessage("auth.message.expired", null, locale);
            redirectAttributes.addAttribute("message", messageValue);
            return "redirect:/badUser?lang=" + locale.getLanguage();
        }

        user.setEnabled(true);
        service.saveRegisteredUser(user);
        return "redirect:/login?lang=" + request.getLocale().getLanguage();
    }

    // forgot password controller
    @GetMapping("/forgotPassword")
    public String getForgotPassWordController(Model model) {

        return "client/auth/fillEmail";
    }

    @PostMapping("/handle-password")
    public String getHandlePasswordPage(HttpServletRequest request, @RequestParam("username") String email,
            Model model) {

        boolean check = this.userService.checkExistsEmail(email);
        System.out.println("Email: " + email + " Check: \n" + check);
        if (check == false) {
            String error = "Tài khoản không tồn tại";
            model.addAttribute("error", error);
            return "redirect:/forgotPassword";
        }
        String appUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        User user = this.userService.getUserByEmail(email);
        eventPublisher.publishEvent(new OnResetPasswordEvent(user,
                request.getLocale(), appUrl));

        // Truyền thời điểm hết hạn (epoch ms) xuống view để JSP hiển thị đếm ngược
        // Token hiệu lực trong VerificationToken.EXPIRATION phút (hiện tại = 60*24 = 1440 phút)
        long expiryEpochMs = System.currentTimeMillis() + (long) VerificationToken.getExpiration() * 60 * 1000;
        model.addAttribute("tokenExpiryEpoch", expiryEpochMs);

        return "client/auth/emailCheck";
    }


    @GetMapping("/userConfirm")
    public String userConfirm(WebRequest request, RedirectAttributes redirectAttributes, @RequestParam("token") String token) {

        Locale locale = request.getLocale();

        VerificationToken verificationToken = service.getVerificationToken(token);
        if (verificationToken == null) {
            String message = messages.getMessage("auth.message.invalidToken", null, locale);
            redirectAttributes.addAttribute("message", message);
            System.out.println("------------------------------- NULL");
            return "redirect:/badUser?lang=" + locale.getLanguage();

        }

        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            String messageValue = messages.getMessage("auth.message.expired", null, locale);
            redirectAttributes.addAttribute("message", messageValue);
            System.out.println("------------------------------- Hết Hạn");
            return "redirect:/badUser?lang=" + locale.getLanguage();
        }
        return "redirect:/resetPassword?token=" + token;
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("newRegisterDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegiserPage(@ModelAttribute("newRegisterDTO") @Valid RegisterDTO it,
            BindingResult bindingResult, HttpServletRequest request) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        String password = this.passwordEncoder.encode(it.getPassword());
        User user = this.userService.registerDTOtoUser(it);
        user.setPassWord(password);
        user.setRole(this.userService.getRoleByName("USER"));
        user.setAddress("Chưa cập nhật");
        user.setPhone("chưa cập nhật");
        user.setEnabled(false);
        this.userService.handleSaveUser(user);

        String appUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user,
                request.getLocale(), appUrl));
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {

        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage() {
        return "client/auth/deny";
    }

    @GetMapping("/emailCheck")
    public String getEmailCheck() {
        return "client/auth/emailCheck";
    }

    @GetMapping("/badUser")
    public String getBadUser(@RequestParam(value = "message", required = false) String message, Model model) {
        model.addAttribute("message", message);
        return "client/auth/badUser";
    }
}
