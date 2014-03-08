package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public class SlotDataHolderManager extends Object
   {
      
      public function SlotDataHolderManager(param1:ISlotData) {
         this._weakHolderReference = new Dictionary(true);
         super();
         this._linkedSlotsData = new Vector.<ISlotData>();
         this._linkedSlotsData.push(param1);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SlotDataHolderManager));
      
      private var _weakHolderReference:Dictionary;
      
      private var _linkedSlotsData:Vector.<ISlotData>;
      
      public function setLinkedSlotData(param1:ISlotData) : void {
         if(!this._linkedSlotsData)
         {
            this._linkedSlotsData = new Vector.<ISlotData>();
         }
         if(this._linkedSlotsData.indexOf(param1) == -1)
         {
            this._linkedSlotsData.push(param1);
         }
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
         this._weakHolderReference[param1] = true;
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
         delete this._weakHolderReference[[param1]];
      }
      
      public function getHolders() : Array {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         for (_loc2_ in this._weakHolderReference)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function refreshAll() : void {
         var _loc1_:Object = null;
         var _loc2_:ISlotData = null;
         for (_loc1_ in this._weakHolderReference)
         {
            for each (_loc2_ in this._linkedSlotsData)
            {
               if((_loc1_) && ISlotDataHolder(_loc1_).data === _loc2_)
               {
                  _loc1_.refresh();
               }
            }
         }
      }
   }
}
