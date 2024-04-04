<#include "base.ftl">

<#macro title>Advertisements</#macro>

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
            $("#filter-collapse-btn").on("click", function () {
                if ($(this).hasClass("collapsed")) { // collapse was collapsed
                    $(this)
                        .removeClass("btn-primary")
                        .addClass("btn-outline-primary")
                } else {
                    $(this)
                        .removeClass("btn-outline-primary")
                        .addClass("btn-primary")
                }
            })
            $("#clear-filter-btn").on("click", function () {
                $("input:not([type=checkbox])").val(null)
                $("#exchange-select").val("-1")
                $("input[type=checkbox]").prop("checked", "")
            })

            $("#filter-btn").on("click", function () {
                const makeInput = $("#make-input")
                const modelInput = $("#model-input")
                const yearFromInput = $("#year-from-input")
                const yearToInput = $("#year-to-input")
                const engineVolumeFromInput = $("#engine-volume-from-input")
                const engineVolumeToInput = $("#engine-volume-to-input")
                const horsepowerFromInput = $("#horsepower-from-input")
                const horsepowerToInput = $("#horsepower-to-input")
                const priceFromInput = $("#price-from-input")
                const priceToInput = $("#price-to-input")
                const mileageFromInput = $("#mileage-from-input")
                const mileageToInput = $("#mileage-to-input")
                const ownersFromInput = $("#owners-from-input")
                const ownersToInput = $("#owners-to-input")
                const exchangeSelect = $("#exchange-select")
                const wheelSelect = $("#wheel-select")
                const sortSelect = $("#sort-select")

                let formValid = true;
                if (yearFromInput.val().trim() && !isNumeric(yearFromInput.val().trim())) {
                    yearFromInput.addClass("is-invalid")
                    formValid = false;
                }
                if (yearToInput.val().trim() && !isNumeric(yearToInput.val().trim())) {
                    yearToInput.addClass("is-invalid")
                    formValid = false;
                }
                if (engineVolumeFromInput.val().trim() && !isNumeric(engineVolumeFromInput.val().trim())) {
                    engineVolumeFromInput.addClass("is-invalid")
                    formValid = false;
                }
                if (engineVolumeToInput.val().trim() && !isNumeric(engineVolumeToInput.val().trim())) {
                    engineVolumeToInput.addClass("is-invalid")
                    formValid = false;
                }
                if (horsepowerFromInput.val().trim() && !isNumeric(horsepowerFromInput.val().trim())) {
                    horsepowerFromInput.addClass("is-invalid")
                    formValid = false;
                }
                if (horsepowerToInput.val().trim() && !isNumeric(horsepowerToInput.val().trim())) {
                    horsepowerToInput.addClass("is-invalid")
                    formValid = false;
                }
                if (priceFromInput.val().trim() && !isNumeric(priceFromInput.val().trim())) {
                    priceFromInput.addClass("is-invalid")
                    formValid = false;
                }
                if (priceToInput.val().trim() && !isNumeric(priceToInput.val().trim())) {
                    priceToInput.addClass("is-invalid")
                    formValid = false;
                }
                if (mileageFromInput.val().trim() && !isNumeric(mileageFromInput.val().trim())) {
                    mileageFromInput.addClass("is-invalid")
                    formValid = false;
                }
                if (mileageToInput.val().trim() && !isNumeric(mileageToInput.val().trim())) {
                    mileageToInput.addClass("is-invalid")
                    formValid = false;
                }
                if (ownersFromInput.val().trim() && !isNumeric(ownersFromInput.val().trim())) {
                    ownersFromInput.addClass("is-invalid")
                    formValid = false;
                }
                if (ownersToInput.val().trim() && !isNumeric(ownersToInput.val().trim())) {
                    ownersToInput.addClass("is-invalid")
                    formValid = false;
                }
                if (exchangeSelect.val() === null) {
                    exchangeSelect.addClass("is-invalid")
                    formValid = false;
                }
                if (wheelSelect.val() === null) {
                    wheelSelect.addClass("is-invalid")
                    formValid = false;
                }

                if (formValid) {
                    let urlParams = "?"
                    if (makeInput.val().trim()) {
                        urlParams += "make=" + makeInput.val().trim() + "&"
                    }
                    if (modelInput.val().trim()) {
                        urlParams += "model=" + modelInput.val().trim() + "&"
                    }
                    if (yearFromInput.val().trim()) {
                        urlParams += "yearFrom=" + yearFromInput.val().trim() + "&"
                    }
                    if (yearToInput.val().trim()) {
                        urlParams += "yearTo=" + yearToInput.val().trim() + "&"
                    }
                    if (engineVolumeFromInput.val().trim()) {
                        urlParams += "engineVolumeFrom=" + engineVolumeFromInput.val().trim() + "&"
                    }
                    if (engineVolumeToInput.val().trim()) {
                        urlParams += "engineVolumeTo=" + engineVolumeToInput.val().trim() + "&"
                    }
                    if (horsepowerFromInput.val().trim()) {
                        urlParams += "horsepowerFrom=" + horsepowerFromInput.val().trim() + "&"
                    }
                    if (horsepowerToInput.val().trim()) {
                        urlParams += "horsepowerTo=" + horsepowerToInput.val().trim() + "&"
                    }
                    if (priceFromInput.val().trim()) {
                        urlParams += "priceFrom=" + priceFromInput.val().trim() + "&"
                    }
                    if (priceToInput.val().trim()) {
                        urlParams += "priceTo=" + priceToInput.val().trim() + "&"
                    }
                    if (mileageFromInput.val().trim()) {
                        urlParams += "mileageFrom=" + mileageFromInput.val().trim() + "&"
                    }
                    if (mileageToInput.val().trim()) {
                        urlParams += "mileageTo=" + mileageToInput.val().trim() + "&"
                    }
                    if (ownersFromInput.val().trim()) {
                        urlParams += "ownersFrom=" + ownersFromInput.val().trim() + "&"
                    }
                    if (ownersToInput.val().trim()) {
                        urlParams += "ownersTo=" + ownersToInput.val().trim() + "&"
                    }
                    if (exchangeSelect.val() === "1") {
                        urlParams += "exchangeAllowed=true&"
                    }
                    if (wheelSelect.val() === "1") {
                        urlParams += "leftWheel=true&"
                    } else if (wheelSelect.val() === "2") {
                        urlParams += "leftWheel=false&"
                    }
                    urlParams += getCheckboxesAsUrlParam(".condition-checkbox", "conditions") + "&"
                    urlParams += getCheckboxesAsUrlParam(".body-checkbox", "bodies") + "&"
                    urlParams += getCheckboxesAsUrlParam(".transmission-checkbox", "transmissions") + "&"
                    urlParams += getCheckboxesAsUrlParam(".engine-checkbox", "engines") + "&"
                    urlParams += getCheckboxesAsUrlParam(".drive-checkbox", "drives") + "&"
                    if (sortSelect.val()) {
                        urlParams += "sorting=" + sortSelect.val() + "&"
                    }
                    if ($("#desc-radio")[0].checked) {
                        urlParams += "desc=true"
                    } else if ($("#asc-radio")[0].checked) {
                        urlParams += "desc=false"
                    }

                    window.location.replace("${rc.getContextPath()}/advertisements" + urlParams)
                }
            })
        })

        function getCheckboxesAsUrlParam(selector, paramName) {
            let urlParam = paramName + "="
            let addComma = false
            $.each($(selector), function (index, checkbox) {
                if (checkbox.checked) {
                    if (addComma) {
                        urlParam += "," + checkbox.value
                    } else {
                        urlParam += checkbox.value
                        addComma = true
                    }
                }
            })
            return urlParam
        }
    </script>

    <h1 class="page-title">Advertisements</h1>

    <div class="container">
        <button id="filter-collapse-btn" class="btn btn-outline-primary mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#filter-collapse">
            <i class="bi bi-filter me-1"></i>
            <span>Filters</span>
        </button>

        <div class="collapse" id="filter-collapse">
            <div class="card card-body mb-3">
                <div class="row mb-3">
                    <div class="col-md-3 position-relative">
                        <label for="make-input" class="form-label">Make</label>
                        <input type="text" class="form-control" id="make-input" value="${filter.make!}">
                        <ul id="make-hints-list" class="list-group position-absolute top-100 z-3" style="height: 300px; overflow: auto" hidden></ul>
                    </div>
                    <div class="col-md-3 position-relative">
                        <label for="model-input" class="form-label">Model</label>
                        <input type="text" class="form-control" id="model-input" value="${filter.model!}">
                        <ul id="model-hints-list" class="list-group position-absolute top-100 z-3" style="height: 300px; overflow: auto" hidden></ul>
                    </div>
                    <div class="col-md-3">
                        <label for="year-from-input" class="form-label">Year from</label>
                        <input type="number" class="form-control" maxlength="4" id="year-from-input" value="${filter.yearFrom!?c}">
                    </div>
                    <div class="col-md-3">
                        <label for="year-to-input" class="form-label">Year to</label>
                        <input type="number" class="form-control" maxlength="4" id="year-to-input" value="${filter.yearTo!?c}">
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="engine-volume-from-input" class="form-label">Engine volume from</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="engine-volume-from-input" value="${filter.engineVolumeFrom!?c}">
                            <span class="input-group-text">L</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="engine-volume-to-input" class="form-label">Engine volume to</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="engine-volume-to-input" value="${filter.engineVolumeTo!?c}">
                            <span class="input-group-text">L</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="horsepower-from-input" class="form-label">Horsepower from</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="horsepower-from-input" value="${filter.horsepowerFrom!?c}">
                            <span class="input-group-text">hp</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="horsepower-to-input" class="form-label">Horsepower to</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="horsepower-to-input" value="${filter.horsepowerTo!?c}">
                            <span class="input-group-text">hp</span>
                        </div>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="form-label d-block">Body</label>
                    <div class="btn-group" role="group">
                        <#list bodies as body>
                            <input type="checkbox" class="btn-check body-checkbox" id="body-check-${body.id}" autocomplete="off" value="${body.id}" <#if filter.bodies?? && filter.bodies?seq_contains(body)>checked</#if>>
                            <label class="btn btn-outline-primary" for="body-check-${body.id}">${body}</label>
                        </#list>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="form-label d-block">Transmission</label>
                    <div class="btn-group" role="group">
                        <#list transmissions as transmission>
                            <input type="checkbox" class="btn-check transmission-checkbox" id="transmission-check-${transmission.id}" autocomplete="off" value="${transmission.id}" <#if filter.transmissions?? && filter.transmissions?seq_contains(transmission)>checked</#if>>
                            <label class="btn btn-outline-primary" for="transmission-check-${transmission.id}">${transmission}</label>
                        </#list>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="form-label d-block">Engine</label>
                    <div class="btn-group" role="group">
                        <#list engines as engine>
                            <input type="checkbox" class="btn-check engine-checkbox" id="engine-check-${engine.id}" autocomplete="off" value="${engine.id}" <#if filter.engines?? && filter.engines?seq_contains(engine)>checked</#if>>
                            <label class="btn btn-outline-primary" for="engine-check-${engine.id}">${engine}</label>
                        </#list>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="form-label d-block">Drive</label>
                    <div class="btn-group" role="group">
                        <#list drives as drive>
                            <input type="checkbox" class="btn-check drive-checkbox" id="drive-check-${drive.id}" autocomplete="off" value="${drive.id}" <#if filter.drives?? && filter.drives?seq_contains(drive)>checked</#if>>
                            <label class="btn btn-outline-primary" for="drive-check-${drive.id}">${drive}</label>
                        </#list>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="price-from-input" class="form-label">Price from</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="price-from-input" value="${filter.priceFrom!?c}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="price-to-input" class="form-label">Price to</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="price-to-input" value="${filter.priceTo!?c}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="mileage-from-input" class="form-label">Mileage from</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="mileage-from-input" value="${filter.mileageFrom!?c}">
                            <span class="input-group-text">km</span>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label for="mileage-to-input" class="form-label">Mileage to</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="mileage-to-input" value="${filter.mileageTo!?c}">
                            <span class="input-group-text">km</span>
                        </div>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="owners-from-input" class="form-label">Owners from</label>
                        <input type="number" class="form-control" id="owners-from-input" value="${filter.ownersFrom!?c}">
                    </div>
                    <div class="col-md-3">
                        <label for="owners-to-input" class="form-label">Owners to</label>
                        <input type="number" class="form-control" id="owners-to-input" value="${filter.ownersTo!?c}">
                    </div>
                    <div class="col-md-3">
                        <label for="exchange-select" class="form-label">Exchange</label>
                        <select id="exchange-select" class="form-select">
                            <option value="-1">
                                Doesn't matter
                            </option>
                            <option value="1" <#if filter.exchangeAllowed?? && filter.exchangeAllowed>selected</#if>>
                                Allowed
                            </option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="wheel-select" class="form-label">Wheel</label>
                        <select id="wheel-select" class="form-select">
                            <option value="-1">
                                Doesn't matter
                            </option>
                            <option value="1" <#if filter.exchangeAllowed?? && filter.leftWheel>selected</#if>>
                                Left
                            </option>
                            <option value="2" <#if filter.exchangeAllowed?? && !filter.leftWheel>selected</#if>>
                                Right
                            </option>
                        </select>
                    </div>
                </div>
                <div class="row mb-5">
                    <label class="form-label d-block">Condition</label>
                    <div class="btn-group" role="group">
                        <#list conditions as condition>
                            <input type="checkbox" class="btn-check condition-checkbox" id="condition-check-${condition.id}" autocomplete="off" value="${condition.id}" <#if filter.conditions?? && filter.conditions?seq_contains(condition)>checked</#if>>
                            <label class="btn btn-outline-primary" for="condition-check-${condition.id}">${condition}</label>
                        </#list>
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <div>
                        <button type="button" id="filter-btn" class="btn btn-outline-primary me-2">
                            Filter
                        </button>
                        <button type="button" id="clear-filter-btn" class="btn btn-outline-danger">
                            Clear filter
                        </button>
                    </div>
                    <div class="row g-3 align-items-center">
                        <div class="col-auto">
                            <label for="sort-select" class="col-form-label">Sort by</label>
                        </div>
                        <div class="col-auto">
                            <select id="sort-select" class="form-select">
                                <#list sortings as sort>
                                    <option value="${sort.id}" <#if filter.sorting?? && filter.sorting.id == sort.id>selected</#if>>
                                        ${sort}
                                    </option>
                                </#list>
                            </select>
                        </div>
                        <div class="col-auto">
                            <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" name="sorting-radio" id="desc-radio" autocomplete="off" <#if filter.sorting?? && filter.sorting.desc>checked</#if>>
                                <label class="btn btn-outline-primary" for="desc-radio">
                                    <i class="bi bi-sort-down"></i>
                                </label>

                                <input type="radio" class="btn-check" name="sorting-radio" id="asc-radio" autocomplete="off" <#if filter.sorting?? && !filter.sorting.desc>checked</#if>>
                                <label class="btn btn-outline-primary" for="asc-radio">
                                    <i class="bi bi-sort-down-alt"></i>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="advertisements-list">
            <#list advertisements as ad>
                <a href="${rc.getContextPath()}/advertisements?id=${ad.id}"
                   style="text-decoration: none">
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
            <#else>
                <p class="text-center">
                    There are no advertisements matching the filter.
                </p>
            </#list>
        </div>
    </div>
</#macro>
