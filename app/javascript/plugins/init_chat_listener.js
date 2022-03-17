import { initChatRoomCable } from "../channels/chat_room_channel";

const init_chat_listener = () => {
  const display = document.getElementById("chat-display");
  const linkouts = document.querySelectorAll(".linkout");


  linkouts.forEach(link => {
    link.addEventListener('click', function handleClick(event) {
      event.preventDefault();
      const url = link.href;
      fetch(url, { headers: { 'Accept': 'text/plain' } })
        .then(response => response.text())
        .then((data) => {
          display.innerHTML = data;
          initChatRoomCable();
          let flatText = document.getElementById('flat').textContent;
          document.getElementById('user').textContent = flatText.split('•')[0];
          const messages = document.getElementById("messages");
          messages.scrollTo(0, messages.scrollHeight);
        })
    });

  });

  addEventListener('click', (event) => {
    // console.log(event);
  });

}

export { init_chat_listener };
