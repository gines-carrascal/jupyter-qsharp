namespace Quantum.Vedral {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;

    operation Adder () : Int {
        Message("Starting adder!");
        let n = 4;
        let sumando_1 = ["0","0","0","1"];//Microsoft.Quantum.Convert.IntAsBoolArray(1, n);
        let sumando_2 = ["0","0","0","1"];//Microsoft.Quantum.Convert.IntAsBoolArray(1, n);
        mutable result = 0;
        
        using (qs = Qubit[n * 2 + 2]){


            let a = qs[0..n-1];
            let b = qs[n..2*n];
            let c = qs[2*n+1];
        
            
            for (i in 0..n-1){
                if (sumando_1[i]=="1"){       
                    X(a[n - (i+1)]);
                }
            }
            for (i in 0..n-1){
                if (sumando_2[i]=="1"){
                    X(b[n - (i+1)]);
                }
            }

            for (i in 1..n-1){
                CNOT(a[i], b[i]);
            }

            CNOT(a[1], c[0]);

            CCNOT(a[0], b[0], c[0]);
            CNOT(a[2], a[1]);

            CCNOT(c[0], b[1], a[1]);
            CNOT(a[3], a[2]);

            for (i in 2..n-3){
                CCNOT(a[i-1], b[i], a[i]);
                CNOT(a[i+2], a[i+1]);
            }

            CCNOT(a[n-3], b[n-2], a[n-2]);
            CNOT(a[n-1], b[n]);

            CCNOT(a[n-2], b[n-1], b[n]);
            for (i in 1..n-2){
                X(b[i]);
            }

            CNOT(c[0], b[1]);
            for (i in 2..n-1){
                CNOT(a[i-1], b[i]);
            }

            CCNOT(a[n-3], b[n-2], a[n-2]);

            for (i = n-3; i > 1; i--){
                CCNOT(a[i-1], b[i], a[i]);
                CNOT(a[i+2], a[i+1]);
                X(b[i+1]);
            }

            CCNOT(c[0], b[1], a[1]);
            CNOT(a[3], a[2]);
            X(b[2]);

            CCNOT(a[0], b[0], c[0]);
            CNOT(a[2], a[1]);
            X(b[1]);

            CNOT(a[1], c[0]);

            for (i in 0..n-1){
                CNOT(a[i], b[i]);
            }

            set result = MeasureInteger(LittleEndian(b));

            ResetAll(qs);

        }
        return result;
    }
}