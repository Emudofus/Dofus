package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageIDEnum;
   
   public class ActivateComponentMessage extends Object implements IUpdaterOutputMessage
   {
      
      public function ActivateComponentMessage(param1:String, param2:Boolean=true, param3:String="game") {
         super();
         this._component = param1;
         this._project = param3;
         this._activate = param2;
      }
      
      private var _component:String;
      
      private var _project:String;
      
      private var _activate:Boolean;
      
      public function get component() : String {
         return this._component;
      }
      
      public function get project() : String {
         return this._project;
      }
      
      public function get activate() : Boolean {
         return this._activate;
      }
      
      public function serialize() : String {
         return by.blooddy.crypto.serialization.JSON.encode(
            {
               "_msg_id":UpdaterMessageIDEnum.ACTIVATE_COMPONENT,
               "component":this._component,
               "project":this._project,
               "activate":this._activate
            });
      }
      
      public function toString() : String {
         return "[ActivateComponentMessage component=" + this._component + " project=" + this._project + " activation=" + this._activate + "]";
      }
   }
}
