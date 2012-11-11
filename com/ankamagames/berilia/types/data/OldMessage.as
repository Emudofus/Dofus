package com.ankamagames.berilia.types.data
{
    import flash.utils.*;

    public class OldMessage extends Object
    {
        public var hook:Hook;
        public var args:Array;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function OldMessage(param1:Hook, param2:Array)
        {
            this.hook = param1;
            this.args = param2;
            MEMORY_LOG[this] = 1;
            return;
        }// end function

    }
}
