package com.ankamagames.jerakine.data
{
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class XmlConfig extends Object
   {
         

      public function XmlConfig() {
         this._constants=new Array();
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
            _self=new XmlConfig();
         }
         return _self;
      }

      private var _constants:Array;

      public function init(constants:Array) : void {
         this._constants=constants;
      }

      public function addCategory(constants:Array) : void {
         var i:* = undefined;
         for (i in constants)
         {
            this._constants[i]=constants[i];
         }
      }

      public function getEntry(name:String) : * {
         return this._constants[name];
      }

      public function setEntry(sKey:String, sValue:*) : void {
         this._constants[sKey]=sValue;
      }
   }

}