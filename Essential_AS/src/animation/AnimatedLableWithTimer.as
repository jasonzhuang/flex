package animation {
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import mx.controls.Label;

    public class AnimatedLableWithTimer extends Label {
        private var timer:Timer;

        public function AnimatedLableWithTimer() {
            this.text = "GO";
            timer = new Timer(50, 0);
            timer.addEventListener(TimerEvent.TIMER, moveRight);
            timer.start();
        }

        private function moveRight(e:TimerEvent):void {
            if (this.x <= 300) {
                this.x += 5;
                if (this.x > 300) {
                    this.x = 300;
                }
                //To force a screen update immediately after moveRight() exits, we use the
                //TimerEvent class’s instance method updateAfterEvent()
                e.updateAfterEvent();
            } else {
                timer.stop();
            }
        }
    }
}