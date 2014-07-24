package ui
{
   import flash.utils.Timer;
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import d2api.SystemApi;
   import d2components.Texture;
   import d2components.Label;
   import d2hooks.*;
   import flash.events.TimerEvent;
   import d2data.Monster;
   
   public class WorldMonsterFighterTooltipUi extends Object
   {
      
      public function WorldMonsterFighterTooltipUi() {
         this._icons = new Vector.<Texture>(0);
         super();
      }
      
      private var _timerHide:Timer;
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      public var sysApi:SystemApi;
      
      private var _inPrefight:Boolean;
      
      private var _icons:Vector.<Texture>;
      
      public var lbl_text:Label;
      
      public var lbl_title:Label;
      
      public var lbl_damage:Label;
      
      public var backgroundCtr:Object;
      
      public var mainCtr:Object;
      
      public function main(oParam:Object = null) : void {
         this.updateContent(oParam);
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset,true,oParam.data.disposition.cellId);
         if(oParam.autoHide)
         {
            this._timerHide = new Timer(2500);
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.start();
         }
      }
      
      public function updateContent(oParam:Object) : void {
         var tx:Texture = null;
         var beforeLevelText:String = null;
         var monsterId:* = 0;
         var m:Monster = null;
         var effectIcons:Array = null;
         var line:String = null;
         var i:* = 0;
         var tx_icon:Texture = null;
         var txIconHeight:* = NaN;
         var txIconWidth:* = NaN;
         var centerX:* = NaN;
         var lineSize:Object = null;
         var showName:Boolean = this.fightApi.isMouseOverFighter(oParam.data.contextualId)?true:false;
         this._inPrefight = Api.fight.preFightIsActive();
         if(this._inPrefight)
         {
            beforeLevelText = "";
            monsterId = Api.fight.getMonsterId(oParam.data.contextualId);
            if(monsterId > -1)
            {
               m = Api.data.getMonsterFromId(monsterId);
               if(m.isBoss)
               {
                  beforeLevelText = Api.ui.getText("ui.item.boss");
               }
               else if(m.isMiniBoss)
               {
                  beforeLevelText = Api.ui.getText("ui.item.miniboss");
               }
               
            }
            if(beforeLevelText != "")
            {
               beforeLevelText = beforeLevelText + (" " + Api.ui.getText("ui.common.short.level"));
            }
            else
            {
               beforeLevelText = beforeLevelText + Api.ui.getText("ui.common.level");
            }
            this.lbl_text.text = Api.fight.getFighterName(oParam.data.contextualId);
            this.lbl_title.text = beforeLevelText + " " + Api.fight.getFighterLevel(oParam.data.contextualId);
         }
         else
         {
            this.lbl_title.text = "";
            if(oParam.data.stats.shieldPoints > 0)
            {
               this.lbl_text.text = (showName?Api.fight.getFighterName(oParam.data.contextualId) + " ":"") + "(" + oParam.data.stats.lifePoints;
               this.lbl_text.appendText("+" + oParam.data.stats.shieldPoints,"shield");
               this.lbl_text.appendText(")","p");
            }
            else
            {
               this.lbl_text.text = (showName?Api.fight.getFighterName(oParam.data.contextualId) + " ":"") + "(" + oParam.data.stats.lifePoints + ")";
            }
         }
         this.lbl_text.fullWidth();
         this.lbl_title.fullWidth();
         this.lbl_title.y = 20;
         var posX:int = (this.lbl_title.width - this.lbl_text.width) / 2;
         if(posX < 0)
         {
            posX = posX * -1;
            this.lbl_title.x = posX;
            this.lbl_text.x = 0;
         }
         else
         {
            this.lbl_title.x = 0;
            this.lbl_text.x = posX;
         }
         this.backgroundCtr.height = 35;
         if(this.lbl_title.text != "")
         {
            this.backgroundCtr.height = this.backgroundCtr.height + 20;
         }
         this.lbl_damage.text = "";
         var maxWidth:Number = this.getMaxLabelWidth();
         var offsetIcon:Number = 0;
         for each(tx in this._icons)
         {
            tx.remove();
            this._icons.splice(this._icons.indexOf(tx),1);
         }
         this.lbl_damage.width = 1;
         this.lbl_damage.removeFromParent();
         if((oParam.makerParam) && (oParam.makerParam.spellDamage))
         {
            this.mainCtr.addContent(this.lbl_damage);
            this.lbl_damage.y = this.lbl_text.y + 20;
            this.lbl_damage.appendText(oParam.makerParam.spellDamage);
            this.lbl_damage.fullWidth();
            effectIcons = oParam.makerParam.spellDamage.effectIcons;
            txIconHeight = 17;
            txIconWidth = 17;
            i = 0;
            while(i < this.lbl_damage.textfield.numLines)
            {
               line = this.lbl_damage.textfield.getLineText(i);
               if(effectIcons[i])
               {
                  tx_icon = this.uiApi.createComponent("Texture") as Texture;
                  tx_icon.uri = this.uiApi.createUri(Tooltips.STATS_ICONS_PATH + effectIcons[i]);
                  tx_icon.finalize();
                  lineSize = this.uiApi.getTextSize(line,this.lbl_damage.css,this.lbl_damage.cssClass);
                  tx_icon.y = this.lbl_damage.y + lineSize.height * i + 8;
                  centerX = this.getMaxLabelWidth() / 2;
                  tx_icon.x = centerX - lineSize.width / 2 - txIconWidth - 2;
                  if(tx_icon.x < 0)
                  {
                     offsetIcon = txIconWidth;
                     tx_icon.x = tx_icon.x + txIconWidth;
                  }
                  this.mainCtr.addContent(tx_icon);
                  this._icons.push(tx_icon);
               }
               i++;
            }
            maxWidth = this.getMaxLabelWidth();
            this.lbl_text.x = maxWidth / 2 - this.lbl_text.width / 2 + offsetIcon;
            this.lbl_damage.x = maxWidth / 2 - this.lbl_damage.width / 2 + offsetIcon;
            this.backgroundCtr.height = this.backgroundCtr.height + this.lbl_damage.height;
         }
         this.backgroundCtr.width = maxWidth + 12 + offsetIcon;
      }
      
      private function getMaxLabelWidth() : Number {
         var maxWidth:* = NaN;
         if(this.lbl_title.text != "")
         {
            maxWidth = this.lbl_title.width;
         }
         if((!(this.lbl_text.text == "")) && ((isNaN(maxWidth)) || (this.lbl_text.width > maxWidth)))
         {
            maxWidth = this.lbl_text.width;
         }
         if((!(this.lbl_damage.text == "")) && ((isNaN(maxWidth)) || (this.lbl_damage.width > maxWidth)))
         {
            maxWidth = this.lbl_damage.width;
         }
         return maxWidth;
      }
      
      private function onTimer(e:TimerEvent) : void {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this.uiApi.hideTooltip(this.uiApi.me().name);
      }
      
      public function unload() : void {
         if(this._timerHide)
         {
            this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.stop();
            this._timerHide = null;
         }
      }
   }
}
