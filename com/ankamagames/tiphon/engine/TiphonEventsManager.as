package com.ankamagames.tiphon.engine
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;
    import flash.display.*;
    import flash.utils.*;

    public class TiphonEventsManager extends Object
    {
        private var _weakTiphonSprite:WeakReference;
        private var _events:Array;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonEventsManager));
        private static var _listeners:Vector.<EventListener> = new Vector.<EventListener>;
        private static var _eventsDic:Array;
        private static const EVENT_SHOT:String = "SHOT";
        private static const EVENT_END:String = "END";
        private static const PLAYER_STOP:String = "STOP";
        private static const EVENT_SOUND:String = "SOUND";
        private static const EVENT_DATASOUND:String = "DATASOUND";
        private static const EVENT_PLAYANIM:String = "PLAYANIM";
        public static var BALISE_SOUND:String = "Sound";
        public static var BALISE_DATASOUND:String = "DataSound";
        public static var BALISE_PLAYANIM:String = "PlayAnim";
        public static var BALISE_EVT:String = "Evt";
        public static var BALISE_PARAM_BEGIN:String = "(";
        public static var BALISE_PARAM_END:String = ")";

        public function TiphonEventsManager(param1:TiphonSprite)
        {
            this._weakTiphonSprite = new WeakReference(param1);
            this._events = new Array();
            if (_eventsDic == null)
            {
                _eventsDic = new Array();
            }
            return;
        }// end function

        public function parseLabels(param1:Scene, param2:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = param1.labels.length;
            var _loc_4:* = -1;
            while (++_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.labels[_loc_4] as FrameLabel;
                _loc_6 = _loc_5.name;
                _loc_7 = _loc_5.frame;
                this.addEvent(_loc_6, _loc_7, param2);
            }
            return;
        }// end function

        public function dispatchEvents(param1) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (!this._weakTiphonSprite)
            {
                return;
            }
            if (param1 == 0)
            {
                param1 = 1;
            }
            var _loc_2:* = this._weakTiphonSprite.object as TiphonSprite;
            var _loc_3:* = _loc_2.getDirection();
            if (_loc_3 == 3)
            {
                _loc_3 = 1;
            }
            if (_loc_3 == 7)
            {
                _loc_3 = 5;
            }
            if (_loc_3 == 4)
            {
                _loc_3 = 0;
            }
            var _loc_4:* = _loc_2.getAnimation();
            var _loc_5:* = this._events[param1];
            if (this._events[param1])
            {
                _loc_6 = _loc_5.length;
                _loc_7 = -1;
                while (++_loc_7 < _loc_6)
                {
                    
                    _loc_8 = _loc_5[_loc_7];
                    _loc_9 = _listeners.length;
                    _loc_10 = -1;
                    while (++_loc_10 < _loc_9)
                    {
                        
                        _loc_11 = _listeners[_loc_10];
                        if (_loc_11.typesEvents == _loc_8.type && _loc_8.animationType == _loc_4 && _loc_8.direction == _loc_3)
                        {
                            _loc_11.listener.handleFLAEvent(_loc_8.animationName, _loc_8.type, _loc_8.params, _loc_2);
                        }
                    }
                }
            }
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (this._events)
            {
                _loc_1 = -1;
                _loc_2 = this._events.length;
                while (++_loc_1 < _loc_2)
                {
                    
                    _loc_3 = this._events[_loc_1];
                    if (_loc_3)
                    {
                        _loc_4 = -1;
                        _loc_5 = _loc_3.length;
                        while (++_loc_4 < _loc_5)
                        {
                            
                            _loc_6 = _loc_3[_loc_4];
                            _loc_6.destroy();
                        }
                    }
                }
                this._events = null;
            }
            if (this._weakTiphonSprite)
            {
                this._weakTiphonSprite.destroy();
                this._weakTiphonSprite = null;
            }
            return;
        }// end function

        public function addEvent(param1:String, param2:int, param3:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this._events[param2] == null)
            {
                this._events[param2] = new Vector.<TiphonEventInfo>;
            }
            for each (_loc_4 in this._events[param2])
            {
                
                if (_loc_4.animationName == param3 && _loc_4.label == param1)
                {
                    return;
                }
            }
            if (_eventsDic[param1])
            {
                _loc_5 = (_eventsDic[param1] as TiphonEventInfo).duplicate();
                _loc_5.label = param1;
                this._events[param2].push(_loc_5);
                _loc_5.animationName = param3;
            }
            else
            {
                _loc_6 = this.parseLabel(param1);
                if (_loc_6)
                {
                    _eventsDic[param1] = _loc_6;
                    _loc_6.animationName = param3;
                    _loc_6.label = param1;
                    this._events[param2].push(_loc_6);
                }
                else if (param1 != "END")
                {
                    _loc_7 = this._weakTiphonSprite.object as TiphonSprite;
                    _log.error("Found label \'" + param1 + "\' on sprite " + _loc_7.look.getBone() + " (anim " + _loc_7.getAnimation() + ")");
                }
            }
            return;
        }// end function

        public function removeEvents(param1:String, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            for (_loc_3 in this._events)
            {
                
                _loc_4 = this._events[_loc_3];
                _loc_5 = new Vector.<TiphonEventInfo>;
                for each (_loc_6 in _loc_4)
                {
                    
                    if (_loc_6.animationName != param2 || _loc_6.type != param1)
                    {
                        _loc_5.push(_loc_6);
                    }
                }
                if (_loc_5.length != _loc_4.length)
                {
                    this._events[_loc_3] = _loc_5;
                }
            }
            return;
        }// end function

        private function parseLabel(param1:String) : TiphonEventInfo
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            var _loc_3:* = param1.split(BALISE_PARAM_BEGIN)[0];
            var _loc_4:* = /^\s*(.*?)\s*$""^\s*(.*?)\s*$/g;
            _loc_3 = _loc_3.replace(_loc_4, "$1");
            switch(_loc_3.toUpperCase())
            {
                case BALISE_SOUND.toUpperCase():
                {
                    _loc_5 = param1.split(BALISE_PARAM_BEGIN)[1];
                    _loc_5 = _loc_5.split(BALISE_PARAM_END)[0];
                    _loc_2 = new TiphonEventInfo(TiphonEvent.SOUND_EVENT, _loc_5);
                    break;
                }
                case BALISE_DATASOUND.toUpperCase():
                {
                    _loc_5 = param1.split(BALISE_PARAM_BEGIN)[1];
                    _loc_5 = _loc_5.split(BALISE_PARAM_END)[0];
                    _loc_2 = new TiphonEventInfo(TiphonEvent.DATASOUND_EVENT, _loc_5);
                    break;
                }
                case BALISE_PLAYANIM.toUpperCase():
                {
                    _loc_5 = param1.split(BALISE_PARAM_BEGIN)[1];
                    _loc_5 = _loc_5.split(BALISE_PARAM_END)[0];
                    _loc_2 = new TiphonEventInfo(TiphonEvent.PLAYANIM_EVENT, _loc_5);
                    break;
                }
                case BALISE_EVT.toUpperCase():
                {
                    trace("BALISE_EVT : " + param1);
                    _loc_5 = param1.split(BALISE_PARAM_BEGIN)[1];
                    _loc_5 = _loc_5.split(BALISE_PARAM_END)[0];
                    _loc_2 = new TiphonEventInfo(TiphonEvent.EVT_EVENT, _loc_5);
                    break;
                }
                default:
                {
                    _loc_2 = this.convertOldLabel(param1);
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function convertOldLabel(param1:String) : TiphonEventInfo
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case EVENT_END:
                {
                    _loc_2 = new TiphonEventInfo(TiphonEvent.EVT_EVENT, EVENT_END);
                    break;
                }
                case PLAYER_STOP:
                {
                    _loc_2 = new TiphonEventInfo(TiphonEvent.EVT_EVENT, PLAYER_STOP);
                    break;
                }
                case EVENT_SHOT:
                {
                    _loc_2 = new TiphonEventInfo(TiphonEvent.EVT_EVENT, EVENT_SHOT);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function get listeners() : Vector.<EventListener>
        {
            return _listeners;
        }// end function

        public static function addListener(param1:IFLAEventHandler, param2:String) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = -1;
            var _loc_4:* = _listeners.length;
            while (++_loc_3 < _loc_4)
            {
                
                _loc_5 = _listeners[_loc_3];
                if (_loc_5.listener == param1 && _loc_5.typesEvents == param2)
                {
                    return;
                }
            }
            TiphonEventsManager._listeners.push(new EventListener(param1, param2));
            return;
        }// end function

        public static function removeListener(param1:IFLAEventHandler) : void
        {
            var _loc_2:* = TiphonEventsManager._listeners.indexOf(param1);
            if (_loc_2 != -1)
            {
                TiphonEventsManager._listeners.splice(_loc_2, 1);
            }
            return;
        }// end function

    }
}
