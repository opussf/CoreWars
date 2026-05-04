let cw = new CoreWars();
let cwUI;

function corewars_onload() {
    // the body onload
    cwUI = new CoreWarsUI(document.getElementById("corewarsfield"));

    cwUI.reset();
}

function corewars_prog(id) {
    console.log(id.id);
    console.log(id.value);

}
function corewars_run() {

}
function corewars_stop() {

}
