<#include "base.ftl">

<#macro title>Register</#macro>

<#macro content>
    <script>
        $(document).on("click", "#register-button", function () {
            $(".is-invalid").removeClass("is-invalid")

            let avatarInput = $("#avatar-input")
            let firstNameInput = $("#first-name-input")
            let lastNameInput = $("#last-name-input")
            let emailInput = $("#email-input")
            let loginInput = $("#login-input")
            let passwordInput = $("#password-input")
            let confirmPasswordInput = $("#confirm-password-input")

            let formValid = true
            if (!firstNameInput.val()) {
                firstNameInput.addClass("is-invalid")
                formValid = false
            }
            if (!lastNameInput.val()) {
                lastNameInput.addClass("is-invalid")
                formValid = false
            }
            if (!emailInput.val()) {
                emailInput.addClass("is-invalid")
                $("#invalid-email-feedback").removeAttr("hidden")
                formValid = false
            } else {
                $("#invalid-email-feedback").attr("hidden", "true")
            }
            if (!loginInput.val()) {
                loginInput.addClass("is-invalid")
                $("#invalid-login-feedback").removeAttr("hidden")
                formValid = false
            } else {
                $("#invalid-login-feedback").attr("hidden", "true")
            }
            if (!passwordInput.val()) {
                passwordInput.addClass("is-invalid")
                formValid = false
            }
            if (confirmPasswordInput.val() !== passwordInput.val()) {
                confirmPasswordInput.addClass("is-invalid")
                formValid = false;
            }

            if (formValid) {
                $(this).attr("disabled", "true")
                $("#register-button-spinner").removeAttr("hidden")
                $("#register-button-text").text("Loading...")
                $("input").attr("disabled", "true")
                $("#unknown-error-alert").attr("hidden", "true")

                let formData = new FormData()
                formData.append("avatar", avatarInput[0].files[0])
                formData.append("firstName", firstNameInput.val())
                formData.append("lastName", lastNameInput.val())
                formData.append("email", emailInput.val())
                formData.append("login", loginInput.val())
                formData.append("password", passwordInput.val())
                formData.append("confirmPassword", confirmPasswordInput.val())

                $.ajax({
                    url: "${rc.getContextPath()}/register",
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response.success) {
                            window.location.replace("${rc.getContextPath()}/auth")
                        } else {
                            if ("avatar_too_big" in response) {
                                avatarInput.addClass("is-invalid")
                                $("#avatar-too-big-feedback").removeAttr("hidden")
                            } else {
                                $("#avatar-too-big-feedback").attr("hidden", "true")
                            }
                            if ("avatar_unsupported_format" in response) {
                                avatarInput.addClass("is-invalid")
                                $("#avatar-unsupported-format-feedback").removeAttr("hidden")
                            } else {
                                $("#avatar-unsupported-format-feedback").attr("hidden", "true")
                            }
                            if ("first_name_invalid" in response) {
                                firstNameInput.addClass("is-invalid")
                            }
                            if ("last_name_invalid" in response) {
                                lastNameInput.addClass("is-invalid")
                            }
                            if ("email_invalid" in response) {
                                emailInput.addClass("is-invalid")
                                $("#invalid-email-feedback").removeAttr("hidden")
                            } else {
                                $("#invalid-email-feedback").attr("hidden", "true")
                            }
                            if ("email_not_unique" in response) {
                                emailInput.addClass("is-invalid")
                                $("#email-not-unique-feedback").removeAttr("hidden")
                            } else {
                                $("#email-not-unique-feedback").attr("hidden", "true")
                            }
                            if ("login_invalid" in response) {
                                loginInput.addClass("is-invalid")
                                $("#invalid-login-feedback").removeAttr("hidden")
                            } else {
                                $("#invalid-login-feedback").attr("hidden", "true")
                            }
                            if ("login_not_unique" in response) {
                                loginInput.addClass("is-invalid")
                                $("#login-not-unique-feedback").removeAttr("hidden")
                            } else {
                                $("#login-not-unique-feedback").attr("hidden", "true")
                            }
                            if ("password_invalid" in response) {
                                passwordInput.addClass("is-invalid")
                            }
                            if ("password_not_confirmed" in response) {
                                confirmPasswordInput.addClass("is-invalid")
                            }
                            if ("unknown_error" in response) {
                                $("#unknown-error-alert").removeAttr("hidden")
                            }

                            $("#register-button").removeAttr("disabled")
                            $("#register-button-spinner").attr("hidden", "true")
                            $("#register-button-text").text("Register")
                            $("input").removeAttr("disabled")
                        }
                    }
                })
            }
        })
        $(document).on("input", "input", function () {
            $(this).removeClass("is-invalid")
        })
        $(document).on("input", "#password-input", function () {
            let confirmPasswordInput = $("#confirm-password-input")
            if (confirmPasswordInput.val() && $(this).val() !== confirmPasswordInput.val()) {
                confirmPasswordInput.addClass("is-invalid")
            } else {
                confirmPasswordInput.removeClass("is-invalid")
            }
        })
        $(document).on("input", "#confirm-password-input", function () {
            if ($(this).val() !== $("#password-input").val()) {
                $(this).addClass("is-invalid")
            } else {
                $(this).removeClass("is-invalid")
            }
        })
        $(document).on("input", "#avatar-input", function() {
            if (!$(this).val()) {
                $(this).removeClass("is-invalid")
                $("#avatar-too-big-feedback").attr("hidden", "true")
                $("#avatar-unsupported-format-feedback").attr("hidden", "true")
                return;
            }

            let file = $(this)[0].files[0];
            if (file.size > 5 * 1024 * 1024) {
                $(this).val(null)

                $(this).addClass("is-invalid")
                $("#avatar-too-big-feedback").removeAttr("hidden")
                $("#avatar-unsupported-format-feedback").attr("hidden", "true")
            } else if (!file.type.endsWith("jpeg") && !file.type.endsWith("png")) {
                $(this).val(null)

                $(this).addClass("is-invalid")
                $("#avatar-too-big-feedback").attr("hidden", "true")
                $("#avatar-unsupported-format-feedback").removeAttr("hidden")
            } else {
                $(this).removeClass("is-invalid")
                $("#avatar-too-big-feedback").attr("hidden", "true")
                $("#avatar-unsupported-format-feedback").attr("hidden", "true")
            }
        })
    </script>

    <h1 class="page-title">Register</h1>

    <p class="alert alert-danger m-3" id="unknown-error-alert" hidden>
        <i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
        Unknown error. Try again later.
    </p>

    <form class="container">
        <div class="mb-3">
            <label for="avatar-input" class="form-label">Avatar</label>
            <input class="form-control" type="file" id="avatar-input" name="avatar" accept=".jpg, .jpeg, .png" aria-describedby="avatarHelp">
            <div class="invalid-feedback" id="avatar-too-big-feedback" hidden>
                Avatar file size exceeds threshold.
            </div>
            <div class="invalid-feedback" id="avatar-unsupported-format-feedback" hidden>
                Format of avatar file is not supported.
            </div>
            <div id="avatarHelp" class="form-text">
                We recommend setting your real photo as an avatar. Max 5 MB. Supported formats: .jpg, .jpeg, .png.
            </div>
        </div>
        <div class="mb-3">
            <label for="first-name-input" class="form-label">First name</label>
            <input type="text" class="form-control" id="first-name-input" name="firstName" required />
            <div class="invalid-feedback">
                Please enter a valid first name.
            </div>
        </div>
        <div class="mb-3">
            <label for="last-name-input" class="form-label">Last name</label>
            <input type="text" class="form-control" id="last-name-input" name="lastName" required />
            <div class="invalid-feedback">
                Please enter a valid last name.
            </div>
        </div>
        <div class="mb-3">
            <label for="email-input" class="form-label">E-mail</label>
            <input type="email" class="form-control" id="email-input" name="email" required />
            <div class="invalid-feedback" id="invalid-email-feedback" hidden>
                Please enter a valid email.
            </div>
            <div class="invalid-feedback" id="email-not-unique-feedback" hidden>
                This email is already registered.
            </div>
        </div>
        <div class="mb-3">
            <label for="login-input" class="form-label">Login</label>
            <input type="text" class="form-control" id="login-input" name="login" aria-describedby="loginHelp" required />
            <div class="invalid-feedback" id="invalid-login-feedback" hidden>
                Please enter a valid login.
            </div>
            <div class="invalid-feedback" id="login-not-unique-feedback" hidden>
                This login is already taken.
            </div>
            <div id="loginHelp" class="form-text">
                Must be unique. Length from 5 to 60 symbols. You can use English letters, digits, underscores, dots and hyphens.
            </div>
        </div>
        <div class="mb-3">
            <label for="password-input" class="form-label">Password</label>
            <input type="password" class="form-control" id="password-input" name="password" aria-describedby="passwordHelp" required />
            <div class="invalid-feedback">
                Please enter a valid password.
            </div>
            <div id="passwordHelp" class="form-text">
                Length from 6 to 64 symbols. You can use English letters, digits and special symbols.
            </div>
        </div>
        <div class="mb-3">
            <label for="confirm-password-input" class="form-label">Confirm password</label>
            <input type="password" class="form-control" id="confirm-password-input" name="confirmPassword" aria-describedby="confirmPasswordHelp" required />
            <div class="invalid-feedback">
                Passwords don't match.
            </div>
            <div id="confirmPasswordHelp" class="form-text">
                Retype your password here.
            </div>
        </div>
        <button id="register-button" type="button" class="btn btn-primary mb-3">
            <span id="register-button-spinner" class="spinner-border spinner-border-sm" aria-hidden="true" hidden></span>
            <span id="register-button-text">Register</span>
        </button>

        <p class="text-secondary"><i class="bi bi-lightbulb-fill"></i> Already have an account? <a href="${rc.getContextPath()}/auth">Log in</a></p>
    </form>
</#macro>
