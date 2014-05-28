package com.ankamagames.dofus.kernel.updaterv2
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManagerV2;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ActivateComponentMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.GetComponentsListMessage;
   
   public class UpdaterApi extends Object implements IApi
   {
      
      public function UpdaterApi(handler:IUpdaterMessageHandler) {
         super();
         updaterConnection.addObserver(handler);
      }
      
      public static const updaterConnection:UpdaterConnexionHelper;
      
      public function sayHello() : void {
      }
      
      public function log(message:String) : void {
      }
      
      public function hasComponent(name:String) : Boolean {
         return PartManagerV2.getInstance().hasComponent(name);
      }
      
      public function activateComponent(name:String, activate:Boolean, projectName:String = "game") : void {
         var acm:ActivateComponentMessage = new ActivateComponentMessage(name,activate,projectName);
         updaterConnection.sendMessage(acm);
      }
      
      public function getComponentList(project:String = "game") : void {
         updaterConnection.sendMessage(new GetComponentsListMessage(project));
      }
   }
}
