package animation {
    import flash.events.Event;

    import mx.controls.Label;

    public class AnimatedLabel extends Label {
        public function AnimatedLabel() {
            this.text = "Move";
            this.addEventListener(Event.ENTER_FRAME, moveRight);
        }

        private function moveRight(e:Event):void {
            if (this.x <= 300) {
                this.x += 5;
                if (this.x > 300) {
                    this.x = 300;
                }
            } else {
                stop();
            }
        }

        private function stop():void {
            this.removeEventListener(Event.ENTER_FRAME, moveRight);
        }

        private function start():void {
            this.addEventListener(Event.ENTER_FRAME, moveRight);
        }

    }
}