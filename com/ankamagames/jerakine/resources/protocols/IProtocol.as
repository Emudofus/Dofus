package com.ankamagames.jerakine.resources.protocols
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;

    public interface IProtocol extends Poolable
    {

        public function IProtocol();

        function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void;

        function cancel() : void;

    }
}
