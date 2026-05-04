class CoreWars {
    static frank
    static memSize = 4096;

    static instructions = {
        dat: { val: 0 },
        mov: { val: 1 }
    };

    constructor() {
        if (CoreWars._instance) return CoreWars._instance;
        this.mem = new Uint32Array(CoreWars.memSize);
        this.flags = new Uint8Array(CoreWars.memSize);
        CoreWars._instance = this;
    }

    static getInstance() {
        if (!CoreWars._instance) new CoreWars();
        return CoreWars._instance;
    }
}

