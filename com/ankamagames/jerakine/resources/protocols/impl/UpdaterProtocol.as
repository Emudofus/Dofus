package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;

    public class UpdaterProtocol extends AbstractProtocol implements IProtocol
    {

        public function UpdaterProtocol()
        {
            return;
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            throw new Error("Unimplemented stub.");
        }// end function

        override protected function release() : void
        {
            throw new Error("Unimplemented stub.");
        }// end function

    }
}
