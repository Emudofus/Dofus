package com.ankamagames.dofus.kernel.updaterv2
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManagerV2;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.ActivateComponentMessage;
   import com.ankamagames.dofus.kernel.updaterv2.messages.impl.GetComponentsListMessage;
   
   public class UpdaterApi extends Object implements IApi
   {
      
      public function UpdaterApi(param1:IUpdaterMessageHandler) {
         super();
         updaterConnection.addObserver(param1);
      }
      
      public static const updaterConnection:UpdaterConnexionHelper = new UpdaterConnexionHelper();
      
      public function sayHello() : void {
      }
      
      public function log(param1:String) : void {
      }
      
      public function hasComponent(param1:String) : Boolean {
         return PartManagerV2.getInstance().hasComponent(param1);
      }
      
      public function activateComponent(param1:String, param2:Boolean, param3:String="game") : void {
         var _loc4_:ActivateComponentMessage = new ActivateComponentMessage(param1,param2,param3);
         updaterConnection.sendMessage(_loc4_);
      }
      
      public function getComponentList(param1:String="game") : void {
         updaterConnection.sendMessage(new GetComponentsListMessage(param1));
      }
   }
}
