package com.ankamagames.jerakine.resources.loaders
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.tubul.interfaces.*;

    public interface IResourceLoader extends IEventDispatcher
    {

        public function IResourceLoader();

        function load(param1, param2:ICache = null, param3:Class = null, param4:Boolean = false) : void;

        function cancel() : void;

    }
}
