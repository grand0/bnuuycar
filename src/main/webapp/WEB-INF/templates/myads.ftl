<#include "base.ftl">

<#macro title>My advertisements</#macro>

<#macro content>
    <script>
        $(document).ready(function () {
            $("#delete-ad-modal").on("show.bs.modal", event => {
                let btn = event.relatedTarget
                let adName = btn.getAttribute("data-bs-ad-name")
                let adId = btn.getAttribute("data-bs-ad-id")
                $(".modal-body").text(adName + " will be deleted. Proceed?")
                $("#delete-btn").attr("data-bs-ad-id", adId)
            })
            $("#delete-btn").on("click", function () {
                let adId = $(this).attr("data-bs-ad-id")
                if (adId !== null) {
                    $("#delete-btn").attr("disabled", "true")
                    $("#delete-btn-spinner").removeAttr("hidden")
                    $("#delete-btn-text").text("Loading...")
                    $("#cancel-btn").attr("disabled", "true")
                    $("#delete-ad-modal").attr("data-bs-backdrop", "static")
                    $.post(
                        "${rc.getContextPath()}/advertisements/my",
                        {
                            "action": "delete",
                            "adId": adId,
                        },
                        function (response) {
                            console.log(response + " " + response.success)
                            if (response.success) {
                                window.location.reload()
                            } else if ("unauthorized" in response) {
                                window.location.replace("${rc.getContextPath()}/auth")
                            } else if ("unknownError" in response) {
                                $(".model-body").text("Unknown error. Please, try again later.")
                                $("#delete-btn").removeAttr("disabled")
                                $("#delete-btn-spinner").attr("hidden", "true")
                                $("#delete-btn-text").text("Delete")
                                $("#cancel-btn").removeAttr("disabled")
                            }
                        }
                    )
                }
            })
        })
    </script>

    <h1 class="page-title">My advertisements</h1>

    <div class="container">
        <a href="${rc.getContextPath()}/advertisements/new" class="btn btn-outline-primary mb-3" style="width: 100%">
            <i class="bi bi-plus-lg me-1"></i>
            <span>Create an advertisement</span>
        </a>
        <#if advertisements?size != 0>
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
                                <h5 class="mt-2">${ad}</h5>
                                <div>
                                    <a class="icon-link mt-2 me-2" href="${rc.getContextPath()}/advertisements?id=${ad.id}">
                                        <i class="bi bi-card-heading"></i>
                                        <span>View ad</span>
                                    </a>
                                    <a class="icon-link mt-2 link-danger" href="#" data-bs-toggle="modal" data-bs-target="#delete-ad-modal" data-bs-ad-name="${ad}" data-bs-ad-id="${ad.id}">
                                        <i class="bi bi-trash"></i>
                                        <span>Delete</span>
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
            </#list>
        <#else>
            <div class="d-flex flex-column align-items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="72" height="72" fill="currentColor" class="bi bi-card-heading" viewBox="0 0 16 16">
                    <path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
                    <path d="M3 8.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm0-5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5v-1z"/>
                </svg>
                <h2>You don't have any advertisements</h2>
                <p>Try posting a <a href="${rc.getContextPath()}/advertisements/new">new one</a>.</p>
            </div>
        </#if>
    </div>

    <div class="modal fade" id="delete-ad-modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">Delete advertisement</h1>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" id="cancel-btn" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" id="delete-btn" class="btn btn-danger">
                        <span id="delete-btn-spinner" class="spinner-border spinner-border-sm" aria-hidden="true" hidden></span>
                        <span id="delete-btn-text">Delete</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</#macro>
