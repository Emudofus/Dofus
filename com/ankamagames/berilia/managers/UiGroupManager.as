package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class UiGroupManager extends Object
    {
        private var _registeredGroup:Array;
        private var _uis:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UiGroupManager));
        private static var _self:UiGroupManager;

        public function UiGroupManager()
        {
            this._registeredGroup = new Array();
            this._uis = new Array();
            if (_self)
            {
                throw new SingletonError();
            }
            Berilia.getInstance().addEventListener(UiRenderAskEvent.UI_RENDER_ASK, this.onUiRenderAsk);
            return;
        }// end function

        public function registerGroup(param1:UiGroup) : void
        {
            this._registeredGroup[param1.name] = param1;
            return;
        }// end function

        public function removeGroup(param1:String) : void
        {
            delete this._registeredGroup[param1];
            return;
        }// end function

        public function getGroup(param1:String) : UiGroup
        {
            return this._registeredGroup[param1];
        }// end function

        public function destroy() : void
        {
            Berilia.getInstance().removeEventListener(UiRenderAskEvent.UI_RENDER_ASK, this.onUiRenderAsk);
            _self = null;
            return;
        }// end function

        private function onUiRenderAsk(event:UiRenderAskEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = null;
            if (!event.uiData.uiGroupName || !this._registeredGroup[event.uiData.uiGroupName])
            {
                return;
            }
            if (!this._uis[event.uiData.uiGroupName])
            {
                this._uis[event.uiData.uiGroupName] = new Array();
            }
            var _loc_2:* = this.getGroup(event.uiData.uiGroupName);
            if (!_loc_2)
            {
                return;
            }
            for each (_loc_3 in this._registeredGroup)
            {
                
                if (_loc_2.exclusive && !_loc_3.permanent && _loc_3.name != _loc_2.name)
                {
                    if (this._uis[_loc_3.name] != null)
                    {
                        _loc_4 = this._registeredGroup[_loc_3.name].uis;
                        for each (_loc_5 in _loc_4)
                        {
                            
                            _loc_6 = true;
                            for each (_loc_7 in _loc_2.uis)
                            {
                                
                                if (_loc_5 == _loc_7)
                                {
                                    _loc_6 = false;
                                }
                            }
                            if (_loc_6 && _loc_7 != null)
                            {
                                Berilia.getInstance().unloadUi(_loc_5);
                            }
                            delete this._uis[_loc_3.name][_loc_5];
                        }
                    }
                }
            }
            this._uis[event.uiData.uiGroupName][event.name] = event.uiData;
            return;
        }// end function

        public static function getInstance() : UiGroupManager
        {
            if (!_self)
            {
                _self = new UiGroupManager;
            }
            return _self;
        }// end function

    }
}
