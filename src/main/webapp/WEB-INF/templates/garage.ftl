<#include "base.ftl">

<#macro title>Garage</#macro>

<#macro content>
    <script>
        $(document).ready(function () {
            $("#delete-car-modal").on("show.bs.modal", event => {
                let btn = event.relatedTarget
                let carName = btn.getAttribute("data-bs-car-name")
                let carId = btn.getAttribute("data-bs-car-id")
                $(".modal-body").text(carName + " will be deleted. Proceed?")
                $("#delete-btn").attr("data-bs-car-id", carId)
            })
            $("#delete-btn").on("click", function () {
                let carId = $(this).attr("data-bs-car-id")
                if (carId !== null) {
                    $("#delete-btn").attr("disabled", "true")
                    $("#delete-btn-spinner").removeAttr("hidden")
                    $("#delete-btn-text").text("Loading...")
                    $("#cancel-btn").attr("disabled", "true")
                    $("#delete-car-modal").attr("data-bs-backdrop", "static")
                    $.post(
                        "${rc.getContextPath()}/garage",
                        {
                            "action": "delete",
                            "carId": carId,
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

    <h1 class="page-title">Garage</h1>

    <div class="container">
        <a href="${rc.getContextPath()}/garage/new" class="btn btn-outline-primary mb-3" style="width: 100%">
            <i class="bi bi-plus-lg me-1"></i>
            <span>Add a car</span>
        </a>
        <#if cars?size != 0>
            <#list cars as car>
                <div class="card mb-2">
                    <div class="card-header d-flex justify-content-between">
                        <h5 class="mt-2">${car}</h5>
                        <#if (carAdvertisementMap?keys)?seq_contains((car.id)?string)>
                            <a class="icon-link mt-2 link-info" href="${rc.getContextPath()}/advertisements?id=${carAdvertisementMap[(car.id)?string]}">
                                <i class="bi bi-card-heading"></i>
                                <span>Advertising</span>
                            </a>
                        <#else>
                            <div>
                                <a class="icon-link mt-2 me-2" href="${rc.getContextPath()}/advertisements/new?id=${car.id}">
                                    <i class="bi bi-card-heading"></i>
                                    <span>Advertise</span>
                                </a>
                                <a class="icon-link mt-2 link-danger" href="#" data-bs-toggle="modal" data-bs-target="#delete-car-modal" data-bs-car-name="${car}" data-bs-car-id="${car.id}">
                                    <i class="bi bi-trash"></i>
                                    <span>Delete</span>
                                </a>
                            </div>
                        </#if>
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
            </#list>
        <#else>
            <div class="d-flex flex-column align-items-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="72" height="72"
                     fill="currentColor" class="bi bi-car-front"
                     viewBox="0 0 16 16">
                    <path d="M4 9a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm10 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0ZM6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2H6ZM4.862 4.276 3.906 6.19a.51.51 0 0 0 .497.731c.91-.073 2.35-.17 3.597-.17 1.247 0 2.688.097 3.597.17a.51.51 0 0 0 .497-.731l-.956-1.913A.5.5 0 0 0 10.691 4H5.309a.5.5 0 0 0-.447.276Z"/>
                    <path d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679c.033.161.049.325.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.807.807 0 0 0 .381-.404l.792-1.848ZM4.82 3a1.5 1.5 0 0 0-1.379.91l-.792 1.847a1.8 1.8 0 0 1-.853.904.807.807 0 0 0-.43.564L1.03 8.904a1.5 1.5 0 0 0-.03.294v.413c0 .796.62 1.448 1.408 1.484 1.555.07 3.786.155 5.592.155 1.806 0 4.037-.084 5.592-.155A1.479 1.479 0 0 0 15 9.611v-.413c0-.099-.01-.197-.03-.294l-.335-1.68a.807.807 0 0 0-.43-.563 1.807 1.807 0 0 1-.853-.904l-.792-1.848A1.5 1.5 0 0 0 11.18 3H4.82Z"/>
                </svg>
                <h2>Garage is empty</h2>
                <p>Try adding <a href="${rc.getContextPath()}/garage/new">new car</a>.</p>
            </div>
        </#if>
    </div>

    <div class="modal fade" id="delete-car-modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">Delete car</h1>
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
