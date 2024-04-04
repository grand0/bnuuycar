<#include "base.ftl">

<#macro title>Chat</#macro>

<#macro content>
    <script>
        function sendMessage() {
            let msgInput = $("#msg-input")
            if (msgInput.val()) {
                let msg = msgInput.val()
                msgInput.val("")
                $("#send-btn").attr("disabled", "true")
                $.post(
                    "${rc.getContextPath()}/chat",
                    {
                        "adId": ${ad.id},
                        "recipientId": ${recipient.id},
                        "message": msg
                    },
                    function (response) {
                        if ("unauthorized" in response) {
                            window.location.replace("${rc.getContextPath()}/auth")
                        }
                        console.log(response)
                        $("#messages-list").prepend(toMsgBlock(response.message))
                    },
                    "json"
                )
            }
        }

        function toMsgBlock(msg) {
            let name = $("<strong></strong>")
                .addClass("d-block")
                .text(msg.sender.firstName + " " + msg.sender.lastName)
            let msgText = $("<span></span>")
                .addClass("d-block")
                .text(msg.message)
            let sent = $("<span></span>")
                .addClass("text-secondary")
                .text(msg.sentDateTime + " ")
            let check = $("<i></i>")
                .addClass("bi")
            if (msg.read) {
                check.addClass("bi-check-all")
            } else {
                check.addClass("bi-check")
            }
            let block = $("<div></div>")
                .addClass("message")
                .append(name)
                .append(msgText)
                .append(sent)
            if (msg.sender.id == ${user.id}) {
                block
                    .append(check)
                    .addClass("my-message")
            } else {
                block.addClass("others-message")
            }
            return block
        }

        $(document).ready(function() {
            let timerId = setInterval(() => {
                $.get(
                    "${rc.getContextPath()}/chat?ad_id=${ad.id}&recipient_id=${recipient.id}&format=json",
                    function (response) {
                        if ("unauthorized" in response) {
                            window.location.replace("${rc.getContextPath()}/auth");
                        }
                        $("#messages-list").empty()
                        $.each(response.messages, function (index, msg) {
                            $("#messages-list").append(toMsgBlock(msg))
                        })
                    },
                    "json"
                )
            }, 3000)
            let msgList = $("#messages-list")
            msgList.scrollTop(msgList[0].scrollHeight)

            $("#send-btn").on("click", sendMessage)

            $("#msg-input")
                .on("input", function () {
                    if (!$(this).val()) {
                        $("#send-btn").attr("disabled", "true")
                    } else {
                        $("#send-btn").removeAttr("disabled")
                    }
                })
                .on("keypress", (event) => {
                    if (event.which === 13) {
                        sendMessage()
                    }
                })
        })
    </script>

    <h1 class="page-title">Chat with <#if recipient.id == ad.seller.id>seller<#else>buyer</#if></h1>

    <div class="container mb-3">
        <div class="card">
            <div class="card-header d-flex align-items-center justify-content-between">
                <div>
                    <img src="${ad.imagesUrls[0]}" alt="ad image" width="133" height="75" class="me-3" style="object-fit: cover; border-radius: 0.375em">
                    <span>${ad}</span>
                </div>
                <div>
                    <a href="${rc.getContextPath()}/advertisements?id=${ad.id}" class="icon-link">
                        <i class="bi bi-card-heading"></i>
                        <span>View ad</span>
                    </a>
                </div>
            </div>
            <div class="card-header d-flex align-items-center justify-content-between">
                <div>
                    <#if (recipient.avatarUrl)??>
                        <img src="${recipient.getRoundCroppedAvatarUrl()}" alt="user avatar" class="me-3" width="50" height="50">
                    <#else>
                        <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 16 16" width="50" height="50" class="bi bi-person-circle me-3">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
                        </svg>
                    </#if>
                    <span>${recipient}</span>
                </div>
                <div>
                    <a class="icon-link" href="${rc.getContextPath()}/profile?id=${recipient.id}">
                        <i class="bi bi-person-fill"></i>
                        View profile
                    </a>
                </div>
            </div>
            <div class="card-body">
                <div class="input-group mb-3">
                    <input id="msg-input" class="form-control" type="text"
                           maxlength="2000" placeholder="Message...">
                    <button href="#" id="send-btn"
                            class="btn btn-primary input-group-text" disabled>Send</button>
                </div>
                <div style="overflow-y: scroll; overflow-x: auto; height: 50vh">
                    <div id="messages-list">
                        <#list messages as msg>
                            <div class="message <#if msg.sender.id == user.id>my-message<#else>others-message</#if>">
                                <strong class="d-block">${msg.sender}</strong>
                                <span class="d-block">${msg}</span>
                                <span class="text-secondary">${msg.sentDateTime}</span>
                                <#if msg.sender.id == user.id>
                                    <#if msg.isRead()>
                                        <i class="bi bi-check-all"></i>
                                    <#else>
                                        <i class="bi bi-check"></i>
                                    </#if>
                                </#if>
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
        </div>
    </div>
</#macro>
