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
      
      public function MutantTooltipInformation(pInfos:GameRolePlayMutantInformations) {
         this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
         super();
         this.infos = pInfos;
      }
      
      protected static const _log:Logger;
      
      private var _cssUri:String;
      
      public var infos:GameRolePlayMutantInformations;
      
      public var wingsEffect:int;
      
      public var titleName:String;
      
      public var titleColor:String;
      
      private function onCssLoaded() : void {
         var styleObj:Object = null;
         var _ssSheet:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         styleObj = _ssSheet.getStyle("itemset");
         this.titleColor = styleObj["color"];
      }
   }
}
