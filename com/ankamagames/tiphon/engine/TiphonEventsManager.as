package com.ankamagames.tiphon.engine
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.tiphon.types.EventListener;
    import com.ankamagames.jerakine.utils.memory.WeakReference;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
    import flash.display.FrameLabel;
    import flash.display.Scene;
    import com.ankamagames.tiphon.types.TiphonEventInfo;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import __AS3__.vec.*;

    public class TiphonEventsManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonEventsManager));
        private static var _listeners:Vector.<EventListener> = new Vector.<EventListener>();
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

        private var _weakTiphonSprite:WeakReference;
        private var _events:Array;

        public function TiphonEventsManager(pTiphonSprite:TiphonSprite)
        {
            this._weakTiphonSprite = new WeakReference(pTiphonSprite);
            this._events = new Array();
            if (_eventsDic == null)
            {
                _eventsDic = new Array();
            };
        }

        public static function get listeners():Vector.<EventListener>
        {
            return (_listeners);
        }

        public static function addListener(pListener:IFLAEventHandler, pTypes:String):void
        {
            var el:EventListener;
            var i:int = -1;
            var num:int = _listeners.length;
            while (++i < num)
            {
                el = _listeners[i];
                if ((((el.listener == pListener)) && ((el.typesEvents == pTypes))))
                {
                    return;
                };
            };
            TiphonEventsManager._listeners.push(new EventListener(pListener, pTypes));
        }

        public static function removeListener(pListener:IFLAEventHandler):void
        {
            var index:int = TiphonEventsManager._listeners.indexOf(pListener);
            if (index != -1)
            {
                TiphonEventsManager._listeners.splice(index, 1);
            };
        }


        public function parseLabels(pScene:Scene, pAnimationName:String):void
        {
            var curLabel:FrameLabel;
            var curLabelName:String;
            var curLabelFrame:int;
            var numLabels:int = pScene.labels.length;
            var curLabelIndex:int = -1;
            while (++curLabelIndex < numLabels)
            {
                curLabel = (pScene.labels[curLabelIndex] as FrameLabel);
                curLabelName = curLabel.name;
                curLabelFrame = curLabel.frame;
                this.addEvent(curLabelName, curLabelFrame, pAnimationName);
            };
        }

        public function dispatchEvents(pFrame:*):void
        {
            var num:int;
            var i:int;
            var event:TiphonEventInfo;
            var numListener:int;
            var k:int;
            var eListener:EventListener;
            if (!(this._weakTiphonSprite))
            {
                return;
            };
            if (pFrame == 0)
            {
                pFrame = 1;
            };
            var ts:TiphonSprite = (this._weakTiphonSprite.object as TiphonSprite);
            var spriteDirection:uint = ts.getDirection();
            if (spriteDirection == 3)
            {
                spriteDirection = 1;
            };
            if (spriteDirection == 7)
            {
                spriteDirection = 5;
            };
            if (spriteDirection == 4)
            {
                spriteDirection = 0;
            };
            var spriteAnimation:String = ts.getAnimation();
            var frameEventsList:Vector.<TiphonEventInfo> = this._events[pFrame];
            if (frameEventsList)
            {
                num = frameEventsList.length;
                i = -1;
                while (++i < num)
                {
                    event = frameEventsList[i];
                    numListener = _listeners.length;
                    k = -1;
                    while (++k < numListener)
                    {
                        eListener = _listeners[k];
                        if ((((((eListener.typesEvents == event.type)) && ((event.animationType == spriteAnimation)))) && ((event.direction == spriteDirection))))
                        {
                            eListener.listener.handleFLAEvent(event.animationName, event.type, event.params, ts);
                        };
                    };
                };
            };
        }

        public function destroy():void
        {
            var i:int;
            var num:int;
            var list:Vector.<TiphonEventInfo>;
            var k:int;
            var num2:int;
            var tiphonEventInfo:TiphonEventInfo;
            if (this._events)
            {
                i = -1;
                num = this._events.length;
                while (++i < num)
                {
                    list = this._events[i];
                    if (list)
                    {
                        k = -1;
                        num2 = list.length;
                        while (++k < num2)
                        {
                            tiphonEventInfo = list[k];
                            tiphonEventInfo.destroy();
                        };
                    };
                };
                this._events = null;
            };
            if (this._weakTiphonSprite)
            {
                this._weakTiphonSprite.destroy();
                this._weakTiphonSprite = null;
            };
        }

        public function addEvent(pLabelName:String, pFrame:int, pAnimationName:String):void
        {
            var event:TiphonEventInfo;
            var newEvent:TiphonEventInfo;
            var _local_6:TiphonEventInfo;
            var ts:TiphonSprite;
            if (this._events[pFrame] == null)
            {
                this._events[pFrame] = new Vector.<TiphonEventInfo>();
            };
            for each (event in this._events[pFrame])
            {
                if ((((event.animationName == pAnimationName)) && ((event.label == pLabelName))))
                {
                    return;
                };
            };
            if (_eventsDic[pLabelName])
            {
                newEvent = (_eventsDic[pLabelName] as TiphonEventInfo).duplicate();
                newEvent.label = pLabelName;
                this._events[pFrame].push(newEvent);
                newEvent.animationName = pAnimationName;
            }
            else
            {
                _local_6 = this.parseLabel(pLabelName);
                if (_local_6)
                {
                    _eventsDic[pLabelName] = _local_6;
                    _local_6.animationName = pAnimationName;
                    _local_6.label = pLabelName;
                    this._events[pFrame].push(_local_6);
                }
                else
                {
                    if (pLabelName != "END")
                    {
                        ts = (this._weakTiphonSprite.object as TiphonSprite);
                        _log.error((((((("Found label '" + pLabelName) + "' on sprite ") + ts.look.getBone()) + " (anim ") + ts.getAnimation()) + ")"));
                    };
                };
            };
        }

        public function removeEvents(pTypeName:String, pAnimation:String):void
        {
            var frame:String;
            var events:Vector.<TiphonEventInfo>;
            var newEvents:Vector.<TiphonEventInfo>;
            var tei:TiphonEventInfo;
            for (frame in this._events)
            {
                events = this._events[frame];
                newEvents = new Vector.<TiphonEventInfo>();
                for each (tei in events)
                {
                    if (((!((tei.animationName == pAnimation))) || (!((tei.type == pTypeName)))))
                    {
                        newEvents.push(tei);
                    };
                };
                if (newEvents.length != events.length)
                {
                    this._events[frame] = newEvents;
                };
            };
        }

        private function parseLabel(pLabelName:String):TiphonEventInfo
        {
            var returnEvent:TiphonEventInfo;
            var param:String;
            var eventName:String = pLabelName.split(BALISE_PARAM_BEGIN)[0];
            var r:RegExp = /^\s*(.*?)\s*$/g;
            eventName = eventName.replace(r, "$1");
            switch (eventName.toUpperCase())
            {
                case BALISE_SOUND.toUpperCase():
                    param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
                    param = param.split(BALISE_PARAM_END)[0];
                    returnEvent = new TiphonEventInfo(TiphonEvent.SOUND_EVENT, param);
                    break;
                case BALISE_DATASOUND.toUpperCase():
                    param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
                    param = param.split(BALISE_PARAM_END)[0];
                    returnEvent = new TiphonEventInfo(TiphonEvent.DATASOUND_EVENT, param);
                    break;
                case BALISE_PLAYANIM.toUpperCase():
                    param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
                    param = param.split(BALISE_PARAM_END)[0];
                    returnEvent = new TiphonEventInfo(TiphonEvent.PLAYANIM_EVENT, param);
                    break;
                case BALISE_EVT.toUpperCase():
                    trace(("BALISE_EVT : " + pLabelName));
                    param = pLabelName.split(BALISE_PARAM_BEGIN)[1];
                    param = param.split(BALISE_PARAM_END)[0];
                    returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT, param);
                    break;
                default:
                    returnEvent = this.convertOldLabel(pLabelName);
            };
            return (returnEvent);
        }

        private function convertOldLabel(pLabelName:String):TiphonEventInfo
        {
            var returnEvent:TiphonEventInfo;
            switch (pLabelName)
            {
                case EVENT_END:
                    returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT, EVENT_END);
                    break;
                case PLAYER_STOP:
                    returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT, PLAYER_STOP);
                    break;
                case EVENT_SHOT:
                    returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT, EVENT_SHOT);
                    break;
            };
            return (returnEvent);
        }


    }
}//package com.ankamagames.tiphon.engine

