using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Vedral
{
    class Driver
    {
        static void Main(string[] args)
        {
            ResourcesEstimator estimator = new ResourcesEstimator();
            Adder.Run(estimator).Wait();
            Console.WriteLine(estimator.ToTSV());
        }
    }
}