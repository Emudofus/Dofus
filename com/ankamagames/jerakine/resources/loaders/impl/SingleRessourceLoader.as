package com.ankamagames.jerakine.resources.loaders.impl
{
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.types.*;
    import flash.errors.*;

    public class SingleRessourceLoader extends AbstractRessourceLoader implements IResourceLoader, IResourceObserver
    {
        private var _uri:Uri;
        private var _protocol:IProtocol;

        public function SingleRessourceLoader()
        {
            return;
        }// end function

        public function load(param1, param2:ICache = null, param3:Class = null, param4:Boolean = false) : void
        {
            if (this._uri != null)
            {
                throw new IllegalOperationError("A single ressource loader can\'t handle more than one load at a time.");
            }
            if (param1 == null)
            {
                throw new ArgumentError("Can\'t load a null uri.");
            }
            if (!(param1 is Uri))
            {
                throw new ArgumentError("Can\'t load an array of URIs when using a LOADER_SINGLE loader.");
            }
            this._uri = param1;
            _cache = param2;
            _completed = false;
            _filesTotal = 1;
            if (!checkCache(this._uri))
            {
                this._protocol = ProtocolFactory.getProtocol(this._uri);
                this._protocol.load(this._uri, this, hasEventListener(ResourceProgressEvent.PROGRESS), _cache, param3, param4);
            }
            return;
        }// end function

        public function cancel() : void
        {
            if (this._protocol)
            {
                this._protocol.cancel();
                this._protocol = null;
            }
            this._uri = null;
            return;
        }// end function

        override public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            super.onLoaded(param1, param2, param3);
            this._protocol = null;
            return;
        }// end function

        override public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            super.onFailed(param1, param2, param3);
            this._protocol = null;
            return;
        }// end function

    }
}
