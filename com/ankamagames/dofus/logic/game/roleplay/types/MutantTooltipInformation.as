package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayMutantInformations;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.jerakine.data.XmlConfig;
   
   public class MutantTooltipInformation extends Object
   {
      
      public function MutantTooltipInformation(param1:GameRolePlayMutantInformations) {
         this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
         super();
         this.infos = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MutantTooltipInformation));
      
      private var _cssUri:String;
      
      public var infos:GameRolePlayMutantInformations;
      
      public var wingsEffect:int;
      
      public var titleName:String;
      
      public var titleColor:String;
      
      private function onCssLoaded() : void {
         var _loc2_:Object = null;
         var _loc1_:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         _loc2_ = _loc1_.getStyle("itemset");
         this.titleColor = _loc2_["color"];
      }
   }
}
