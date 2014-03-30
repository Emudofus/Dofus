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
      
      public function registerEvent(e:GenericListener) : void {
         this._listenerRef[e] = true;
         if(this._aEvent[e.event] == null)
         {
            this._aEvent[e.event] = new Array();
         }
         this._aEvent[e.event].push(e);
         (this._aEvent[e.event] as Array).sortOn("sortIndex",Array.NUMERIC | Array.DESCENDING);
      }
      
      public function removeEventListener(ge:GenericListener) : void {
         var i:String = null;
         var j:Object = null;
         for (i in this._aEvent)
         {
            for (j in this._aEvent[i])
            {
               if(!((this._aEvent[i] == null) || (this._aEvent[i][j] == null)))
               {
                  if(this._aEvent[i][j] == ge)
                  {
                     delete this._aEvent[i][[j]];
                     if(!this._aEvent[i].length)
                     {
                        this._aEvent[i] = null;
                        delete this._aEvent[[i]];
                     }
                  }
               }
            }
         }
      }
      
      public function removeEventListenerByName(name:String) : void {
         var i:String = null;
         var j:Object = null;
         var l:GenericListener = null;
         for (i in this._aEvent)
         {
            for (j in this._aEvent[i])
            {
               if(!((this._aEvent[i] == null) || (this._aEvent[i][j] == null)))
               {
                  l = this._aEvent[i][j];
                  if(l.listener == name)
                  {
                     delete this._aEvent[i][[j]];
                     if(!this._aEvent[i].length)
                     {
                        this._aEvent[i] = null;
                        delete this._aEvent[[i]];
                     }
                  }
               }
            }
         }
      }
      
      public function removeEvent(sListener:*) : void {
         var e:GenericListener = null;
         var deleteIndex:Array = null;
         var i:* = undefined;
         var j:* = undefined;
         var index:* = undefined;
         for (i in this._aEvent)
         {
            deleteIndex = null;
            for (j in this._aEvent[i])
            {
               if(!((this._aEvent[i] == null) || (this._aEvent[i][j] == null)))
               {
                  e = this._aEvent[i][j];
                  if(e.listener == sListener)
                  {
                     if(!deleteIndex)
                     {
                        deleteIndex = [];
                     }
                     deleteIndex.push(j);
                  }
               }
            }
            for each (index in deleteIndex)
            {
               delete this._aEvent[i][[index]];
            }
         }
      }
   }
}
