package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionTitle;
   import com.ankamagames.dofus.network.types.game.context.roleplay.HumanOptionOrnament;
   
   public class CharacterTooltipInformation extends Object
   {
      
      public function CharacterTooltipInformation(pInfos:GameRolePlayHumanoidInformations, pWingsEffect:int) {
         var playerInfo:GameRolePlayCharacterInformations = null;
         var titleId:* = 0;
         var titleParam:String = null;
         var ornamentId:* = 0;
         var option:* = undefined;
         var title:Title = null;
         var ornament:Ornament = null;
         this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
         super();
         this.infos = pInfos;
         this.wingsEffect = pWingsEffect;
         if(pInfos is GameRolePlayCharacterInformations)
         {
            playerInfo = pInfos as GameRolePlayCharacterInformations;
            CssManager.getInstance().askCss(this._cssUri,new Callback(this.onCssLoaded));
            for each(option in pInfos.humanoidInfo.options)
            {
               if(option is HumanOptionTitle)
               {
                  titleId = option.titleId;
                  titleParam = option.titleParam;
               }
               if(option is HumanOptionOrnament)
               {
                  ornamentId = option.ornamentId;
               }
            }
            if(titleId)
            {
               title = Title.getTitleById(titleId);
               if(title)
               {
                  if(pInfos.humanoidInfo.sex == 0)
                  {
                     this.titleName = "« " + title.nameMale + " »";
                  }
                  else
                  {
                     this.titleName = "« " + title.nameFemale + " »";
                  }
                  if(titleParam)
                  {
                     this.titleName = this.titleName.split("%1").join(titleParam);
                  }
               }
            }
            if(ornamentId)
            {
               ornament = Ornament.getOrnamentById(ornamentId);
               this.ornamentAssetId = ornament.assetId;
            }
         }
      }
      
      protected static const _log:Logger;
      
      private var _cssUri:String;
      
      public var infos:GameRolePlayHumanoidInformations;
      
      public var wingsEffect:int;
      
      public var titleName:String;
      
      public var titleColor:String;
      
      public var ornamentAssetId:int;
      
      private function onCssLoaded() : void {
         var styleObj:Object = null;
         var _ssSheet:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         styleObj = _ssSheet.getStyle("itemset");
         this.titleColor = styleObj["color"];
      }
   }
}
