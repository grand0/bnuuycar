function waitAndCheckFocusOnMakeList() {
    setTimeout(
        () => {
            let listFocused = false
            $(".make-item").each((i, e) => listFocused = listFocused || $(e).is(":focus"))
            if (!listFocused) {
                $("#make-hints-list").attr("hidden", "true")
            }
        },
        300
    )
}

function waitAndCheckFocusOnModelList() {
    setTimeout(
        () => {
            let listFocused = false
            $(".model-item").each((i, e) => listFocused = listFocused || $(e).is(":focus"))
            if (!listFocused) {
                $("#model-hints-list").attr("hidden", "true")
            }
        },
        300
    )
}

$(document).ready(() => {
    const contextPath = JSON.parse($("#data").text()).contextPath

    $("#make-input")
        .on("focusin", function () {
            $("#make-hints-list").removeAttr("hidden")
        })
        .on("focusout", function () {
            waitAndCheckFocusOnMakeList()
        })
        .on("input", function () {
            const makeHintsList = $("#make-hints-list")
            makeHintsList.empty()
            if ($(this).val().trim()) {
                $.get(
                    contextPath + "/hints",
                    {
                        "action": "getMakes",
                        "query": $(this).val().trim()
                    },
                    function (response) {
                        $.each(response.makes, function (index, make) {
                            const btn = $("<button></button>")
                                .attr("type", "button")
                                .addClass("list-group-item")
                                .addClass("list-group-item-action")
                                .addClass("make-item")
                                .text(make)
                                .on("click", function () {
                                    $("#make-input").val(make)
                                    $("#make-hints-list").attr("hidden", "true")
                                })
                            makeHintsList.append(btn)
                        })
                    }
                )
            }
        })

    $("#model-input")
        .on("focusin", function () {
            $("#model-hints-list").removeAttr("hidden")
        })
        .on("focusout", function () {
            waitAndCheckFocusOnModelList()
        })
        .on("input", function () {
            const modelHintsList = $("#model-hints-list")
            modelHintsList.empty()
            if ($(this).val().trim()) {
                $.get(
                    contextPath + "/hints",
                    {
                        "action": "getModels",
                        "make": $("#make-input").val().trim(),
                        "query": $(this).val().trim()
                    },
                    function (response) {
                        $.each(response.models, function (index, model) {
                            const btn = $("<button></button>")
                                .attr("type", "button")
                                .addClass("list-group-item")
                                .addClass("list-group-item-action")
                                .addClass("model-item")
                                .text(model)
                                .on("click", function () {
                                    $("#model-input").val(model)
                                    $("#model-hints-list").attr("hidden", "true")
                                })
                            modelHintsList.append(btn)
                        })
                    }
                )
            }
        })
})
