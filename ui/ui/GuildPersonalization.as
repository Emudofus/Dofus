package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.SocialApi;
   import flash.utils.Dictionary;
   import d2components.Texture;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2enums.GuildInformationsTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.ComponentHookList;
   import d2data.SpellWrapper;
   
   public class GuildPersonalization extends Object
   {
      
      public function GuildPersonalization() {
         this._compsBtnSpellUpgrade = new Dictionary(true);
         this._compsSpellSlot = new Dictionary(true);
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var socialApi:SocialApi;
      
      private var _allowModifyBoosts:Boolean;
      
      private var _stats:Array;
      
      private var _compsBtnSpellUpgrade:Dictionary;
      
      private var _compsSpellSlot:Dictionary;
      
      public var tx_image:Texture;
      
      public var gd_spell:Grid;
      
      public var ib_taxCollectorProspecting:ButtonContainer;
      
      public var ib_taxCollectorWisdom:ButtonContainer;
      
      public var ib_taxCollectorPods:ButtonContainer;
      
      public var ib_maxTaxCollectorsCount:ButtonContainer;
      
      public var lbl_boostPoints:Label;
      
      public var gd_stat:Grid;
      
      public function main(... params) : void {
         this.sysApi.addHook(GuildInfosUpgrade,this.onGuildInfosUpgrade);
         this.uiApi.addComponentHook(this.ib_taxCollectorProspecting,"onRelease");
         this.uiApi.addComponentHook(this.ib_taxCollectorProspecting,"onRollOver");
         this.uiApi.addComponentHook(this.ib_taxCollectorProspecting,"onRollOut");
         this.uiApi.addComponentHook(this.ib_taxCollectorWisdom,"onRelease");
         this.uiApi.addComponentHook(this.ib_taxCollectorWisdom,"onRollOver");
         this.uiApi.addComponentHook(this.ib_taxCollectorWisdom,"onRollOut");
         this.uiApi.addComponentHook(this.ib_taxCollectorPods,"onRelease");
         this.uiApi.addComponentHook(this.ib_taxCollectorPods,"onRollOver");
         this.uiApi.addComponentHook(this.ib_taxCollectorPods,"onRollOut");
         this.uiApi.addComponentHook(this.ib_maxTaxCollectorsCount,"onRelease");
         this.uiApi.addComponentHook(this.ib_maxTaxCollectorsCount,"onRollOver");
         this.uiApi.addComponentHook(this.ib_maxTaxCollectorsCount,"onRollOut");
         this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_BOOSTS));
         this.tx_image.mouseEnabled = false;
         this.tx_image.mouseChildren = false;
         this._allowModifyBoosts = this.socialApi.getGuild().manageGuildBoosts;
         this.displayBtnBoost(0);
      }
      
      public function unload() : void {
      }
      
      public function updateStatLine(data:*, components:*, selected:Boolean) : void {
         if(data)
         {
            components.lbl_title.text = data.text;
            components.lbl_value.text = data.value;
         }
         else
         {
            components.lbl_title.text = "";
            components.lbl_value.text = "";
         }
      }
      
      public function updateSpellLine(data:*, components:*, selected:Boolean) : void {
         var spell:Object = null;
         if(!this._compsBtnSpellUpgrade[components.btn_spellUpgrade.name])
         {
            this.uiApi.addComponentHook(components.btn_spellUpgrade,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_spellUpgrade,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_spellUpgrade,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsBtnSpellUpgrade[components.btn_spellUpgrade.name] = data;
         if(!this._compsSpellSlot[components.slot_icon.name])
         {
            this.uiApi.addComponentHook(components.slot_icon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_icon,ComponentHookList.ON_ROLL_OUT);
         }
         this._compsSpellSlot[components.slot_icon.name] = data;
         if(data != null)
         {
            spell = this.dataApi.getSpell(data.spell.id);
            components.slot_icon.data = data.spell;
            components.lbl_spellName.text = spell.name;
            components.lbl_spellLevel.text = data.baseLevel;
            if(data.displayUpgrade)
            {
               components.btn_spellUpgrade.visible = true;
            }
            else
            {
               components.btn_spellUpgrade.visible = false;
            }
         }
         else
         {
            components.slot_icon = null;
            components.lbl_spellName.text = "";
            components.lbl_spellLevel.text = "";
            components.btn_spellUpgrade.visible = false;
         }
      }
      
      private function displayBtnBoost(boosts:int) : void {
         this.ib_taxCollectorProspecting.visible = (boosts > 0) && (this._allowModifyBoosts);
         this.ib_taxCollectorWisdom.visible = (boosts > 0) && (this._allowModifyBoosts);
         this.ib_taxCollectorPods.visible = (boosts > 0) && (this._allowModifyBoosts);
         this.ib_maxTaxCollectorsCount.visible = (boosts > 9) && (this._allowModifyBoosts);
      }
      
      private function onGuildInfosUpgrade(boostPoints:uint, maxTaxCollectorsCount:uint, spellId:Object, spellLevel:Object, taxCollectorDamagesBonuses:uint, taxCollectorLifePoints:uint, taxCollectorPods:uint, taxCollectorProspecting:uint, taxCollectorsCount:uint, taxCollectorWisdom:uint) : void {
         var baseLevel:* = 0;
         var level:* = 0;
         var showUpgradeBtn:* = false;
         var spellSize:int = spellId.length;
         var spellList:Array = new Array(spellSize);
         var s:int = 0;
         while(s < spellSize)
         {
            baseLevel = spellLevel[s];
            level = baseLevel;
            showUpgradeBtn = (boostPoints > 0) && (this._allowModifyBoosts);
            if(level == 0)
            {
               level = 1;
            }
            if(level == 5)
            {
               showUpgradeBtn = false;
            }
            spellList[s] = 
               {
                  "displayUpgrade":showUpgradeBtn,
                  "spell":this.dataApi.getSpellWrapper(spellId[s],level),
                  "baseLevel":baseLevel
               };
            s++;
         }
         this.gd_spell.dataProvider = spellList;
         this.lbl_boostPoints.text = boostPoints.toString();
         this._stats = new Array();
         this._stats.push(
            {
               "text":this.uiApi.getText("ui.common.lifePoints"),
               "value":taxCollectorLifePoints
            });
         this._stats.push(
            {
               "text":this.uiApi.getText("ui.social.damagesBonus"),
               "value":taxCollectorDamagesBonuses
            });
         this._stats.push(
            {
               "text":this.uiApi.getText("ui.social.discernment"),
               "value":taxCollectorProspecting
            });
         this._stats.push(
            {
               "text":this.uiApi.getText("ui.stats.wisdom"),
               "value":taxCollectorWisdom
            });
         this._stats.push(
            {
               "text":this.uiApi.getText("ui.common.weight"),
               "value":taxCollectorPods
            });
         this._stats.push(
            {
               "text":this.uiApi.getText("ui.social.taxCollectorCount"),
               "value":maxTaxCollectorsCount
            });
         this.gd_stat.dataProvider = this._stats;
         this.displayBtnBoost(boostPoints);
      }
      
      public function onRelease(target:Object) : void {
         var data:Object = null;
         if(target == this.ib_taxCollectorPods)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequest(0));
         }
         else if(target == this.ib_taxCollectorProspecting)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequest(1));
         }
         else if(target == this.ib_taxCollectorWisdom)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequest(2));
         }
         else if(target == this.ib_maxTaxCollectorsCount)
         {
            this.sysApi.sendAction(new GuildCharacsUpgradeRequest(3));
         }
         else if(target.name.indexOf("btn_spellUpgrade") != -1)
         {
            data = this._compsBtnSpellUpgrade[target.name];
            this.sysApi.sendAction(new GuildSpellUpgradeRequest(data.spell.id));
         }
         
         
         
         
      }
      
      public function onRollOver(target:Object) : void {
         var data:Object = null;
         var textTooltip:String = "";
         if(target == this.ib_taxCollectorProspecting)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",1,1,500);
         }
         else if(target == this.ib_taxCollectorWisdom)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",1,1,400);
         }
         else if(target == this.ib_taxCollectorPods)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",1,20,5000);
         }
         else if(target == this.ib_maxTaxCollectorsCount)
         {
            textTooltip = this.uiApi.getText("ui.social.poneyCost",10,1,50);
         }
         else if(target.name.indexOf("btn_spellUpgrade") != -1)
         {
            textTooltip = this.uiApi.getText("ui.common.cost") + this.uiApi.getText("ui.common.colon") + "5";
         }
         else if(target.name.indexOf("slot_icon") != -1)
         {
            data = this._compsSpellSlot[target.name];
            if((!(target == null)) && (!(data == null)))
            {
               this.uiApi.showTooltip(data.spell as SpellWrapper,target,false,"standard",2,0,0);
            }
         }
         
         
         
         
         
         if(textTooltip != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip),target,false,"standard",6,0,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
