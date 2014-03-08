package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   
   public class GuildItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function GuildItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         if(_criterionValue == 0)
         {
            return I18n.getUiText("ui.criterion.noguild");
         }
         if(_criterionValue == 1)
         {
            return I18n.getUiText("ui.criterion.hasGuild");
         }
         return I18n.getUiText("ui.criterion.hasValidGuild");
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:GuildItemCriterion = new GuildItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var guild:GuildWrapper = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
         if(guild)
         {
            if(guild.enabled)
            {
               return 2;
            }
            return 1;
         }
         return 0;
      }
   }
}
