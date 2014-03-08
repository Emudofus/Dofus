package com.ankamagames.dofus.internalDatacenter.connection
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SubscriberGift extends Object implements IDataCenter
   {
      
      public function SubscriberGift(param1:uint, param2:String, param3:String, param4:String) {
         super();
         this._id = param1;
         this._description = param2;
         this._link = param4;
         this._uri = param3;
      }
      
      private var _id:uint;
      
      private var _description:String;
      
      private var _uri:String;
      
      private var _link:String;
      
      public function get id() : uint {
         return this._id;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function get uri() : String {
         return this._uri;
      }
      
      public function get link() : String {
         return this._link;
      }
   }
}
