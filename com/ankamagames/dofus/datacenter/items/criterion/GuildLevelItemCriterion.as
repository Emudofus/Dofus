package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   
   public class GuildLevelItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function GuildLevelItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = _criterionValue.toString();
         var _loc2_:String = I18n.getUiText("ui.guild.guildLevel");
         return _loc2_ + " " + _operator.text + " " + _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:GuildLevelItemCriterion = new GuildLevelItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         var _loc1_:GuildWrapper = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild;
         if(_loc1_)
         {
            return _loc1_.level;
         }
         return 0;
      }
   }
}
