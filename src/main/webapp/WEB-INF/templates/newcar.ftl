<#include "base.ftl">

<#macro title>New car</#macro>

<#macro content>
    <script id="data" type="application/json">
        { "contextPath": "${rc.getContextPath()}" }
    </script>
    <script src="${rc.getContextPath()}/scripts/make-model-hints.js"></script>
    <script>
        function isNumeric(str) {
            return !isNaN(str)
        }

        $(document).ready(function () {
            $("#create-button").on("click", function () {
                let makeInput = $("#make-input")
                let modelInput = $("#model-input")
                let yearInput = $("#year-input")
                let bodySelect = $("#body-select")
                let transmissionSelect = $("#transmission-select")
                let driveSelect = $("#drive-select")
                let engineSelect = $("#engine-select")
                let horsepowerInput = $("#horsepower-input")
                let engineVolumeInput = $("#engine-volume-input")
                let wheelSelect = $("#wheel-select")

                let formValid = true
                if (!makeInput.val().trim()) {
                    makeInput.addClass("is-invalid")
                    formValid = false
                }
                if (!modelInput.val().trim()) {
                    modelInput.addClass("is-invalid")
                    formValid = false
                }
                if (!yearInput.val().trim() || !isNumeric(yearInput.val().trim()) || +(yearInput.val().trim()) < 1900) {
                    yearInput.addClass("is-invalid")
                    formValid = false
                }
                if (bodySelect.val() === null) {
                    bodySelect.addClass("is-invalid")
                    formValid = false
                }
                if (transmissionSelect.val() === null) {
                    transmissionSelect.addClass("is-invalid")
                    formValid = false
                }
                if (driveSelect.val() === null) {
                    driveSelect.addClass("is-invalid")
                    formValid = false
                }
                if (engineSelect.val() === null) {
                    engineSelect.addClass("is-invalid")
                    formValid = false
                }
                if (!horsepowerInput.val().trim() || !isNumeric(horsepowerInput.val().trim())) {
                    horsepowerInput.addClass("is-invalid")
                    formValid = false
                }
                if (!engineVolumeInput.val().trim() || !isNumeric(engineVolumeInput.val().trim())) {
                    engineVolumeInput.addClass("is-invalid")
                    formValid = false
                }
                if (wheelSelect.val() === null) {
                    wheelSelect.addClass("is-invalid")
                    formValid = false
                }

                if (formValid) {
                    $(this).attr("disabled", "true")
                    $("#create-button-spinner").removeAttr("hidden")
                    $("#create-button-text").text("Loading...")
                    $("input").attr("disabled", "true")
                    $("select").attr("disabled", "true")

                    $.post(
                        "${rc.getContextPath()}/garage/new",
                        {
                            "make": makeInput.val().trim(),
                            "model": modelInput.val().trim(),
                            "year": yearInput.val().trim(),
                            "bodyId": bodySelect.val(),
                            "transmissionId": transmissionSelect.val(),
                            "driveId": driveSelect.val(),
                            "engineId": engineSelect.val(),
                            "horsepower": horsepowerInput.val().trim(),
                            "engineVolume": engineVolumeInput.val().trim(),
                            "leftWheel": wheelSelect.val() === "1",
                        },
                        function (response) {
                            if (response.success) {
                                window.location.replace("${rc.getContextPath()}/garage")
                            } else {
                                if ("unauthorized" in response) {
                                    window.location.replace("${rc.getContextPath()}/auth")
                                }
                                if ("makeInvalid" in response) {
                                    makeInput.addClass("is-invalid")
                                }
                                if ("modelInvalid" in response) {
                                    modelInput.addClass("is-invalid")
                                }
                                if ("yearInvalid" in response) {
                                    yearInput.addClass("is-invalid")
                                }
                                if ("bodyIdInvalid" in response) {
                                    bodySelect.addClass("is-invalid")
                                }
                                if ("transmissionIdInvalid" in response) {
                                    transmissionSelect.add("is-invalid")
                                }
                                if ("driveIdInvalid" in response) {
                                    driveSelect.addClass("is-invalid")
                                }
                                if ("engineIdInvalid" in response) {
                                    engineSelect.add("is-invalid")
                                }
                                if ("horsepowerInvalid" in response) {
                                    horsepowerInput.addClass("is-invalid")
                                }
                                if ("engineVolumeInvalid" in response) {
                                    engineVolumeInput.add("is-invalid")
                                }
                                $(this).removeAttr("disabled")
                                $("#create-button-spinner").attr("hidden", "true")
                                $("#create-button-text").text("Create")
                                $("input").removeAttr("disabled")
                                $("select").removeAttr("disabled")
                            }
                        }
                    )
                }
            })

            $("input").on("input", function () {
                $(this).removeClass("is-invalid")
            })
            $("select").on("change", function () {
                $(this).removeClass("is-invalid")
            })

            $("#engine-select").on("change", function () {
                if ($(this).val() === "4") { // electro engine
                    $("#engine-volume-input")
                        .attr("disabled", "true")
                        .val("0.0")
                        .removeClass("is-invalid")
                } else if ($("#engine-volume-input").attr("disabled") !== undefined) {
                    $("#engine-volume-input")
                        .removeAttr("disabled")
                        .val("")
                        .removeClass("is-invalid")
                }
            })
        })
    </script>

    <h1 class="page-title">New car</h1>

    <form class="container">
        <div class="row g-3">
            <div class="col-5 position-relative">
                <label for="make-input" class="form-label">Make</label>
                <input type="text" class="form-control" id="make-input" placeholder="Ford">
                <ul id="make-hints-list" class="list-group position-absolute top-100" style="height: 300px; overflow: auto" hidden></ul>
            </div>
            <div class="col-5 position-relative">
                <label for="model-input" class="form-label">Model</label>
                <input type="text" class="form-control" id="model-input" placeholder="F150">
                <ul id="model-hints-list" class="list-group position-absolute top-100" style="height: 300px; overflow: auto" hidden></ul>
            </div>
            <div class="col-2">
                <label for="year-input" class="form-label">Year</label>
                <input type="number" maxlength="4" class="form-control"
                       id="year-input" placeholder="2020">
            </div>
            <div class="col-4">
                <label for="body-select" class="form-label">Body</label>
                <select class="form-select" id="body-select">
                    <option value="-1" selected disabled>Choose body</option>
                    <#list bodies as body>
                        <option value="${body.id}">${body}</option>
                    </#list>
                </select>
            </div>
            <div class="col-4">
                <label for="transmission-select" class="form-label">Transmission</label>
                <select class="form-select" id="transmission-select">
                    <option value="-1" selected disabled>Choose transmission</option>
                    <#list transmissions as transmission>
                        <option value="${transmission.id}">${transmission}</option>
                    </#list>
                </select>
            </div>
            <div class="col-4">
                <label for="drive-select" class="form-label">Drive</label>
                <select class="form-select" id="drive-select">
                    <option value="-1" selected disabled>Choose drive</option>
                    <#list drives as drive>
                        <option value="${drive.id}">${drive}</option>
                    </#list>
                </select>
            </div>
            <div class="col-5">
                <label for="engine-select" class="form-label">Engine</label>
                <select class="form-select" id="engine-select">
                    <option value="-1" selected disabled>Choose engine</option>
                    <#list engines as engine>
                        <option value="${engine.id}">${engine}</option>
                    </#list>
                </select>
            </div>
            <div class="col-3">
                <label for="horsepower-input" class="form-label">Horsepower</label>
                <div class="input-group">
                    <input type="number" class="form-control"
                          id="horsepower-input">
                    <span class="input-group-text">hp</span>
                </div>
            </div>
            <div class="col-2">
                <label for="engine-volume-input" class="form-label">Engine volume</label>
                <div class="input-group">
                    <input type="number" class="form-control" id="engine-volume-input">
                    <span class="input-group-text">L</span>
                </div>
            </div>
            <div class="col-2">
                <label for="wheel-select" class="form-label">Wheel</label>
                <select class="form-select" id="wheel-select">
                    <option value="1" selected>Left</option>
                    <option value="2">Right</option>
                </select>
            </div>
        </div>
        <button id="create-button" type="button" class="btn btn-primary my-3">
            <span id="create-button-spinner" class="spinner-border spinner-border-sm" aria-hidden="true" hidden></span>
            <span id="create-button-text">Create</span>
        </button>
    </form>
</#macro>
