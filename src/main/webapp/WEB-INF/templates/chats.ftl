<#include "base.ftl">

<#macro title>Chats</#macro>

<#macro content>
    <h1 class="page-title">Chats</h1>

    <div class="container">
        <div class="row">
            <div class="col-lg-6 mt-3">
                <h2>My advertisements</h2>
                <div class="accordion" id="ads-accordion">
                    <#list myAdvertisements as ad>
                        <div class="card mb-2">
                            <div class="row g-0">
                                <div class="col-md-3">
                                    <div id="carousel${ad.id}"
                                         class="carousel slide">
                                        <div class="carousel-inner"
                                             style="border-radius: 0.375rem">
                                            <#list ad.imagesUrls as imageUrl>
                                                <div class="carousel-item <#if imageUrl?index == 0>active</#if>">
                                                    <img src="${imageUrl}"
                                                         class="d-block w-100"
                                                         style="object-fit: cover; height: 140px">
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
                                    <div class="card-header">
                                        <h5 class="mt-2">${ad}</h5>
                                    </div>
                                    <div class="card-body">
                                        <#list users[ad?index] as chatUser>
                                            <a href="${rc.getContextPath()}/chat?ad_id=${ad.id}&recipient_id=${chatUser.id}"
                                               style="text-decoration: none; --bs-link-color-rgb: var(--bs-body-color-rgb)">
                                                <div class="d-flex justify-content-between align-items-center <#if chatUser?index != 0>mt-3</#if>">
                                                    <div>
                                                        <#if (chatUser.avatarUrl)??>
                                                            <img src="${chatUser.getRoundCroppedAvatarUrl()}" alt="user avatar" class="me-2" width="50" height="50">
                                                        <#else>
                                                            <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16" width="50" height="50" class="bi bi-person-circle me-2">
                                                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
                                                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
                                                            </svg>
                                                        </#if>
                                                        <span>${chatUser}</span>
                                                    </div>
                                                    <div class="d-flex align-items-center">
                                                        <#if unreadMap[(ad.id)?c]?? && unreadMap[(ad.id)?c]?seq_contains(chatUser.id)>
                                                            <span class="p-2 bg-danger rounded-circle me-3"></span>
                                                        </#if>
                                                        <svg xmlns="http://www.w3.org/2000/svg"
                                                             width="32"
                                                             height="32"
                                                             fill="currentColor"
                                                             class="bi bi-arrow-right"
                                                             viewBox="0 0 16 16">
                                                            <path fill-rule="evenodd"
                                                                  d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                                        </svg>
                                                    </div>
                                                </div>
                                            </a>
                                        <#else>
                                            <div class="card-body">
                                                <span class="text-secondary">Empty</span>
                                            </div>
                                        </#list>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <#else>
                        <p class="text-secondary">You don't have any advertisements</p>
                    </#list>
                </div>
            </div>

            <div class="col-lg-6 mt-3">
                <h2>Other advertisements</h2>
                <div>
                    <#list otherAdvertisements as ad>
                        <a href="${rc.getContextPath()}/chat?ad_id=${ad.id}&recipient_id=${ad.seller.id}"
                           style="text-decoration: none">
                            <div class="card mb-2">
                                <div class="row g-0">
                                    <div class="col-md-3">
                                        <div id="carousel${ad.id}"
                                             class="carousel slide">
                                            <div class="carousel-inner"
                                                 style="border-radius: 0.375rem">
                                                <#list ad.imagesUrls as imageUrl>
                                                    <div class="carousel-item <#if imageUrl?index == 0>active</#if>">
                                                        <img src="${imageUrl}"
                                                             class="d-block w-100"
                                                             style="object-fit: cover; height: 140px">
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
                                        <div class="card-header">
                                            <h5 class="mt-2">${ad}</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <#if (ad.seller.avatarUrl)??>
                                                        <img src="${ad.seller.getRoundCroppedAvatarUrl()}" alt="user avatar" class="me-2" width="50" height="50">
                                                    <#else>
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16" width="50" height="50" class="bi bi-person-circle me-2">
                                                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
                                                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
                                                        </svg>
                                                    </#if>
                                                    <span>${ad.seller}</span>
                                                </div>
                                                <div class="d-flex align-items-center">
                                                    <#if unreadMap[(ad.id)?c]?? && unreadMap[(ad.id)?c]?seq_contains(ad.seller.id)>
                                                        <span class="p-2 bg-danger rounded-circle me-3"></span>
                                                    </#if>
                                                    <svg xmlns="http://www.w3.org/2000/svg"
                                                         width="32" height="32"
                                                         fill="currentColor"
                                                         class="bi bi-arrow-right"
                                                         viewBox="0 0 16 16">
                                                        <path fill-rule="evenodd"
                                                              d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                                    </svg>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    <#else>
                        <p class="text-secondary">You didn't send a message to any advertisement</p>
                    </#list>
                </div>
            </div>
        </div>
    </div>
</#macro>
