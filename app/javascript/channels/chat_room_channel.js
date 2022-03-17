import consumer from "./consumer";

const initChatRoomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatRoomId;
    const input = document.getElementById("messager");
    consumer.subscriptions.create({ channel: "ChatRoomChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
        input.value = "";
        messagesContainer.scrollTo(0, messagesContainer.scrollHeight);
      },
    });
  }
}

export { initChatRoomCable };
