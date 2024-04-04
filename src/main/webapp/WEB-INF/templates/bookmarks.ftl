<#include "base.ftl">

<#macro title>Bookmarks</#macro>

<#macro content>
    <script>
        $(document).ready(function () {
            $(".remove-bookmark").on("click", function () {
                const link = $(this)
                const adId = link.attr("data-bs-id")
                $.post(
                    "${rc.getContextPath()}/advertisements",
                    {
                        "action": "bookmark",
                        "adId": adId
                    },
                    function (response) {
                        if ("unauthorized" in response) {
                            window.location.replace("${rc.getContextPath()}/auth")
                        } else if ("isBookmarked" in response) {
                            if (response.isBookmarked) {
                                console.log("true")
                                link
                                    .addClass("link-danger")
                                    .children(".bi-bookmark-star")
                                        .removeClass("bi-bookmark-star")
                                        .addClass("bi-bookmark-star-fill")
                                    .siblings("span")
                                        .text("Remove from bookmarks")
                            } else {
                                console.log("false")
                                link
                                    .removeClass("link-danger")
                                    .children(".bi-bookmark-star-fill")
                                        .removeClass("bi-bookmark-star-fill")
                                        .addClass("bi-bookmark-star")
                                    .siblings("span")
                                        .text("Add to bookmarks")
                            }
                        }
                    }
                )
            })
        })
    </script>

    <h1 class="page-title">Bookmarks</h1>

    <div class="container">
        <#list advertisements as ad>
            <div class="card mb-2">
                <div class="row g-0">
                    <div class="col-md-3">
                        <div id="carousel${ad.id}" class="carousel slide">
                            <div class="carousel-inner" style="border-radius: 0.375rem">
                                <#list ad.imagesUrls as imageUrl>
                                    <div class="carousel-item <#if imageUrl?index == 0>active</#if>">
                                        <img src="${imageUrl}"
                                             class="d-block w-100" style="object-fit: cover; height: 200px">
                                    </div>
                                </#list>
                            </div>
                            <button class="carousel-control-prev"
                                    type="button"
                                    data-bs-target="#carousel${ad.id}"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"
                                      aria-hidden="true"></span>
                            </button>
                            <button class="carousel-control-next"
                                    type="button"
                                    data-bs-target="#carousel${ad.id}"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon"
                                      aria-hidden="true"></span>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="card-header d-flex justify-content-between">
                            <a href="${rc.getContextPath()}/advertisements?id=${ad.id}" style="text-decoration: none">
                                <h5 class="mt-2">${ad}</h5>
                            </a>
                            <div>
                                <a class="remove-bookmark icon-link link-danger mt-2 me-2" href="#" data-bs-id="${ad.id}">
                                    <i class="bi bi-bookmark-star-fill"></i>
                                    <span>Remove from bookmarks</span>
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <strong>Mileage</strong><br>
                                    ${ad.mileage} km
                                </div>
                                <div class="col">
                                    <strong>Condition</strong><br>
                                    ${ad.condition}
                                </div>
                                <div class="col">
                                    <strong>Owners</strong><br>
                                    ${ad.owners}
                                </div>
                                <div class="col">
                                    <strong>Exchange</strong><br>
                                    <#if ad.exchangeAllowed>
                                        Allowed
                                    <#else>
                                        Disallowed
                                    </#if>
                                </div>
                                <div class="col">
                                    <strong>Price</strong><br>
                                    ${(ad.price)?string["$0"]}
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between mx-3 mb-3 text-secondary">
                            <span>${ad.publicationTs}</span>
                            <span>
                                <i class="bi bi-eye"></i>
                                ${ad.viewCount}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="d-flex flex-column align-items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="72" height="72" fill="currentColor" class="bi bi-bookmark-star" viewBox="0 0 16 16">
                    <path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/>
                    <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
                </svg>
                <h2>You don't have any bookmarks</h2>
                <p>Try adding few through <a href="${rc.getContextPath()}/advertisements">advertisements</a> page.</p>
            </div>
        </#list>
    </div>
</#macro>
