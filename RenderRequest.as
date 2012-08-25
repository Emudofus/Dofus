package 
{
    import com.ankamagames.jerakine.types.positions.*;
    import flash.utils.*;

    class RenderRequest extends Object
    {
        public var renderId:uint;
        public var map:WorldPoint;
        public var forceReloadWithoutCache:Boolean;
        public var decryptionKey:ByteArray;
        private static var RENDER_ID:uint = 0;

        function RenderRequest(param1:WorldPoint, param2:Boolean, param3:ByteArray)
        {
            this.renderId = RENDER_ID + 1;
            this.map = param1;
            this.forceReloadWithoutCache = param2;
            this.decryptionKey = param3;
            return;
        }// end function

    }
}
