package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.types.listener.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class GenericEventsManager extends Object
    {
        protected var _aEvent:Array;
        protected var _listenerRef:Dictionary;
        protected var _log:Logger;

        public function GenericEventsManager()
        {
            this._aEvent = new Array();
            this._listenerRef = new Dictionary(true);
            this._log = Log.getLogger(getQualifiedClassName(GenericEventsManager));
            return;
        }// end function

        public function initialize() : void
        {
            this._aEvent = new Array();
            return;
        }// end function

        public function registerEvent(param1:GenericListener) : void
        {
            this._listenerRef[param1] = true;
            if (this._aEvent[param1.event] == null)
            {
                this._aEvent[param1.event] = new Array();
            }
            this._aEvent[param1.event].push(param1);
            (this._aEvent[param1.event] as Array).sortOn("sortIndex", Array.NUMERIC | Array.DESCENDING);
            return;
        }// end function

        public function removeEventListener(param1:GenericListener) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for (_loc_2 in this._aEvent)
            {
                
                for (_loc_3 in this._aEvent[_loc_2])
                {
                    
                    if (this._aEvent[_loc_2] == null || this._aEvent[_loc_2][_loc_3] == null)
                    {
                        continue;
                    }
                    if (this._aEvent[_loc_2][_loc_3] == param1)
                    {
                        delete this._aEvent[_loc_2][_loc_3];
                        if (!this._aEvent[_loc_2].length)
                        {
                            this._aEvent[_loc_2] = null;
                            delete this._aEvent[_loc_2];
                        }
                    }
                }
            }
            return;
        }// end function

        public function removeEventListenerByName(param1:String) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for (_loc_2 in this._aEvent)
            {
                
                for (_loc_3 in this._aEvent[_loc_2])
                {
                    
                    if (this._aEvent[_loc_2] == null || this._aEvent[_loc_2][_loc_3] == null)
                    {
                        continue;
                    }
                    _loc_4 = this._aEvent[_loc_2][_loc_3];
                    if (_loc_4.listener == param1)
                    {
                        delete this._aEvent[_loc_2][_loc_3];
                        if (!this._aEvent[_loc_2].length)
                        {
                            this._aEvent[_loc_2] = null;
                            delete this._aEvent[_loc_2];
                        }
                    }
                }
            }
            return;
        }// end function

        public function removeEvent(param1) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            for (_loc_4 in this._aEvent)
            {
                
                _loc_3 = null;
                for (_loc_5 in this._aEvent[_loc_4])
                {
                    
                    if (this._aEvent[_loc_4] == null || this._aEvent[_loc_4][_loc_5] == null)
                    {
                        continue;
                    }
                    _loc_2 = this._aEvent[_loc_4][_loc_5];
                    if (_loc_2.listener == param1)
                    {
                        if (!_loc_3)
                        {
                            _loc_3 = [];
                        }
                        _loc_3.push(_loc_5);
                    }
                }
                for each (_loc_6 in _loc_3)
                {
                    
                    delete this._aEvent[_loc_4][_loc_6];
                }
            }
            return;
        }// end function

    }
}
