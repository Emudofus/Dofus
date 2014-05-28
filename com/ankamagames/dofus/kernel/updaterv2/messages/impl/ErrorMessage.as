package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   
   public class ErrorMessage extends Object implements IUpdaterInputMessage
   {
      
      public function ErrorMessage() {
         super();
      }
      
      private var _type:int;
      
      private var _message:String;
      
      public function deserialize(data:Object) : void {
         this._type = data["_type"];
         this._message = data["error"];
      }
      
      public function get type() : int {
         return this._type;
      }
      
      public function get message() : String {
         return this._message;
      }
      
      public function toString() : String {
         return "[ErrorMessage type=" + this._type + ", message=" + this._message + "]";
      }
   }
}
