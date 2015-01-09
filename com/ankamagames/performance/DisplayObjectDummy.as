package com.ankamagames.performance
{
    import flash.display.Sprite;
    import flash.events.Event;
    import com.ankamagames.performance.tests.TestDisplayPerformance;

    public class DisplayObjectDummy extends Sprite 
    {

        public function DisplayObjectDummy(color:uint)
        {
            graphics.beginFill(color);
            graphics.drawRect(0, 0, 24, 24);
            graphics.endFill();
            addEventListener(Event.ENTER_FRAME, this.onFrame);
        }

        protected function onFrame(event:Event):void
        {
            if (!(stage))
            {
                return;
            };
            rotation = (TestDisplayPerformance.random.nextDouble() * 360);
            x = (x + (TestDisplayPerformance.random.nextDoubleR(-1, 1) * 20));
            y = (y + (TestDisplayPerformance.random.nextDoubleR(-1, 1) * 20));
            scaleX = (scaleY = TestDisplayPerformance.random.nextDoubleR(-2, 2));
            if ((((x > stage.stageWidth)) || ((x < 0))))
            {
                x = (stage.stageWidth / 2);
            };
            if ((((y > stage.stageHeight)) || ((y < 0))))
            {
                y = (stage.stageHeight / 2);
            };
        }


    }
}//package com.ankamagames.performance

