package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   
   public class ServerItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function ServerItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterionValue:String = Server.getServerById(_criterionValue).name;
         var readableCriterionRef:String = I18n.getUiText("ui.header.server");
         return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:ServerItemCriterion = new ServerItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayerManager.getInstance().server.id;
      }
   }
}
