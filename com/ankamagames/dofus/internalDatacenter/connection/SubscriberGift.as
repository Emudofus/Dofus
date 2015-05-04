package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SubscriberGift extends Object implements IDataCenter
   {
      
      public function SubscriberGift(param1:String, param2:int, param3:String, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:String, param9:String)
      {
         super();
         this._name = param1;
         this._price = param2;
         this._priceCrossed = param3;
         this._visualUri = param4;
         this._newTag = param5;
         this._promotionTag = param6;
         this._redirect = param7;
         this._title = param8;
         this._onCliqueUri = param9;
      }
      
      private var _name:String;
      
      private var _price:int;
      
      private var _priceCrossed:String;
      
      private var _visualUri:String;
      
      private var _newTag:Boolean;
      
      private var _promotionTag:Boolean;
      
      private var _redirect:Boolean;
      
      private var _title:String;
      
      private var _onCliqueUri:String;
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get price() : int
      {
         return this._price;
      }
      
      public function get priceCrossed() : String
      {
         return this._priceCrossed;
      }
      
      public function get visualUri() : String
      {
         return this._visualUri;
      }
      
      public function get newTag() : Boolean
      {
         return this._newTag;
      }
      
      public function get promotionTag() : Boolean
      {
         return this._promotionTag;
      }
      
      public function get redirect() : Boolean
      {
         return this._redirect;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get onCliqueUri() : String
      {
         return this._onCliqueUri;
      }
   }
}
