class CoreWarsUI {
    constructor(canvas) {
        this.canvas = canvas;

        // get the context
        this.ctx = this.canvas.getContext("2d");
    }

    reset() {
        // init or reset the UI
        // Fill entire canvas black
        this.ctx.fillStyle = 'black';
        this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);

        // Draw white grid
        this.gridSize = this.canvas.height / 64;  // 64 ^ 2 = 4096
        this.ctx.strokeStyle = 'white';
        this.ctx.lineWidth = 1;

        // Vertical lines
        for (let x = 0; x <= this.canvas.width; x += this.gridSize) {
            this.ctx.beginPath();
            this.ctx.moveTo(x, 0);
            this.ctx.lineTo(x, this.canvas.height);
            this.ctx.stroke();
        }

        // Horizontal lines
        for (let y = 0; y <= this.canvas.height; y += this.gridSize) {
            this.ctx.beginPath();
            this.ctx.moveTo(0, y);
            this.ctx.lineTo(this.canvas.width, y);
            this.ctx.stroke();
        }
    }
}
