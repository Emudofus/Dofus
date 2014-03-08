package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class XmlConfig extends Object
   {
      
      public function XmlConfig() {
         this._constants = new Array();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static var _self:XmlConfig;
      
      public static function getInstance() : XmlConfig {
         if(!_self)
         {
            _self = new XmlConfig();
         }
         return _self;
      }
      
      private var _constants:Array;
      
      public function init(param1:Array) : void {
         this._constants = param1;
      }
      
      public function addCategory(param1:Array) : void {
         var _loc2_:* = undefined;
         for (_loc2_ in param1)
         {
            this._constants[_loc2_] = param1[_loc2_];
         }
      }
      
      public function getEntry(param1:String) : * {
         return this._constants[param1];
      }
      
      public function getBooleanEntry(param1:String) : Boolean {
         var _loc2_:* = this._constants[param1];
         if(_loc2_ is String)
         {
            return String(_loc2_).toLowerCase() == "true" || _loc2_ == "1";
         }
         return _loc2_;
      }
      
      public function setEntry(param1:String, param2:*) : void {
         this._constants[param1] = param2;
      }
   }
}
