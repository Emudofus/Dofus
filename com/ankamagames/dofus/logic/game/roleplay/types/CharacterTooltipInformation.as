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
      
      public function CharacterTooltipInformation(param1:GameRolePlayHumanoidInformations, param2:int) {
         var _loc3_:GameRolePlayCharacterInformations = null;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc7_:* = undefined;
         var _loc8_:Title = null;
         var _loc9_:Ornament = null;
         this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/tooltip_title.css";
         super();
         this.infos = param1;
         this.wingsEffect = param2;
         if(param1 is GameRolePlayCharacterInformations)
         {
            _loc3_ = param1 as GameRolePlayCharacterInformations;
            CssManager.getInstance().askCss(this._cssUri,new Callback(this.onCssLoaded));
            for each (_loc7_ in param1.humanoidInfo.options)
            {
               if(_loc7_ is HumanOptionTitle)
               {
                  _loc4_ = _loc7_.titleId;
                  _loc5_ = _loc7_.titleParam;
               }
               if(_loc7_ is HumanOptionOrnament)
               {
                  _loc6_ = _loc7_.ornamentId;
               }
            }
            if(_loc4_)
            {
               _loc8_ = Title.getTitleById(_loc4_);
               if(_loc8_)
               {
                  if(param1.humanoidInfo.sex == 0)
                  {
                     this.titleName = "« " + _loc8_.nameMale + " »";
                  }
                  else
                  {
                     this.titleName = "« " + _loc8_.nameFemale + " »";
                  }
                  if(_loc5_)
                  {
                     this.titleName = this.titleName.split("%1").join(_loc5_);
                  }
               }
            }
            if(_loc6_)
            {
               _loc9_ = Ornament.getOrnamentById(_loc6_);
               this.ornamentAssetId = _loc9_.assetId;
            }
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterTooltipInformation));
      
      private var _cssUri:String;
      
      public var infos:GameRolePlayHumanoidInformations;
      
      public var wingsEffect:int;
      
      public var titleName:String;
      
      public var titleColor:String;
      
      public var ornamentAssetId:int;
      
      private function onCssLoaded() : void {
         var _loc2_:Object = null;
         var _loc1_:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         _loc2_ = _loc1_.getStyle("itemset");
         this.titleColor = _loc2_["color"];
      }
   }
}
