package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import flash.filesystem.*;
    import flash.system.*;
    import flash.utils.*;

    public class ModuleScriptAnalyzer extends Object
    {
        private var _loader:IResourceLoader;
        private var _usedActions:Array;
        private static var _actionList:Dictionary;

        public function ModuleScriptAnalyzer(param1:UiModule)
        {
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            this._usedActions = [];
            if (!_actionList)
            {
                _actionList = new Dictionary();
                _loc_4 = UiModuleManager.getInstance().sharedDefinitionInstance.getActionList();
                for each (_loc_5 in _loc_4)
                {
                    
                    _actionList[_loc_5] = _loc_5;
                }
            }
            var _loc_2:* = param1.script;
            if (ApplicationDomain.currentDomain.hasDefinition("flash.net.ServerSocket"))
            {
                _loc_6 = File.applicationDirectory.nativePath.split("\\").join("/");
                if (_loc_2.indexOf(_loc_6) != -1)
                {
                    _loc_2 = _loc_2.substr(_loc_2.indexOf(_loc_6) + _loc_6.length);
                }
                _loc_2 = HttpServer.getInstance().getUrlTo(_loc_2);
            }
            else
            {
                throw new Error("Need Air 2 to analyze module script");
            }
            var _loc_3:* = new Uri(_loc_2);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onSwfLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onSwfFailed);
            this._loader.load(_loc_3, null, AdvancedSwfAdapter, true);
            return;
        }// end function

        private function onSwfLoaded(event:ResourceLoadedEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:ActionDescription = null;
            var _loc_2:* = event.resource;
            for each (_loc_3 in _actionList)
            {
                
                if (_loc_2.applicationDomain.hasDefinition("d2actions::" + _loc_3))
                {
                    _loc_4 = ActionDescription.getActionDescriptionByName(_loc_3);
                }
            }
            return;
        }// end function

        private function onSwfFailed(event:ResourceErrorEvent) : void
        {
            return;
        }// end function

    }
}
