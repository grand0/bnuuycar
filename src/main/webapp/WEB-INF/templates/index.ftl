<#include "base.ftl">

<#macro title>Home</#macro>

<#macro content>

    <div class="text-center" style="margin-top: 100px; margin-bottom: 100px">
        <h1>Welcome to bnuuy<span style="color: red">car</span>!</h1>
        <p>Place to buy and sell used cars</p>
    </div>

    <div class="container">
        <h2 class="mb-3">
            <i class="bi bi-clock me-1"></i>
            Recent advertisements
        </h2>
        <div class="list-group list-group-horizontal position-relative overflow-auto w-100 mb-5">
            <#list advertisements as ad>
                <a href="${rc.getContextPath()}/advertisements?id=${ad.id}" style="text-decoration: none">
                    <div class="card me-3 list-item" style="width: 300px">
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
                        <div class="card-body">
                            <h5>${ad}</h5>
                        </div>
                    </div>
                </a>
            </#list>
        </div>

        <#if bookmarks?? && bookmarks?has_content>
            <h2 class="mb-3">
                <i class="bi bi-bookmark-star me-1"></i>
                Bookmarked
            </h2>
            <div class="list-group list-group-horizontal position-relative overflow-auto w-100 mb-5">
                <#list bookmarks as ad>
                    <a href="${rc.getContextPath()}/advertisements?id=${ad.id}" style="text-decoration: none">
                        <div class="card me-3 list-item" style="width: 300px">
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
                            <div class="card-body">
                                <h5>${ad}</h5>
                            </div>
                        </div>
                    </a>
                </#list>
            </div>
        </#if>
    </div>
</#macro>
