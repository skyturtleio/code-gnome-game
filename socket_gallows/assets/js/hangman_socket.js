import {Socket} from "phoenix"

export default class HangmanSocket {

  constructor() {
    this.socket = new Socket("/socket", {})
    console.dir(this.socket)
  }
}
