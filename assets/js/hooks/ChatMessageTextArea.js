/*
 * We need to manually trigger a "change" event before the "submit" event to avoid a bug.
 * If we don’t manually trigger a "change" event, Phoenix will send one anyway as specified by
 * the phx-change attribute - but it will be delayed by at least 300ms because of the phx-debounce.
 * So that change event would be fired after the manual "submit" has already been handled. This would
 * override the value of @new_message_form and prevent the <textarea>’s value from being reset after the
 * new message is sent.
 */
const ChatMessageTextArea = {
  mounted() {
    this.el.addEventListener('keydown', e => {
      if (e.key === 'Enter' && !e.shiftKey) {
        const form = document.getElementById("new-message-form");
        form.dispatchEvent(new Event("change", {bubbles: true, cancelable: true}));
        form.dispatchEvent(new Event("submit", {bubbles: true, cancelable: true}));
      }
    });
  }
};

export default ChatMessageTextArea;
