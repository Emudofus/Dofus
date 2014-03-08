package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tiphon.types.EventListener;
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.Scene;
   import flash.display.FrameLabel;
   import com.ankamagames.tiphon.types.TiphonEventInfo;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class TiphonEventsManager extends Object
   {
      
      public function TiphonEventsManager(pTiphonSprite:TiphonSprite) {
         super();
         this._weakTiphonSprite = new WeakReference(pTiphonSprite);
         this._events = new Array();
         if(_eventsDic == null)
         {
            _eventsDic = new Array();
         }
      }
      
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
      
      public static function get listeners() : Vector.<EventListener> {
         return _listeners;
      }
      
      public static function addListener(pListener:IFLAEventHandler, pTypes:String) : void {
         var el:EventListener = null;
         var i:int = -1;
         var num:int = _listeners.length;
         while(++i < num)
         {
            el = _listeners[i];
            if((el.listener == pListener) && (el.typesEvents == pTypes))
            {
               return;
            }
         }
         TiphonEventsManager._listeners.push(new EventListener(pListener,pTypes));
      }
      
      public static function removeListener(pListener:IFLAEventHandler) : void {
         var index:int = TiphonEventsManager._listeners.indexOf(pListener);
         if(index != -1)
         {
            TiphonEventsManager._listeners.splice(index,1);
         }
      }
      
      private var _weakTiphonSprite:WeakReference;
      
      private var _events:Array;
      
      public function parseLabels(pScene:Scene, pAnimationName:String) : void {
         var curLabel:FrameLabel = null;
         var curLabelName:String = null;
         var curLabelFrame:* = 0;
         var numLabels:int = pScene.labels.length;
         var curLabelIndex:int = -1;
         while(++curLabelIndex < numLabels)
         {
            curLabel = pScene.labels[curLabelIndex] as FrameLabel;
            curLabelName = curLabel.name;
            curLabelFrame = curLabel.frame;
            this.addEvent(curLabelName,curLabelFrame,pAnimationName);
         }
      }
      
      public function dispatchEvents(pFrame:*) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function destroy() : void {
         var i:* = 0;
         var num:* = 0;
         var list:Vector.<TiphonEventInfo> = null;
         var k:* = 0;
         var num2:* = 0;
         var tiphonEventInfo:TiphonEventInfo = null;
         if(this._events)
         {
            i = -1;
            num = this._events.length;
            while(++i < num)
            {
               list = this._events[i];
               if(list)
               {
                  k = -1;
                  num2 = list.length;
                  while(++k < num2)
                  {
                     tiphonEventInfo = list[k];
                     tiphonEventInfo.destroy();
                  }
               }
            }
            this._events = null;
         }
         if(this._weakTiphonSprite)
         {
            this._weakTiphonSprite.destroy();
            this._weakTiphonSprite = null;
         }
      }
      
      public function addEvent(pLabelName:String, pFrame:int, pAnimationName:String) : void {
         var event:TiphonEventInfo = null;
         var newEvent:TiphonEventInfo = null;
         var labelEvent:TiphonEventInfo = null;
         var ts:TiphonSprite = null;
         if(this._events[pFrame] == null)
         {
            this._events[pFrame] = new Vector.<TiphonEventInfo>();
         }
         for each (event in this._events[pFrame])
         {
            if((event.animationName == pAnimationName) && (event.label == pLabelName))
            {
               return;
            }
         }
         if(_eventsDic[pLabelName])
         {
            newEvent = (_eventsDic[pLabelName] as TiphonEventInfo).duplicate();
            newEvent.label = pLabelName;
            this._events[pFrame].push(newEvent);
            newEvent.animationName = pAnimationName;
         }
         else
         {
            labelEvent = this.parseLabel(pLabelName);
            if(labelEvent)
            {
               _eventsDic[pLabelName] = labelEvent;
               labelEvent.animationName = pAnimationName;
               labelEvent.label = pLabelName;
               this._events[pFrame].push(labelEvent);
            }
            else
            {
               if(pLabelName != "END")
               {
                  ts = this._weakTiphonSprite.object as TiphonSprite;
                  _log.error("Found label \'" + pLabelName + "\' on sprite " + ts.look.getBone() + " (anim " + ts.getAnimation() + ")");
               }
            }
         }
      }
      
      public function removeEvents(pTypeName:String, pAnimation:String) : void {
         var frame:String = null;
         var events:Vector.<TiphonEventInfo> = null;
         var newEvents:Vector.<TiphonEventInfo> = null;
         var tei:TiphonEventInfo = null;
         for (frame in this._events)
         {
            events = this._events[frame];
            newEvents = new Vector.<TiphonEventInfo>();
            for each (tei in events)
            {
               if((!(tei.animationName == pAnimation)) || (!(tei.type == pTypeName)))
               {
                  newEvents.push(tei);
               }
            }
            if(newEvents.length != events.length)
            {
               this._events[frame] = newEvents;
            }
         }
      }
      
      private function parseLabel(pLabelName:String) : TiphonEventInfo {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function convertOldLabel(pLabelName:String) : TiphonEventInfo {
         var returnEvent:TiphonEventInfo = null;
         switch(pLabelName)
         {
            case EVENT_END:
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,EVENT_END);
               break;
            case PLAYER_STOP:
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,PLAYER_STOP);
               break;
            case EVENT_SHOT:
               returnEvent = new TiphonEventInfo(TiphonEvent.EVT_EVENT,EVENT_SHOT);
               break;
         }
         return returnEvent;
      }
   }
}
