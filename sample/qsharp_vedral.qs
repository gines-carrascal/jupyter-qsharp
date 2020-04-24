namespace Quantum.Vedral {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;

    operation Adder () : Int {
        Message("Starting adder!");
        let n = 4;
        let sumando_1 = ["0","0","0","1"];//Microsoft.Quantum.Convert.IntAsBoolArray(1, n);
        let sumando_2 = ["0","0","0","1"];//Microsoft.Quantum.Convert.IntAsBoolArray(1, n);
        mutable result = 0;
        
        using (qs = Qubit[n * 3 + 1]){


            let a = qs[0..n-1];
            let b = qs[n..2*n];
            let c = qs[2*n+1..3*n];
        
            
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
        
            for (i in 0..n-2){
                CCNOT(a[i], b[i], c[i+1]);
                CNOT(a[i], b[i]);
                CCNOT(a[i], b[i], c[i+1]);
            }

            CCNOT(a[n-1], b[n-1], b[n]);
            CNOT(a[n-1], b[n-1]);
            CCNOT(a[n-1], b[n-1], b[n]);  

            CNOT(c[n-1], b[n-1]);

            for (i in 0..n-2){
                CCNOT(c[(n-2)-i], b[(n-2)-i], c[(n-1)-i]);
                CNOT(a[(n-2)-i], b[(n-2)-i]);
                CCNOT(a[(n-2)-i], b[(n-2)-i], c[(n-1)-i]);

                CNOT(c[(n-2)-i], b[(n-2)-i]);
                CNOT(a[(n-2)-i], b[(n-2)-i]);
            }

            set result = MeasureInteger(LittleEndian(b));

            ResetAll(qs);

        }
        return result;
    }
}