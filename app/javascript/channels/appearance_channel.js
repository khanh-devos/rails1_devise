import consumer from "channels/consumer"

let properties = {
  // Called once when the subscription is created.
  // Both statuses: connect or disconnect is shown

  initialized() {    
    this.update = this.update.bind(this)
  },

  // Called when the subscription is ready for use on the server.
  connected() {
    console.log("connected");
    this.install()
    this.update()


  },

  // Called when the WebSocket connection is closed.
  disconnected() {
    this.uninstall()
    console.log("disconnected");
    
  },

  // Called when the subscription is rejected by the server.
  rejected() {
    this.uninstall()

  },

  update() {
    document.hasFocus() ? this.appear() : this.away();
  },

  appear() {
    // Calls `AppearanceChannel#appear(data)` on the server.

    //this.perform("appear", { appearing_on: this.appearingOn })
    this.perform("appear", { appearing_on: "available" })
   
  },

  away() {
    // Calls `AppearanceChannel#away` on the server.
    this.perform("away", { appearing_on: "away" })

  },

  install() {
    window.addEventListener("focus", this.update)
    window.addEventListener("blur", this.update)
    document.addEventListener("visibilitychange", this.update)
    document.addEventListener("turbolinks:load", this.update)

  },

  uninstall() {
    
    window.removeEventListener("focus", this.update)
    window.removeEventListener("blur", this.update)
    document.removeEventListener("visibilitychange", this.update)
    document.removeEventListener("turbolinks:load", this.update)
    
  },

  //for appearing state
  received(data) {
    
    //update state
    let e = document.querySelector(`[data_appearing_on="${data["sent_by"]}"]`)
    e.textContent = data["body"]

  }
}


consumer.subscriptions.create(
  {channel: "AppearanceChannel", id: "Room1" }, 
  properties 
);


// function extractIDs(cookie){
//   for (let i=0; i < cookie.length; i++) {
//     if (cookie[i].includes("user_ids")){
//       let ids = cookie[i].split("=")[1].split("_")
//       // console.log(ids)
//       return ids
//     }
//   }
// }

// let user_ids = extractIDs(document.cookie.split("; "));

// if (user_ids){
//   for (let i=0; i < user_ids.length; i++){

//     consumer.subscriptions.create(
//       {channel: "AppearanceChannel", id: user_ids[i] }, properties );
//   }
// }