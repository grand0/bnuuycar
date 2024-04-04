<#include "base.ftl">

<#macro title>Log in</#macro>

<#macro content>
    <script>
        $(document).on("click", "#log-in-button", function () {
            let loginInput = $("#login-input")
            let login = loginInput.val()

            let passwordInput = $("#password-input")
            let password = passwordInput.val()

            let formValid = true;
            if (!login) {
                loginInput.addClass("is-invalid")
                formValid = false
            }
            if (!password) {
                passwordInput.addClass("is-invalid")
                formValid = false
            }

            if (formValid) {
                $(this).attr("disabled", "true")
                $("#log-in-button-spinner").removeAttr("hidden")
                $("#log-in-button-text").text("Loading...")
                $("input").attr("disabled", "true")

                $.post(
                    "${rc.getContextPath()}/auth",
                    {
                        "login": login,
                        "password": password,
                        "remember": $("#remember-check")[0].checked
                    },
                    function (response) {
                        if (response.success) {
                            window.location.replace("${rc.getContextPath()}")
                        } else {
                            $("#unauthorized-alert").removeAttr("hidden")

                            $("#log-in-button").removeAttr("disabled")
                            $("#log-in-button-spinner").attr("hidden", "true")
                            $("#log-in-button-text").text("Log in")
                            $("input").removeAttr("disabled")
                        }
                    }
                )
            }
        })
        $(document).on("input", "input", function() {
            $("#unauthorized-alert").attr("hidden", "true")
            $(this).removeClass("is-invalid")
        })
    </script>

    <h1 class="page-title">Log in</h1>

    <p class="alert alert-danger m-3" id="unauthorized-alert" hidden>
        <i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
        Incorrect login and/or password
    </p>

    <form class="container">
        <div class="mb-3">
            <label for="login-input" class="form-label">Login</label>
            <input type="text" class="form-control" id="login-input" name="login" value="${past_login!}" required>
            <div class="invalid-feedback">
                Please enter a login.
            </div>
        </div>

        <div class="mb-3">
            <label for="password-input" class="form-label">Password</label>
            <input type="password" class="form-control" id="password-input" name="password" required>
            <div class="invalid-feedback">
                Please enter a password.
            </div>
        </div>

        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" id="remember-check">
            <label class="form-check-label" for="remember-check">Remember me</label>
        </div>

        <button id="log-in-button" type="button" class="btn btn-primary mb-3">
            <span id="log-in-button-spinner" class="spinner-border spinner-border-sm" aria-hidden="true" hidden></span>
            <span id="log-in-button-text">Log in</span>
        </button>

        <p class="text-secondary"><i class="bi bi-lightbulb-fill"></i> Don't have an account? <a href="${rc.getContextPath()}/register">Register</a></p>
    </form>
</#macro>
