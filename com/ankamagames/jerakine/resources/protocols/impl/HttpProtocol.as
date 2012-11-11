package com.ankamagames.jerakine.resources.protocols.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;

    public class HttpProtocol extends AbstractProtocol implements IProtocol
    {

        public function HttpProtocol()
        {
            return;
        }// end function

        public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            getAdapter(param1, param5);
            _adapter.loadDirectly(param1, param1.protocol + "://" + param1.path, param2, param3);
            return;
        }// end function

        override protected function release() : void
        {
            return;
        }// end function

    }
}
