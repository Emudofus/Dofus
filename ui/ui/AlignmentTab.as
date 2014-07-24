package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.AlignmentApi;
   import d2api.DataApi;
   import d2api.SoundApi;
   import d2components.Label;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.EntityDisplayer;
   import d2components.Grid;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   import flash.geom.ColorTransform;
   import d2enums.AggressableStatusEnum;
   
   public class AlignmentTab extends Object
   {
      
      public function AlignmentTab() {
         this._listRanksID = new Vector.<int>(6,true);
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var alignApi:AlignmentApi;
      
      public var dataApi:DataApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      private var _characterInfos:Object;
      
      private var _alignmentInfos:Object;
      
      private var _listRanksID:Vector.<int>;
      
      private var _pvpEnabled:Boolean = false;
      
      private var _percentBalance:uint;
      
      public var lbl_alignment:Label;
      
      public var lbl_alignmentInfo:Label;
      
      public var btn_lbl_btn_pvp:Label;
      
      public var lbl_alignmentGrade:Label;
      
      public var lbl_order:Label;
      
      public var lbl_balance:Label;
      
      public var tx_alignmentIcon:Texture;
      
      public var tx_orderIcon:Texture;
      
      public var tx_wing:Texture;
      
      public var tx_pvpOff:Texture;
      
      public var tx_neutralAlignment:Texture;
      
      public var tx_progressBar1:Texture;
      
      public var tx_progressBG1:Texture;
      
      public var btn_pvp:ButtonContainer;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var gd_aliBonus:Grid;
      
      public var gd_gift:Grid;
      
      public var gd_specializations:Grid;
      
      public function main(oParam:Object = null) : void {
         var list:Object = null;
         var numBtn:* = 0;
         var ar:Object = null;
         var i:* = 0;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(CharacterStatsList,this.onCharacterStatsList);
         this.uiApi.addComponentHook(this.tx_progressBar1,"onRollOver");
         this.uiApi.addComponentHook(this.tx_progressBar1,"onRollOut");
         this.uiApi.addComponentHook(this.tx_progressBG1,"onRollOver");
         this.uiApi.addComponentHook(this.tx_progressBG1,"onRollOut");
         this.uiApi.addComponentHook(this.btn_pvp,"onRollOver");
         this.uiApi.addComponentHook(this.btn_pvp,"onRollOut");
         this.uiApi.addComponentHook(this.entityDisplayer,"onEntityReady");
         this._characterInfos = this.playerApi.getPlayedCharacterInfo();
         this.entityDisplayer.look = this._characterInfos.entityLook;
         this._alignmentInfos = this.playerApi.characteristics().alignmentInfos;
         var alignment:int = this._alignmentInfos.alignmentSide;
         this.displayPvpInformations();
         this.tx_progressBar1.transform.colorTransform = new ColorTransform(1,1,1,1,53,-44,-136);
         var alignmentSide:Object = this.alignApi.getSide(alignment);
         this.lbl_alignment.text = this.uiApi.getText("ui.common.alignment") + " " + alignmentSide.name;
         var playerRank:int = this.alignApi.getPlayerRank();
         var alignmentRank:Object = this.alignApi.getRank(playerRank);
         this.lbl_alignmentInfo.text = alignmentRank.name + " - " + this.uiApi.getText("ui.common.level") + " " + this._alignmentInfos.alignmentValue;
         this.lbl_order.text = this.alignApi.getOrder(alignmentRank.orderId).name;
         if(alignment == 0)
         {
            this.tx_neutralAlignment.visible = true;
            this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusNeutre.png");
         }
         else
         {
            this.tx_neutralAlignment.visible = false;
            if(alignment == 1)
            {
               this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusBontarien.png");
            }
            else if(alignment == 2)
            {
               this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusBrakmarien.png");
            }
            else if(alignment == 3)
            {
               this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusMercenaire.png");
            }
            
            
         }
         if(((alignment == 1) || (alignment == 2) || (alignment == 3)) && (alignmentRank))
         {
            this.tx_orderIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "order_" + alignmentRank.orderId + ".png");
         }
         else if(alignment == 0)
         {
            this.tx_orderIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "order_" + alignment + ".png");
         }
         
         if(alignment != 0)
         {
            this.btn_pvp.visible = true;
            list = this.alignApi.getOrderRanks(alignmentRank.orderId);
            this.gd_specializations.dataProvider = list;
            if((this._alignmentInfos.alignmentSide == 3) || (alignmentRank.minimumAlignment < 20))
            {
               this.gd_specializations.selectedIndex = Math.floor(alignmentRank.minimumAlignment / 20);
            }
            else
            {
               this.gd_specializations.selectedIndex = Math.floor(alignmentRank.minimumAlignment / 20) - 1;
            }
            numBtn = 0;
            for each(ar in list)
            {
               this._listRanksID[numBtn] = ar.id;
               numBtn++;
            }
            i = numBtn;
            while(i < 6)
            {
               this._listRanksID[numBtn] = -1;
               numBtn++;
               i++;
            }
            if(this.sysApi.getCurrentServer().gameTypeId == 1)
            {
               this.btn_pvp.softDisabled = true;
            }
            else
            {
               this.btn_pvp.softDisabled = false;
            }
         }
         else
         {
            this.btn_pvp.visible = false;
         }
      }
      
      public function updateAliBonusLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_valueP.text = data.valueP;
            componentsRef.lbl_valueM.text = data.valueM;
         }
         else
         {
            componentsRef.lbl_title.text = "";
            componentsRef.lbl_valueP.text = "";
            componentsRef.lbl_valueM.text = "";
         }
      }
      
      public function updateSpecLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.specItemCtr.selected = selected;
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_level.text = data.minimumAlignment;
            if((this._alignmentInfos.alignmentValue - data.minimumAlignment >= 0) && (this._alignmentInfos.alignmentValue - data.minimumAlignment < 20))
            {
               componentsRef.tx_whiteArrow.visible = true;
            }
            else
            {
               componentsRef.tx_whiteArrow.visible = false;
            }
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_level.text = "";
            componentsRef.tx_whiteArrow.visible = false;
         }
      }
      
      private function displayPvpInformations() : void {
         if((this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE) || (this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE))
         {
            this._pvpEnabled = true;
            this.btn_lbl_btn_pvp.text = this.uiApi.getText("ui.pvp.disabled");
            this.tx_pvpOff.visible = false;
            this.tx_wing.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "wings.swf|demonAngel");
            this.tx_wing.gotoAndStop = (this._alignmentInfos.alignmentSide - 1) * 10 + 1 + this._alignmentInfos.alignmentGrade;
            this.lbl_alignmentGrade.text = this._alignmentInfos.alignmentGrade + " (" + this.alignApi.getTitleName(this._alignmentInfos.alignmentSide,this._alignmentInfos.alignmentGrade) + ")";
            this.tx_progressBar1.width = int(this._alignmentInfos.honor / 20000 * (this.tx_progressBG1.width - 2));
         }
         else
         {
            this._pvpEnabled = false;
            this.btn_lbl_btn_pvp.text = this.uiApi.getText("ui.pvp.enabled");
            this.tx_pvpOff.visible = true;
            this.tx_wing.uri = null;
            this.lbl_alignmentGrade.text = "-";
            this.tx_progressBar1.width = 0;
         }
      }
      
      private function displayGifts(rankId:int) : void {
         var gifts:Object = null;
         var nGifts:* = 0;
         var i:* = 0;
         var gift:Object = null;
         var giftInfo:Object = null;
         var giftEffect:Object = null;
         var giftProvider:Array = new Array();
         var alignmentRankJntGift:Object = this.alignApi.getRankGifts(rankId);
         if(alignmentRankJntGift)
         {
            gifts = alignmentRankJntGift.gifts;
            nGifts = gifts.length;
            i = 0;
            while(i < nGifts)
            {
               gift = this.alignApi.getGift(gifts[i]);
               giftInfo = new Object();
               giftInfo.giftName = gift.name;
               giftInfo.giftUri = this.uiApi.createUri(this.uiApi.me().getConstant("gifts_uri") + "assets.swf|gift_" + gift.gfxId);
               giftInfo.giftLevel = alignmentRankJntGift.levels[i];
               giftInfo.param = alignmentRankJntGift.parameters[i];
               giftEffect = this.alignApi.getEffect(gift.effectId);
               if(giftEffect)
               {
                  giftInfo.giftEffect = giftEffect.description;
               }
               giftProvider.push(giftInfo);
               i++;
            }
         }
         this.gd_gift.dataProvider = giftProvider;
      }
      
      private function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void {
         if(!oneLifePointRegenOnly)
         {
            this._alignmentInfos = this.playerApi.characteristics().alignmentInfos;
            if((this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE) || (this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE))
            {
               if(!this._pvpEnabled)
               {
                  this.displayPvpInformations();
               }
            }
            else if(this._pvpEnabled)
            {
               this.displayPvpInformations();
            }
            
         }
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_pvp)
         {
            this.sysApi.sendAction(new SetEnablePVPRequest(!this._pvpEnabled));
         }
      }
      
      public function onRollOver(target:Object) : void {
         var textTooltip:String = null;
         if((target == this.tx_progressBar1) || (target == this.tx_progressBG1))
         {
            target = this.tx_progressBG1;
            textTooltip = String(this._alignmentInfos.honor);
         }
         else if(target == this.lbl_balance)
         {
            textTooltip = this.dataApi.getAlignmentBalance(this._percentBalance).description;
         }
         else if((target == this.btn_pvp) && (this.btn_pvp.softDisabled))
         {
            textTooltip = this.uiApi.getText("ui.grimoire.alignment.hardcore");
         }
         
         
         if(textTooltip)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip),target,false,"standard",7,1,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.gd_specializations)
         {
            if((this._alignmentInfos.alignmentSide == 3) || (target.selectedItem.minimumAlignment < 20))
            {
               this.displayGifts(this._listRanksID[Math.floor(target.selectedItem.minimumAlignment / 20)]);
            }
            else
            {
               this.displayGifts(this._listRanksID[Math.floor(target.selectedItem.minimumAlignment / 20) - 1]);
            }
         }
      }
      
      public function onEntityReady(target:Object) : void {
         var slotPos:* = this.entityDisplayer.getSlotPosition("Cape_2");
         if(slotPos)
         {
            this.tx_wing.x = this.entityDisplayer.x + slotPos.x;
            this.tx_wing.y = this.entityDisplayer.y + this.entityDisplayer.height + slotPos.y;
         }
         else
         {
            this.tx_wing.x = this.entityDisplayer.x + this.entityDisplayer.width / 2;
         }
      }
      
      public function unload() : void {
      }
   }
}
