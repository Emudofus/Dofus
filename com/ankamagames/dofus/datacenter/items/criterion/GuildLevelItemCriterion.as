package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   
   public class GuildLevelItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function GuildLevelItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterionValue:String = _criterionValue.toString();
         var readableCriterionRef:String = I18n.getUiText("ui.guild.guildLevel");
         return readableCriterionRef + " " + _operator.text + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:GuildLevelItemCriterion = new GuildLevelItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var guild:GuildWrapper = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
         if(guild)
         {
            return guild.level;
         }
         return 0;
      }
   }
}
