package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterInputMessage;
   
   public class StepMessage extends Object implements IUpdaterInputMessage
   {
      
      public function StepMessage() {
         super();
      }
      
      public static const CHECKING_UPDATE_STEP:String = "CheckingUpdate";
      
      public static const REMOTE_PROJECT_LOADED_STEP:String = "RemoteProjectLoaded";
      
      public static const UPDATING_STEP:String = "Updating";
      
      private var _step:String;
      
      public function get step() : String {
         return this._step;
      }
      
      public function deserialize(data:Object) : void {
         this._step = data["step"];
      }
      
      public function toString() : String {
         return "[StepMessage step=" + this._step + "]";
      }
   }
}
