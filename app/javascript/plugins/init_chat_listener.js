import { initChatRoomCable } from "../channels/chat_room_channel";

const init_chat_listener = () => {
  const display = document.getElementById("chat-display");
  const linkouts = document.querySelectorAll(".linkout");
  const linkin = document.querySelector(".linkin");

  linkouts.forEach(link => {
    link.addEventListener('click', function handleClick(event) {
      event.preventDefault();
      const url = link.href;
      fetch(url, { headers: { 'Accept': 'text/plain' } })
        .then(response => response.text())
        .then((data) => {
          display.innerHTML = data;
          initChatRoomCable();
        })
    });

  });

  addEventListener('click', (event) => {
    // console.log(event);
  });

}

export { init_chat_listener };
