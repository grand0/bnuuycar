$(document).ready(() => {
    $("input[type=number]").on("input", (event) => {
        const target = $(event.target)
        const max = parseInt(target.attr("maxlength"))
        if (!isNaN(max)) {
            if (target.val().length > max) {
                target.val(target.val().substring(0, max))
            }
        }
    })
})
