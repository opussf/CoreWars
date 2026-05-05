class CoreWars {
    static #instance = null;
    static memSize = 4096;
    static encodeInstruction = 2 ** 28;
    static encodeAMode       = 2 ** 26;   // # = 0 (immediate), none = 1 (relative), @ = 2 (indirect)
    static encodeBMode       = 2 ** 24;
    static encodeALoc        = 2 ** 12;
    static encodeBLoc        = 2 ** 0;
    static modes = {'#': 0, '': 1, '@': 2};

    static instructions = {
        dat: { val: 0, a: null, b: "value" },
        mov: { val: 1, a: "data", b: "loc" },
        add: { val: 2, a: "data", b: "loc" },
        sub: { val: 3, a: "data", b: "loc" },
        jmp: { val: 4, a: null, b: "loc" },
        jmz: { val: 5, a: "data", b: "loc" },
        djz: { val: 6, a: "data", b: "loc" },
        cmp: { val: 7, a: "data", b: "loc" },
    };

    constructor() {
        if (CoreWars.#instance) return CoreWars.#instance;
        this.core = new Uint32Array(CoreWars.memSize);
        this.flags = new Uint8Array(CoreWars.memSize);
        this.warriors = [[],[]];
        CoreWars.#instance = this;
    }

    static getInstance() {
        if (!CoreWars.#instance) new CoreWars();
        return CoreWars.#instance;
    }

    parseOperand(op) {
        // return { mode: int, value: int }
        if (!op) return null;
        const vals = op.match(/([#@]?)(-?\d+)/);
        if (!vals) return null;

        return {
            mode: CoreWars.modes[vals[1]],
            value: parseInt(vals[2])
        };
    }

    parseProgram(id, prog) {
        console.log(`ParseProgram( ${id}, ${prog} )`);
        let progLines = prog.toLowerCase().split("\n");
        console.log(progLines);
        this.warriors[id] = [];
        for (const line of progLines) {
            if (line.length === 0) continue;
            const symbols = line.split(/[\s,]+/);
            const inst = CoreWars.instructions[symbols[0]];
            let encoded = 0;
            encoded += inst.val * CoreWars.encodeInstruction;
            let opID = 1;
            if (inst.a !== null) {
                const opA = this.parseOperand(symbols[opID]);
                if (opA) {
                    encoded += opA.mode * CoreWars.encodeAMode;
                    encoded += opA.value * CoreWars.encodeALoc;
                    opID = 2;
                }
            }
            const opB = this.parseOperand(symbols[opID]);
            if (opB) {
                encoded += opB.mode * CoreWars.encodeBMode;
                encoded += opB.value * CoreWars.encodeBLoc;
            }

            this.warriors[id].push(encoded);
            console.log(symbols, encoded, this.warriors[id]);
        }
    }

}


/*
dat 0
add #4, -1
mov #0, @-2
jmp -2
*/
