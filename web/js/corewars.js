class CoreWars {
    static #instance = null;
    static memSize = 4096;

    static instructions = {
        dat: { val: 0, a: null, b: "value" },
        mov: { val: 1, a: data, b: loc },
        add: { val: 2, a: data, b: loc }
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

    parseProgram(id, prog) {
        console.log("ParseProgram( ${id}, ${prog} )");
    }

}
