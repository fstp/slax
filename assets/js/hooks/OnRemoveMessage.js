const OnRemoveMessage = {
  mounted() {
    this.handleEvent("fade_it", ({ id }) => {
      let element = document.getElementById(`messages-${id}`);
      console.log(id);

      if (element) {
        element.classList.remove("animate-popIn");
        element.classList.add("animate-fadeOut");
        console.log(element.classList);

        element.addEventListener("animationend", () => {
          element.remove();
        });
      }
    });
  }
}

export default OnRemoveMessage;
