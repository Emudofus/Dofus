package com.ankamagames.dofus.kernel.updaterv2.messages.impl
{
   import com.ankamagames.dofus.kernel.updaterv2.messages.IUpdaterOutputMessage;
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.dofus.kernel.updaterv2.messages.UpdaterMessageIDEnum;
   
   public class ActivateComponentMessage extends Object implements IUpdaterOutputMessage
   {
      
      public function ActivateComponentMessage(component:String, activate:Boolean = true, project:String = "game") {
         super();
         this._component = component;
         this._project = project;
         this._activate = activate;
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
