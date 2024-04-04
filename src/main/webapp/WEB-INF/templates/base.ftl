<#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>
<@security.authorize access="isAuthenticated()">
    <#assign username>
        <@security.authentication property="principal.username" />
    </#assign>
</@security.authorize>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><@title/> / buycar</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="icon" type="image/png" href="${rc.getContextPath()}/assets/img/favicon.png">

    <!-- google fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">

    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    <!-- bootstrap icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- custom scripts and stylesheets -->
    <script src="${rc.getContextPath()}/scripts/input-restriction.js"></script>
    <link rel="stylesheet" href="${rc.getContextPath()}/styles/styles.css">
</head>
<body>

<nav class="navbar sticky-top navbar-expand-md bg-body-tertiary">
    <div class="container">
        <a class="navbar-brand" href="${rc.getContextPath()}/">
            <span>bnuuy<span style="color: red">car</span></span>
        </a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#collapsingNavbar"
                aria-controls="collapsingNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapsingNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${rc.getContextPath()}/advertisements">Ads</a>
                </li>
                <#if username??>
                    <li class="nav-item">
                        <a class="nav-link" href="${rc.getContextPath()}/advertisements/my">My ads</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${rc.getContextPath()}/garage">Garage</a>
                    </li>
                </#if>
            </ul>
            <div class="nav-buttons">
                <#if username??>
                    <a href="${rc.getContextPath()}/chats" class="me-3 position-relative">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
                            <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
                            <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
                        </svg>
                        <#if unread_messages_count?? && unread_messages_count != 0>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${unread_messages_count}
                            </span>
                        </#if>
                    </a>
                    <a href="${rc.getContextPath()}/bookmarks" class="me-3">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-bookmark-star" viewBox="0 0 16 16">
                            <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/>
                            <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
                        </svg>
                    </a>
                    <a class="icon-link" href="${rc.getContextPath()}/profile">
                        <i class="bi bi-person-fill" aria-hidden="true"></i>
                        <span>${username}</span>
                    </a>
                <#else>
                    <a href="${rc.getContextPath()}/register" class="btn btn-outline-primary me-2">Register</a>
                    <a href="${rc.getContextPath()}/auth" class="btn btn-outline-secondary">Log in</a>
                </#if>
                <div class="vr mx-3"></div>
                <a href="#" id="theme-switcher">
                    <i class="bi bi-moon"></i>
                </a>
            </div>
        </div>
    </div>
</nav>

<script src="${rc.getContextPath()}/scripts/theme-switcher.js"></script>

<div class="content">
    <@content/>
</div>

</body>
</html>
