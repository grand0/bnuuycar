<#include "base.ftl">

<#macro title>Error</#macro>

<#macro content>
    <script>
        const bgUrls = [
            "https://media.giphy.com/media/5kFbMBOEdWjg1nItoG/giphy.gif",
            "https://media.giphy.com/media/3o7aCRBaUv3Sng0rTy/giphy.gif",
            "https://media.giphy.com/media/3og0IEmNX1j2AuplJK/giphy.gif",
            "https://media.giphy.com/media/3oz8xF2tbONaIIy92M/giphy.gif",
            "https://media.giphy.com/media/3Fpe0mIR5Y7MyCcxse/giphy.gif",
            "https://media.giphy.com/media/l1J9zRn3SyIRsySti/giphy.gif",
            "https://media.giphy.com/media/xUOxeQkDWcfWGiTevu/giphy.gif",
            "https://media.giphy.com/media/aqS9Eew6JEvyL53pJE/giphy.gif",
        ]

        function changeStatusCodeBg() {
            let index = Math.floor(Math.random() * bgUrls.length)
            $("#status-code").css("background-image", "url(" + bgUrls[index] + ")")
        }

        $(document).ready(() => {
            changeStatusCodeBg()
            $("#status-code")
                .on("click", () => {
                    changeStatusCodeBg()
                })
        })
    </script>

    <div class="container text-center">
        <h1 id="status-code">${statusCode}</h1>
        <h2 class="mb-3">
            <#if statusCode == 404>
                Page not found
            <#else>
                There was an error
            </#if>
        </h2>
        <p>
            <#if statusCode gte 500 && statusCode lt 600>
                It's not you, it's me...
            <#elseif statusCode == 404>
                Whatever you were trying to find is not there...
            </#if>
        </p>
        <a id="error-home-btn" class="btn btn-primary" href="${rc.getContextPath()}/">
            Take me outta here
        </a>
        <div class="accordion mb-3" id="info-accordion">
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#info-collapse">
                        Show more info
                    </button>
                </h2>
                <div id="info-collapse" class="accordion-collapse collapse text-start" data-bs-parent="#info-accordion">
                    <div class="accordion-body">
                        <strong>URI requested: </strong>${requestUri}
                        <br>
                        <#if exception??>
                            <strong>Exception: </strong>${exception}
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</#macro>
