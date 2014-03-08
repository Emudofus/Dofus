package com.ankamagames.berilia.managers
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class GenericEventsManager extends Object
   {
      
      public function GenericEventsManager() {
         this._aEvent = new Array();
         this._listenerRef = new Dictionary(true);
         this._log = Log.getLogger(getQualifiedClassName(GenericEventsManager));
         super();
      }
      
      protected var _aEvent:Array;
      
      protected var _listenerRef:Dictionary;
      
      protected var _log:Logger;
      
      public function initialize() : void {
         this._aEvent = new Array();
      }
      
      public function registerEvent(param1:GenericListener) : void {
         this._listenerRef[param1] = true;
         if(this._aEvent[param1.event] == null)
         {
            this._aEvent[param1.event] = new Array();
         }
         this._aEvent[param1.event].push(param1);
         (this._aEvent[param1.event] as Array).sortOn("sortIndex",Array.NUMERIC | Array.DESCENDING);
      }
      
      public function removeEventListener(param1:GenericListener) : void {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         for (_loc2_ in this._aEvent)
         {
            for (_loc3_ in this._aEvent[_loc2_])
            {
               if(!(this._aEvent[_loc2_] == null || this._aEvent[_loc2_][_loc3_] == null))
               {
                  if(this._aEvent[_loc2_][_loc3_] == param1)
                  {
                     delete this._aEvent[_loc2_][[_loc3_]];
                     if(!this._aEvent[_loc2_].length)
                     {
                        this._aEvent[_loc2_] = null;
                        delete this._aEvent[[_loc2_]];
                     }
                  }
               }
            }
         }
      }
      
      public function removeEventListenerByName(param1:String) : void {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:GenericListener = null;
         for (_loc2_ in this._aEvent)
         {
            for (_loc3_ in this._aEvent[_loc2_])
            {
               if(!(this._aEvent[_loc2_] == null || this._aEvent[_loc2_][_loc3_] == null))
               {
                  _loc4_ = this._aEvent[_loc2_][_loc3_];
                  if(_loc4_.listener == param1)
                  {
                     delete this._aEvent[_loc2_][[_loc3_]];
                     if(!this._aEvent[_loc2_].length)
                     {
                        this._aEvent[_loc2_] = null;
                        delete this._aEvent[[_loc2_]];
                     }
                  }
               }
            }
         }
      }
      
      public function removeEvent(param1:*) : void {
         var _loc2_:GenericListener = null;
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         for (_loc4_ in this._aEvent)
         {
            _loc3_ = null;
            for (_loc5_ in this._aEvent[_loc4_])
            {
               if(!(this._aEvent[_loc4_] == null || this._aEvent[_loc4_][_loc5_] == null))
               {
                  _loc2_ = this._aEvent[_loc4_][_loc5_];
                  if(_loc2_.listener == param1)
                  {
                     if(!_loc3_)
                     {
                        _loc3_ = [];
                     }
                     _loc3_.push(_loc5_);
                  }
               }
            }
            for each (_loc6_ in _loc3_)
            {
               delete this._aEvent[_loc4_][[_loc6_]];
            }
         }
      }
   }
}
