package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.jerakine.data.ICensoredDataItem;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class CensoredContent extends Object implements ICensoredDataItem, IDataCenter
   {
      
      public function CensoredContent() {
         super();
      }
      
      public static const MODULE:String = "CensoredContents";
      
      public static function getCensoredContents() : Array {
         return GameData.getObjects(MODULE);
      }
      
      private var _type:int;
      
      private var _oldValue:int;
      
      private var _newValue:int;
      
      private var _lang:String;
      
      public function get lang() : String {
         return this._lang;
      }
      
      public function set lang(param1:String) : void {
         this._lang = param1;
      }
      
      public function set type(param1:int) : void {
         this._type = param1;
      }
      
      public function get type() : int {
         return this._type;
      }
      
      public function set oldValue(param1:int) : void {
         this._oldValue = param1;
      }
      
      public function get oldValue() : int {
         return this._oldValue;
      }
      
      public function set newValue(param1:int) : void {
         this._newValue = param1;
      }
      
      public function get newValue() : int {
         return this._newValue;
      }
   }
}
