package com.ankamagames.dofus.types.data
{
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   
   public dynamic class GenericSlotData extends Object implements ISlotData
   {
      
      public function GenericSlotData(param1:Uri=null, param2:Uri=null, param3:Uri=null, param4:String=null, param5:Boolean=true, param6:int=0) {
         super();
         this._iconUri = param1;
         this._fullSizeIconUri = param2;
         this._errorIconUri = param3;
         this._info1 = param4;
         this._active = param5;
         this._timer = param6;
      }
      
      private var _iconUri:Uri;
      
      private var _fullSizeIconUri:Uri;
      
      private var _errorIconUri:Uri;
      
      private var _info1:String;
      
      private var _active:Boolean;
      
      private var _timer:int;
      
      public function set fullSizeIconUri(param1:Uri) : void {
         this._fullSizeIconUri = param1;
      }
      
      public function set errorIconUri(param1:Uri) : void {
         this._errorIconUri = param1;
      }
      
      public function set info1(param1:String) : void {
         this._info1 = param1;
      }
      
      public function set timer(param1:int) : void {
         this._timer = param1;
      }
      
      public function set active(param1:Boolean) : void {
         this._active = param1;
      }
      
      public function set iconUri(param1:Uri) : void {
         this._iconUri = param1;
      }
      
      public function get iconUri() : Uri {
         return this._iconUri;
      }
      
      public function get fullSizeIconUri() : Uri {
         return this._fullSizeIconUri;
      }
      
      public function get errorIconUri() : Uri {
         return this._errorIconUri;
      }
      
      public function get info1() : String {
         return this._info1;
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
         return this._timer;
      }
      
      public function get active() : Boolean {
         return this._active;
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
   }
}
