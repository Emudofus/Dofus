package com.ankamagames.performance
{
    import flash.display.Sprite;
    import flash.filters.BlurFilter;
    import flash.events.Event;

    public class DisplayObjectDummy extends Sprite 
    {

        private static const BLUR_FILTER:BlurFilter = new BlurFilter();

        public function DisplayObjectDummy(color:uint)
        {
            graphics.beginFill(color);
            graphics.drawRect(0, 0, 24, 24);
            graphics.endFill();
            filters = [BLUR_FILTER];
            addEventListener(Event.ENTER_FRAME, this.onFrame);
        }

        protected function onFrame(event:Event):void
        {
            rotation = (Math.random() * 360);
            x = (Math.random() * 20);
            y = (Math.random() * 20);
        }


    }
}//package com.ankamagames.performance

