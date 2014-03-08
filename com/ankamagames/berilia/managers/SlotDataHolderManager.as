package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public class SlotDataHolderManager extends Object
   {
      
      public function SlotDataHolderManager(linkedSlotData:ISlotData) {
         this._weakHolderReference = new Dictionary(true);
         super();
         this._linkedSlotsData = new Vector.<ISlotData>();
         this._linkedSlotsData.push(linkedSlotData);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SlotDataHolderManager));
      
      private var _weakHolderReference:Dictionary;
      
      private var _linkedSlotsData:Vector.<ISlotData>;
      
      public function setLinkedSlotData(slotData:ISlotData) : void {
         if(!this._linkedSlotsData)
         {
            this._linkedSlotsData = new Vector.<ISlotData>();
         }
         if(this._linkedSlotsData.indexOf(slotData) == -1)
         {
            this._linkedSlotsData.push(slotData);
         }
      }
      
      public function addHolder(h:ISlotDataHolder) : void {
         this._weakHolderReference[h] = true;
      }
      
      public function removeHolder(h:ISlotDataHolder) : void {
         delete this._weakHolderReference[[h]];
      }
      
      public function getHolders() : Array {
         var h:Object = null;
         var result:Array = [];
         for (h in this._weakHolderReference)
         {
            result.push(h);
         }
         return result;
      }
      
      public function refreshAll() : void {
         var h:Object = null;
         var linkedSlotData:ISlotData = null;
         for (h in this._weakHolderReference)
         {
            for each (linkedSlotData in this._linkedSlotsData)
            {
               if((h) && (ISlotDataHolder(h).data === linkedSlotData))
               {
                  h.refresh();
               }
            }
         }
      }
   }
}
