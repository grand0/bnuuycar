<#include "base.ftl">

<#macro title>Profile</#macro>

<#macro content>
    <h1 class="page-title">Profile</h1>

    <#if profile_edited??>
        <p class="success">
            <i class="fa-solid fa-check"></i>
            Profile edited successfully.
        </p>
    </#if>

    <#if (profile.avatarUrl)??>
        <img src="${profile.getRoundCroppedAvatarUrl()}" alt="user avatar" class="d-block mx-auto mb-2" width="150" height="150">
    <#else>
        <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16" width="150" height="150" class="bi bi-person-circle mb-2 d-block mx-auto">
            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
        </svg>
    </#if>

    <div class="container">
        <h2 class="text-center mb-3">
            <i class="bi bi-person-fill" aria-hidden="true"></i>
            ${profile}
        </h2>
        <p class="text-center mb-3">
            <i class="bi bi-envelope-fill" aria-hidden="true"></i>
            ${profile.email}
        </p>

        <#if authId?? && authId == profile.id>
            <div class="row justify-content-center mb-3">
                <a href="${rc.getContextPath()}/profile_edit" class="btn btn-outline-primary icon-link col-auto me-3">
                    <i class="bi bi-pencil"></i>
                    <span>Edit profile</span>
                </a>
                <a href="${rc.getContextPath()}/logout" class="btn btn-outline-danger icon-link col-auto">
                    <i class="bi bi-box-arrow-left"></i>
                    <span>Log out</span>
                </a>
            </div>
        </#if>

        <div class="accordion mb-3" id="ads-accordion">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#ads-collapse">
                        ${profile.firstName}'s advertisements
                    </button>
                </h2>
                <div id="ads-collapse" class="accordion-collapse collapse" data-bs-parent="#ads-accordion">
                    <ul class="list-group">
                        <#list advertisements as ad>
                            <li class="list-group-item p-0">
                                <a href="${rc.getContextPath()}/advertisements?id=${ad.id}"
                                   style="text-decoration: none">
                                    <div class="card" style="border-radius: 0; border: none">
                                        <div class="row g-0">
                                            <div class="col-md-3">
                                                <div id="carousel${ad.id}" class="carousel slide">
                                                    <div class="carousel-inner" style="border-radius: 0 0.375rem 0.375rem 0">
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
                                                    <h5 class="mt-2">${ad}</h5>
                                                    <h5 class="mt-2">${(ad.price)?string["$0"]}</h5>
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
                                </a>
                            </li>
                        </#list>
                    </ul>
                </div>
            </div>
        </div>

        <div class="accordion mb-3" id="cars-accordion">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cars-collapse">
                        ${profile.firstName}'s cars
                    </button>
                </h2>
            </div>
            <div id="cars-collapse" class="accordion-collapse collapse" data-bs-parent="#cars-accordion">
                <ul class="list-group">
                    <#list cars as car>
                        <li class="list-group-item p-0">
                            <div class="card mb-2" style="border-radius: 0; border: none">
                                <div class="card-header">
                                    <h5 class="mt-2">${car}</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col">
                                            <strong>Body</strong><br>
                                            ${car.body}
                                        </div>
                                        <div class="col">
                                            <strong>Transmission</strong><br>
                                            ${car.transmission}
                                        </div>
                                        <div class="col">
                                            <strong>Engine</strong><br>
                                            ${car.engine}
                                        </div>
                                        <div class="col">
                                            <strong>Drive</strong><br>
                                            ${car.drive}
                                        </div>
                                        <#if car.engine.id != 4> <!-- if not electro engine -->
                                            <div class="col">
                                                <strong>Engine volume</strong><br>
                                                ${car.engineVolume?string["0.0"]} L
                                            </div>
                                        </#if>
                                        <div class="col">
                                            <strong>Horsepower</strong><br>
                                            ${car.horsepower} hp
                                        </div>
                                        <div class="col">
                                            <strong>Wheel</strong><br>
                                            <#if car.leftWheel>Left<#else>Right</#if>
                                        </div>
                                        <#if car.engine.id == 4> <!-- if electro engine -->
                                            <div class="col"></div>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </#list>
                </ul>
            </div>
        </div>
    </div>

</#macro>
