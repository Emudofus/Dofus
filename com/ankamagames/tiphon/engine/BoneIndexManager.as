package com.ankamagames.tiphon.engine
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.files.*;
    import com.ankamagames.tiphon.*;
    import com.ankamagames.tiphon.types.*;
    import flash.events.*;
    import flash.utils.*;

    public class BoneIndexManager extends EventDispatcher
    {
        private var _loader:IResourceLoader;
        private var _index:Dictionary;
        private var _transitions:Dictionary;
        private var _animNameModifier:Function;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(BoneIndexManager));
        private static var _self:BoneIndexManager;

        public function BoneIndexManager()
        {
            this._index = new Dictionary();
            this._transitions = new Dictionary();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:String) : void
        {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onXmlLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onXmlFailed);
            this._loader.load(new Uri(param1));
            return;
        }// end function

        public function setAnimNameModifier(param1:Function) : void
        {
            this._animNameModifier = param1;
            return;
        }// end function

        public function addTransition(param1:uint, param2:String, param3:String, param4:uint, param5:String) : void
        {
            if (!this._transitions[param1])
            {
                this._transitions[param1] = new Dictionary();
            }
            this._transitions[param1][param2 + "_" + param3 + "_" + param4] = param5;
            return;
        }// end function

        public function hasTransition(param1:uint, param2:String, param3:String, param4:uint) : Boolean
        {
            if (this._animNameModifier != null)
            {
                param2 = this._animNameModifier(param1, param2);
                param3 = this._animNameModifier(param1, param3);
            }
            return this._transitions[param1] && (this._transitions[param1][param2 + "_" + param3 + "_" + param4] != null || this._transitions[param1][param2 + "_" + param3 + "_" + TiphonUtility.getFlipDirection(param4)] != null);
        }// end function

        public function getTransition(param1:uint, param2:String, param3:String, param4:uint) : String
        {
            if (this._animNameModifier != null)
            {
                param2 = this._animNameModifier(param1, param2);
                param3 = this._animNameModifier(param1, param3);
            }
            if (!this._transitions[param1])
            {
                return null;
            }
            if (this._transitions[param1][param2 + "_" + param3 + "_" + param4])
            {
                return this._transitions[param1][param2 + "_" + param3 + "_" + param4];
            }
            return this._transitions[param1][param2 + "_" + param3 + "_" + TiphonUtility.getFlipDirection(param4)];
        }// end function

        public function getBoneFile(param1:uint, param2:String) : Uri
        {
            if (!this._index[param1] || !this._index[param1][param2])
            {
                return new Uri(TiphonConstants.SWF_SKULL_PATH + param1 + ".swl");
            }
            return new Uri(TiphonConstants.SWF_SKULL_PATH + this._index[param1][param2]);
        }// end function

        public function hasAnim(param1:uint, param2:String, param3:int) : Boolean
        {
            return this._index[param1] && this._index[param1][param2];
        }// end function

        public function hasCustomBone(param1:uint) : Boolean
        {
            return this._index[param1];
        }// end function

        public function getAllCustomAnimations(param1:int) : Array
        {
            var _loc_4:String = null;
            var _loc_2:* = this._index[param1];
            if (!_loc_2)
            {
                return null;
            }
            var _loc_3:* = new Array();
            for (_loc_4 in _loc_2)
            {
                
                _loc_3.push(_loc_4);
            }
            return _loc_3;
        }// end function

        private function onXmlLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_5:XML = null;
            var _loc_6:Uri = null;
            this._loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onXmlLoaded);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onSubXmlLoaded);
            this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE, this.onAllSubXmlLoaded);
            var _loc_2:* = FileUtils.getFilePath(event.uri.uri);
            var _loc_3:* = event.resource as XML;
            var _loc_4:* = new Array();
            for each (_loc_5 in _loc_3..group)
            {
                
                _loc_6 = new Uri(_loc_2 + "/" + _loc_5.@id.toString() + ".xml");
                _loc_6.tag = parseInt(_loc_5.@id.toString());
                _loc_4.push(_loc_6);
            }
            this._loader.load(_loc_4);
            return;
        }// end function

        private function onSubXmlLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:XML = null;
            var _loc_5:XML = null;
            var _loc_6:Array = null;
            var _loc_2:* = event.resource as XML;
            for each (_loc_4 in _loc_2..file)
            {
                
                for each (_loc_5 in _loc_4..resource)
                {
                    
                    _loc_3 = _loc_5.@name.toString();
                    if (_loc_3.indexOf("Anim") != -1)
                    {
                        if (!this._index[event.uri.tag])
                        {
                            this._index[event.uri.tag] = new Dictionary();
                        }
                        this._index[event.uri.tag][_loc_3] = _loc_4.@name.toString();
                        if (_loc_3.indexOf("_to_") != -1)
                        {
                            _loc_6 = _loc_3.split("_");
                            _self.addTransition(event.uri.tag, _loc_6[0], _loc_6[2], parseInt(_loc_6[3]), _loc_6[0] + "_to_" + _loc_6[2]);
                        }
                    }
                }
            }
            return;
        }// end function

        private function onXmlFailed(event:ResourceErrorEvent) : void
        {
            _log.error("Impossible de charger ou parser le fichier d\'index d\'animation : " + event.uri);
            return;
        }// end function

        private function onAllSubXmlLoaded(event:ResourceLoaderProgressEvent) : void
        {
            this._loader = null;
            dispatchEvent(new Event(Event.INIT));
            return;
        }// end function

        public static function getInstance() : BoneIndexManager
        {
            if (!_self)
            {
                _self = new BoneIndexManager;
            }
            return _self;
        }// end function

    }
}
