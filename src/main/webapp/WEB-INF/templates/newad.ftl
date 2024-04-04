<#include "base.ftl">

<#macro title>New advertisement</#macro>

<#macro content>
    <script>
        function isNumeric(str) {
            return !isNaN(str)
        }

        $(document).ready(function () {
            $("#create-button").on("click", function () {
                let carSelect = $("#car-select")
                let photosInput = $("#photos-input")
                let descriptionTextarea = $("#description-textarea")
                let mileageInput = $("#mileage-input")
                let colorInput = $("#color-input")
                let conditionSelect = $("#condition-select")
                let ownersInput = $("#owners-input")
                let exchangeSelect = $("#exchange-select")
                let priceInput = $("#price-input")

                let formValid = true
                if (carSelect.val() === null) {
                    carSelect.addClass("is-invalid")
                    formValid = false
                }
                if (!photosInput.val()) {
                    photosInput.addClass("is-invalid")
                    formValid = false
                }
                if (!descriptionTextarea.val().trim()) {
                    descriptionTextarea.addClass("is-invalid")
                    formValid = false
                }
                if (!mileageInput.val().trim() || !isNumeric(mileageInput.val().trim())) {
                    mileageInput.addClass("is-invalid")
                    formValid = false
                }
                if (!colorInput.val().trim()) {
                    colorInput.addClass("is-invalid")
                    formValid = false
                }
                if (conditionSelect.val() === null) {
                    conditionSelect.addClass("is-invalid")
                    formValid = false
                }
                if (!ownersInput.val().trim() || !isNumeric(mileageInput.val().trim())) {
                    ownersInput.addClass("is-invalid")
                    formValid = false
                }
                if (exchangeSelect.val() === null) {
                    exchangeSelect.addClass("is-invalid")
                    formValid = false
                }
                if (!priceInput.val().trim() || !isNumeric(priceInput.val().trim())) {
                    priceInput.addClass("is-invalid")
                    formValid = false
                }

                if (formValid) {
                    $(this).attr("disabled", "true")
                    $("#create-button-spinner").removeAttr("hidden")
                    $("#create-button-text").text("Loading...")
                    $("input").attr("disabled", "true")
                    $("select").attr("disabled", "true")
                    $("textarea").attr("disabled", "true")
                    
                    let formData = new FormData()
                    let files = photosInput[0].files
                    $.each(files, function (index, f) {
                        formData.append("photo" + index, f)
                    })
                    formData.append("carId", carSelect.val())
                    formData.append("description", descriptionTextarea.val().trim())
                    formData.append("mileage", mileageInput.val().trim())
                    formData.append("color", colorInput.val().trim())
                    formData.append("conditionId", conditionSelect.val())
                    formData.append("owners", ownersInput.val())
                    formData.append("exchangeAllowed", (exchangeSelect.val() === "2").toString())
                    formData.append("price", priceInput.val().trim())

                    $.ajax({
                        url: "${rc.getContextPath()}/advertisements/new",
                        type: "POST",
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function (response) {
                            if (response.success) {
                                window.location.replace("${rc.getContextPath()}/advertisements?id=" + response.id)
                            } else {
                                if ("unauthorized" in response) {
                                    window.location.replace("${rc.getContextPath()}/auth")
                                }
                                if ("photoTooBig" in response) {
                                    photosInput.addClass("is-invalid")
                                    $("#photo-too-big-feedback").removeAttr("hidden")
                                } else {
                                    $("#photo-too-big-feedback").attr("hidden", "true")
                                }
                                if ("photoUnsupportedFormat" in response) {
                                    photosInput.addClass("is-invalid")
                                    $("#photo-unsupported-format-feedback").removeAttr("hidden")
                                } else {
                                    $("#photo-unsupported-format-feedback").attr("hidden", "true")
                                }
                                if ("tooManyPhotos" in response) {
                                    photosInput.addClass("is-invalid")
                                    $("#too-many-photos-feedback").removeAttr("hidden")
                                } else {
                                    $("#too-many-photos-feedback").attr("hidden", "true")
                                }
                                if ("noPhotos" in response) {
                                    photosInput.addClass("is-invalid")
                                }
                                if ("carIdInvalid" in response) {
                                    carSelect.addClass("is-invalid")
                                }
                                if ("descriptionInvalid" in response) {
                                    descriptionTextarea.addClass("is-invalid")
                                }
                                if ("mileageInvalid" in response) {
                                    mileageInput.addClass("is-invalid")
                                }
                                if ("colorInvalid" in response) {
                                    colorInput.addClass("is-invalid")
                                }
                                if ("conditionIdInvalid" in response) {
                                    conditionSelect.addClass("is-invalid")
                                }
                                if ("ownersInvalid" in response) {
                                    ownersInput.addClass("is-invalid")
                                }
                                if ("priceInvalid" in response) {
                                    priceInput.addClass("is-invalid")
                                }
                                $("#create-button").removeAttr("disabled")
                                $("#create-button-spinner").attr("hidden", "true")
                                $("#create-button-text").text("Create")
                                $("input").removeAttr("disabled")
                                $("select").removeAttr("disabled")
                                $("textarea").removeAttr("disabled")
                            }
                        }
                    })
                }
            })

            $("input,textarea").on("input", function () {
                $(this).removeClass("is-invalid")
            })
            $("select").on("change", function () {
                $(this).removeClass("is-invalid")
            })

            $("#photos-input").on("input", function () {
                if (!$(this).val()) {
                    $(this).addClass("is-invalid")
                    $("#photo-too-big-feedback").attr("hidden", "true")
                    $("#photo-unsupported-format-feedback").attr("hidden", "true")
                    $("#too-many-photos-feedback").attr("hidden", "true")
                    return;
                }

                let files = $(this)[0].files;
                if (files.length > 10) {
                    $(this)
                        .val(null)
                        .addClass("is-invalid")
                    $("#photo-too-big-feedback").attr("hidden", "true")
                    $("#photo-unsupported-format-feedback").attr("hidden", "true")
                    $("#too-many-photos-feedback").removeAttr("hidden")
                    return;
                }

                const photosInput = $(this)
                $.each(files, function(index, f) {
                    if (f.size > 5 * 1024 * 1024) {
                        photosInput
                            .val(null)
                            .addClass("is-invalid")
                        $("#photo-too-big-feedback").removeAttr("hidden")
                        $("#photo-unsupported-format-feedback").attr("hidden", "true")
                        $("#too-many-photos-feedback").attr("hidden", "true")
                    } else if (!f.type.endsWith("jpeg") && !f.type.endsWith("png")) {
                        photosInput
                            .val(null)
                            .addClass("is-invalid")
                        $("#photo-too-big-feedback").attr("hidden", "true")
                        $("#photo-unsupported-format-feedback").removeAttr("hidden")
                        $("#too-many-photos-feedback").attr("hidden", "true")
                    } else {
                        photosInput.removeClass("is-invalid")
                        $("#photo-too-big-feedback").attr("hidden", "true")
                        $("#photo-unsupported-format-feedback").attr("hidden", "true")
                        $("#too-many-photos-feedback").attr("hidden", "true")
                    }
                })
            })
        })
    </script>

    <h1 class="page-title">New advertisement</h1>

    <form class="container">
        <div class="row g-3">
            <div class="col-12">
                <label for="car-select" class="form-label">Car (<a href="${rc.getContextPath()}/garage/new">add</a>)</label>
                <select class="form-select" id="car-select">
                    <option value="-1" <#if !id??>selected</#if> disabled>Choose car</option>
                    <#if cars?size == 0>
                        <option value="-2" disabled>You need to add car to garage</option>
                    <#else>
                        <#list cars as car>
                            <option value="${car.id}" <#if id?? && car.id?string == id>selected</#if>>${car}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="col-12">
                <label for="photos-input" class="form-label">Photos</label>
                <input type="file" class="form-control" id="photos-input" accept=".jpg, .jpeg, .png" multiple>
                <div class="invalid-feedback" id="photo-too-big-feedback" hidden>
                    Photo file size exceeds threshold.
                </div>
                <div class="invalid-feedback" id="photo-unsupported-format-feedback" hidden>
                    Format of photo file is not supported.
                </div>
                <div class="invalid-feedback" id="too-many-photos-feedback" hidden>
                    You selected too many photos. Max is 10.
                </div>
                <div class="form-text">
                    Upload photos of your car. Max photo file size is 5 MB. Max 10 photos. Supported formats: .jpg, .jpeg, .png.
                </div>
            </div>
            <div class="col-12">
                <label for="description-textarea" class="form-label">Description</label>
                <textarea class="form-control" id="description-textarea" rows="3" maxlength="2000" placeholder="Max 2000 characters"></textarea>
            </div>
            <div class="col-4">
                <label for="mileage-input" class="form-label">Mileage</label>
                <div class="input-group">
                    <input type="number" class="form-control" id="mileage-input">
                    <span class="input-group-text">km</span>
                </div>
            </div>
            <div class="col-4">
                <label for="color-input" class="form-label">Car color</label>
                <input type="text" class="form-control" id="color-input" placeholder="Black">
            </div>
            <div class="col-4">
                <label for="condition-select" class="form-label">Condition</label>
                <select class="form-select" id="condition-select">
                    <option value="-1" selected disabled>Choose condition</option>
                    <#list conditions as condition>
                        <option value="${condition.id}">${condition}</option>
                    </#list>
                </select>
            </div>
            <div class="col-4">
                <label for="owners-input" class="form-label">Owners</label>
                <input type="number" class="form-control" id="owners-input" placeholder="2">
            </div>
            <div class="col-4">
                <label for="exchange-select" class="form-label">Exchange</label>
                <select class="form-select" id="exchange-select">
                    <option value="1" selected>Disallowed</option>
                    <option value="2">Allowed</option>
                </select>
            </div>
            <div class="col-4">
                <label for="price-input" class="form-label">Price</label>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" class="form-control" id="price-input">
                </div>
            </div>
        </div>
        <button id="create-button" type="button" class="btn btn-primary my-3">
            <span id="create-button-spinner" class="spinner-border spinner-border-sm" aria-hidden="true" hidden></span>
            <span id="create-button-text">Create</span>
        </button>
    </form>
</#macro>
