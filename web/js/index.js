let cwCanvas;
let memSize = 4096;

function corewars_onload() {
    // the body onload
    cwCanvas = document.getElementById("corewarsfield")

    // to start, I'm going to work on square canvas
    ctx = cwCanvas.getContext("2d");

    // Fill entire canvas black
    ctx.fillStyle = 'black';
    ctx.fillRect(0, 0, cwCanvas.width, cwCanvas.height);

    // Draw white grid
    const gridSize = cwCanvas.height / 64  // 64^2 = 4096
    ctx.strokeStyle = 'white';
    ctx.lineWidth = 1;

    // Vertical lines
    for (let x = 0; x <= cwCanvas.width; x += gridSize) {
        ctx.beginPath();
        ctx.moveTo(x, 0);
        ctx.lineTo(x, cwCanvas.height);
        ctx.stroke();
    }

    // Horizontal lines
    for (let y = 0; y <= cwCanvas.height; y += gridSize) {
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(cwCanvas.width, y);
      ctx.stroke();
    }
}

function corewars_prog(id) {
    console.log(id.id)
    console.log(id.value)
}

function corewars_run() {

}

function corewars_stop() {

}