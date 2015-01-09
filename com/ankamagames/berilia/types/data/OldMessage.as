package com.ankamagames.berilia.types.data
{
    import flash.utils.Dictionary;

    public class OldMessage 
    {

        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public var hook:Hook;
        public var args:Array;

        public function OldMessage(pHook:Hook, pArgs:Array)
        {
            this.hook = pHook;
            this.args = pArgs;
            MEMORY_LOG[this] = 1;
        }

    }
}//package com.ankamagames.berilia.types.data

