package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public class SimpleTextureWrapper extends Object implements ISlotData, IDataCenter
   {
      
      public function SimpleTextureWrapper() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(SimpleTextureWrapper));
      
      public static function create(param1:Uri) : SimpleTextureWrapper {
         var _loc2_:SimpleTextureWrapper = new SimpleTextureWrapper();
         _loc2_._uri = param1;
         return _loc2_;
      }
      
      private var _uri:Uri;
      
      public function get iconUri() : Uri {
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri {
         return this._uri;
      }
      
      public function get errorIconUri() : Uri {
         return null;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get info1() : String {
         return null;
      }
      
      public function get startTime() : int {
         return 0;
      }
      
      public function get endTime() : int {
         return 0;
      }
      
      public function set endTime(param1:int) : void {
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         return true;
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
   }
}
