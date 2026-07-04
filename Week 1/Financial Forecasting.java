class FinancialForecaster {

    public double calculateFutureValue(double currentCapital, double growthRate, int years) {
        if (years <= 0) {
            return currentCapital;
        }
        return calculateFutureValue(currentCapital * (1 + growthRate), growthRate, years - 1);
    }
}

public class Main {
    public static void main(String[] args) {
        FinancialForecaster forecaster = new FinancialForecaster();

        double startingPrincipal = 10000.00;
        double annualGrowthRate = 0.05;
        int investmentDuration = 5;

        double predictedValue = forecaster.calculateFutureValue(startingPrincipal, annualGrowthRate, investmentDuration);

        System.out.println("Initial Investment  : $" + startingPrincipal);
        System.out.println("Annual Growth Rate  : " + (annualGrowthRate * 100) + "%");
        System.out.println("Forecast Duration   : " + investmentDuration + " Years");
        System.out.printf("Predicted Future Val: $%.2f%n", predictedValue);
    }
}