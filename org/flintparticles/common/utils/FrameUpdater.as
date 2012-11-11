package org.flintparticles.common.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.flintparticles.common.events.*;

    public class FrameUpdater extends EventDispatcher
    {
        private var _shape:Shape;
        private var _time:Number;
        private static var _instance:FrameUpdater;

        public function FrameUpdater()
        {
            this._shape = new Shape();
            this._shape.addEventListener(Event.ENTER_FRAME, this.frameUpdate, false, 0, true);
            this._time = getTimer();
            return;
        }// end function

        private function frameUpdate(event:Event) : void
        {
            var _loc_2:* = this._time;
            this._time = getTimer();
            var _loc_3:* = (this._time - _loc_2) * 0.001;
            dispatchEvent(new UpdateEvent(UpdateEvent.UPDATE, _loc_3));
            return;
        }// end function

        public static function get instance() : FrameUpdater
        {
            if (_instance == null)
            {
                _instance = new FrameUpdater;
            }
            return _instance;
        }// end function

    }
}
