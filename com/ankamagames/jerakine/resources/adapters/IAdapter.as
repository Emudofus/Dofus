package com.ankamagames.jerakine.resources.adapters
{
    import com.ankamagames.jerakine.pools.Poolable;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.IResourceObserver;
    import flash.utils.ByteArray;

    public interface IAdapter extends Poolable 
    {

        function loadDirectly(_arg_1:Uri, _arg_2:String, _arg_3:IResourceObserver, _arg_4:Boolean):void;
        function loadFromData(_arg_1:Uri, _arg_2:ByteArray, _arg_3:IResourceObserver, _arg_4:Boolean):void;
        function getResourceType():uint;

    }
}//package com.ankamagames.jerakine.resources.adapters

