<#include "base.ftl">

<#macro title>Buy ${advertisement}</#macro>

<#macro content>
    <script>
        $(document).ready(function () {
            $("#bookmark").on("click", function () {
                $.post(
                    "${rc.getContextPath()}/advertisements",
                    {
                        "action": "bookmark",
                        "adId": ${advertisement.id}
                    },
                    function (response) {
                        if ("unauthorized" in response) {
                            window.location.replace("${rc.getContextPath()}/auth")
                        } else if ("isBookmarked" in response) {
                            if (response.isBookmarked) {
                                $(".bi-bookmark-star")
                                    .removeClass("bi-bookmark-star")
                                    .addClass("bi-bookmark-star-fill")
                                    .siblings("span")
                                    .text("Remove from bookmarks")
                            } else {
                                $(".bi-bookmark-star-fill")
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

    <div class="container">
        <div class="d-flex justify-content-between mt-3">
            <h1>${advertisement.car}</h1>
            <h1>${(advertisement.price)?string["$0"]}</h1>
        </div>

        <#if !isMy>
            <a id="bookmark" class="icon-link mb-3" href="#">
                <#if isBookmarked>
                    <i class="bi bi-bookmark-star-fill"></i>
                    <span>Remove from bookmarks</span>
                <#else>
                    <i class="bi bi-bookmark-star"></i>
                    <span>Add to bookmarks</span>
                </#if>
            </a>
        </#if>

        <div class="row">
            <div id="carousel${advertisement.id}" class="carousel slide col-md-6" style="height: max(22.5vw, 250px)">
                <div class="carousel-inner" style="border-radius: 0.375rem">
                    <#list advertisement.imagesUrls as imageUrl>
                        <div class="carousel-item <#if imageUrl?index == 0>active</#if>">
                            <img src="${imageUrl}"
                                 class="d-block w-100" style="object-fit: cover; height: max(22.5vw, 250px)">
                        </div>
                    </#list>
                </div>
                <button class="carousel-control-prev"
                        type="button"
                        data-bs-target="#carousel${advertisement.id}"
                        data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon"
                                          aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next"
                        type="button"
                        data-bs-target="#carousel${advertisement.id}"
                        data-bs-slide="next">
                                    <span class="carousel-control-next-icon"
                                          aria-hidden="true"></span>
                </button>
            </div>

            <div class="col-3">
                <div class="mb-3">
                    <strong>Body</strong><br>
                    ${advertisement.car.body}
                </div>
                <div class="mb-3">
                    <strong>Transmission</strong><br>
                    ${advertisement.car.transmission}
                </div>
                <div class="mb-3">
                    <strong>Engine</strong><br>
                    ${advertisement.car.engine}
                </div>
                <div class="mb-3">
                    <strong>Drive</strong><br>
                    ${advertisement.car.drive}
                </div>
                <#if advertisement.car.engine.id != 4> <!-- if not electro engine -->
                    <div class="mb-3">
                        <strong>Engine volume</strong><br>
                        ${advertisement.car.engineVolume?string["0.0"]} L
                    </div>
                </#if>
                <div class="mb-3">
                    <strong>Horsepower</strong><br>
                    ${advertisement.car.horsepower} hp
                </div>
                <div class="mb-3">
                    <strong>Wheel</strong><br>
                    <#if advertisement.car.leftWheel>Left<#else>Right</#if>
                </div>
            </div>

            <div class="col-3">
                <div class="mb-3">
                    <strong>Mileage</strong><br>
                    ${advertisement.mileage} km
                </div>
                <div class="mb-3">
                    <strong>Condition</strong><br>
                    ${advertisement.condition}
                </div>
                <div class="mb-3">
                    <strong>Owners</strong><br>
                    ${advertisement.owners}
                </div>
                <div class="mb-3">
                    <strong>Exchange</strong><br>
                    <#if advertisement.exchangeAllowed>
                        Allowed
                    <#else>
                        Disallowed
                    </#if>
                </div>
                <div class="mb-3">
                    <strong>Color</strong><br>
                    ${advertisement.carColor}
                </div>
                <div class="mb-3 text-secondary">
                    <strong>Posted</strong><br>
                    ${advertisement.publicationTs}
                </div>
                <div class="mb-3 text-secondary">
                    <strong>Views</strong><br>
                    ${advertisement.viewCount}
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <h2>Description</h2>
                <p>${advertisement.description}</p>
            </div>
            <div class="col-md-6">
                <h2>Seller</h2>
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <#if (advertisement.seller.avatarUrl)??>
                                    <img src="${advertisement.seller.getRoundCroppedAvatarUrl()}" alt="user avatar" class="me-3" width="50" height="50">
                                <#else>
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16" width="50" height="50" class="bi bi-person-circle me-3">
                                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
                                        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
                                    </svg>
                                </#if>
                                <span>${advertisement.seller}</span>
                            </div>
                            <div>
                                <a class="icon-link" href="${rc.getContextPath()}/profile?id=${advertisement.seller.id}">
                                    <i class="bi bi-person-fill"></i>
                                    View profile
                                </a>
                            </div>
                        </div>
                    </div>
                    <#if !isMy>
                        <div class="card-footer p-0">
                            <a class="btn btn-primary icon-link w-100 justify-content-center" href="${rc.getContextPath()}/chat?ad_id=${advertisement.id}&recipient_id=${advertisement.seller.id}" style="border-radius: 0 0 0.375rem 0.375rem">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots me-1" viewBox="0 0 16 16">
                                    <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
                                    <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
                                </svg>
                                <span>Send a message</span>
                            </a>
                        </div>
                    </#if>
                </div>




            </div>
        </div>
    </div>
</#macro>
