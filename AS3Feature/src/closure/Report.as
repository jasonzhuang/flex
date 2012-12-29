package closure
{
	public class Report
	{
        public function Report(employee:Employee) {
            employee.doReport = function():void {
                //the ketword this indicates the parameter employee 
                trace(this.startDate);
                trace(this.age); //compile passed, but the value is undefined
            }
        }
	}
}