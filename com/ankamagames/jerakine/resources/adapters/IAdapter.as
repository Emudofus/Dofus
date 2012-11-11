package com.ankamagames.jerakine.resources.adapters
{
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public interface IAdapter extends Poolable
    {

        public function IAdapter();

        function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void;

        function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void;

        function getResourceType() : uint;

    }
}
