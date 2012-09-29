package vo {
    [Bindable]
    public class DateRange {
        public var startDate : Date;
        public var endDate : Date;

        public function DateRange(startDate:Date, endDate:Date) {
            this.startDate = startDate;
            this.endDate = endDate;
        }
    }
}