class CoreWars {
    static #instance = null;
    static memSize = 4096;

    static instructions = {
        dat: { val: 0 },
        mov: { val: 1 }
    };

    constructor() {
        if (CoreWars.#instance) return CoreWars.#instance;
        this.mem = new Uint32Array(CoreWars.memSize);
        this.flags = new Uint8Array(CoreWars.memSize);
        CoreWars.#instance = this;
    }

    static getInstance() {
        if (!CoreWars.#instance) new CoreWars();
        return CoreWars.#instance;
    }
}

