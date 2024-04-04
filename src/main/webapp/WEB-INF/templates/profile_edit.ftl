<#include "base.ftl">

<#macro title>Edit profile</#macro>

<#macro content>
    <script>
        $(document).on("click", "#save-button", function () {
            $(".is-invalid").removeClass("is-invalid")

            let avatarInput = $("#avatar-input")
            let emailInput = $("#email-input")
            let oldPasswordInput = $("#old-password-input")
            let newPasswordInput = $("#new-password-input")
            let confirmPasswordInput = $("#confirm-password-input")

            let formValid = true
            if (!emailInput.val()) {
                emailInput.addClass("is-invalid")
                $("#invalid-email-feedback").removeAttr("hidden")
                formValid = false
            } else {
                $("#invalid-email-feedback").attr("hidden", "true")
            }
            if (newPasswordInput.val() && confirmPasswordInput.val() !== newPasswordInput.val()) {
                confirmPasswordInput.addClass("is-invalid")
                formValid = false;
            }

            if (formValid) {
                $(this).attr("disabled", "true")
                $("#save-button-spinner").removeAttr("hidden")
                $("#save-button-text").text("Loading...")
                $("#cancel-button").attr("disabled", "true")
                $("input").attr("disabled", "true")
                $("#unknown-error-alert").attr("hidden", "true")

                let formData = new FormData()
                formData.append("avatar", avatarInput[0].files[0])
                formData.append("email", emailInput.val())
                formData.append("oldPassword", oldPasswordInput.val())
                formData.append("newPassword", newPasswordInput.val())
                formData.append("confirmPassword", confirmPasswordInput.val())

                $.ajax({
                    url: "${rc.getContextPath()}/profile_edit",
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response.success) {
                            window.location.replace("${rc.getContextPath()}/profile")
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
                            if ("old_password_wrong" in response) {
                                oldPasswordInput.addClass("is-invalid")
                            }
                            if ("password_invalid" in response) {
                                newPasswordInput.addClass("is-invalid")
                            }
                            if ("password_not_confirmed" in response) {
                                confirmPasswordInput.addClass("is-invalid")
                            }
                            if ("unknown_error" in response) {
                                $("#unknown-error-alert").removeAttr("hidden")
                            }
                            if ("unauthorized" in response) {
                                window.location.replace("${rc.getContextPath()}/auth")
                            }

                            $("#save-button").removeAttr("disabled")
                            $("#save-button-spinner").attr("hidden", "true")
                            $("#save-button-text").text("Save changes")
                            $("#cancel-button").removeAttr("disabled")
                            $("input").removeAttr("disabled")
                        }
                    }
                })
            }
        })
        $(document).on("input", "input", function () {
            $(this).removeClass("is-invalid")
        })
        $(document).on("input", "#new-password-input", function () {
            let confirmPasswordInput = $("#confirm-password-input")
            if (confirmPasswordInput.val() && $(this).val() !== confirmPasswordInput.val()) {
                confirmPasswordInput.addClass("is-invalid")
            } else {
                confirmPasswordInput.removeClass("is-invalid")
            }
        })
        $(document).on("input", "#confirm-password-input", function () {
            if ($(this).val() !== $("#new-password-input").val()) {
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

    <h1 class="page-title">Edit profile</h1>

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
        <div class="mb-5">
            <label for="email-input" class="form-label">E-mail</label>
            <input type="email" class="form-control" id="email-input" name="email" value="${email!}" required>
            <div class="invalid-feedback" id="invalid-email-feedback" hidden>
                Please enter a valid email.
            </div>
            <div class="invalid-feedback" id="email-not-unique-feedback" hidden>
                This email is already registered.
            </div>
        </div>
        <div class="mb-3 alert alert-info">
            <i class="bi bi-lightbulb-fill"></i>
            Leave next fields blank if you don't want to change the password.
        </div>

        <div class="mb-3">
            <label for="old-password-input" class="form-label">Old password</label>
            <input type="password" class="form-control" id="old-password-input" name="oldPassword">
            <div class="invalid-feedback">
                Password is wrong.
            </div>
        </div>
        <div class="mb-3">
            <label for="new-password-input" class="form-label">New password</label>
            <input type="password" class="form-control" id="new-password-input" name="newPassword" aria-describedby="passwordHelp">
            <div class="invalid-feedback">
                Please enter a valid password.
            </div>
            <div id="passwordHelp" class="form-text">
                Length from 6 to 64 symbols. You can use English letters, digits and special symbols.
            </div>
        </div>
        <div class="mb-3">
            <label for="confirm-password-input" class="form-label">Confirm password</label>
            <input type="password" class="form-control" id="confirm-password-input" name="confirmPassword" aria-describedby="confirmPasswordHelp">
            <div class="invalid-feedback">
                Passwords don't match.
            </div>
            <div id="confirmPasswordHelp" class="form-text">
                Retype your new password.
            </div>
        </div>
        <button id="save-button" type="button" class="btn btn-primary">
            <span id="save-button-spinner" class="spinner-border spinner-border-sm" aria-hidden="true" hidden></span>
            <span id="save-button-text">Save changes</span>
        </button>
        <a id="cancel-button" class="btn btn-outline-secondary" href="${rc.getContextPath()}/profile">Cancel</a>
    </form>
</#macro>
