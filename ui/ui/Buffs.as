package ui
{
   import ui.items.BuffItem;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.FightApi;
   import d2api.PlayedCharacterApi;
   import flash.utils.Dictionary;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import d2components.GraphicContainer;
   import d2hooks.*;
   import d2data.EffectsWrapper;
   import d2actions.TimelineEntityOver;
   import d2enums.LocationEnum;
   import d2actions.TimelineEntityOut;
   
   public class Buffs extends Object
   {
      
      public function Buffs() {
         super();
      }
      
      private static function sortCastingSpellGroup(a:BuffItem, b:BuffItem) : int {
         return a.maxCooldown - b.maxCooldown;
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var fightApi:FightApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _buffItems:Dictionary;
      
      private var _durationSort:Array;
      
      private var _nPlayerId:int;
      
      private var _expanded:Boolean = false;
      
      private var _casterId:int;
      
      private var _lastWasPlayer:Boolean = false;
      
      private var _rollOverTarget:Object = null;
      
      public var tx_background:Texture;
      
      public var btn_decoRight:ButtonContainer;
      
      public var buffsCtr:GraphicContainer;
      
      public var buffListCtr:GraphicContainer;
      
      public var anchorCtr:GraphicContainer;
      
      public var expandedCtr:GraphicContainer;
      
      public function main(targetId:int) : void {
         this.sysApi.addHook(GameFightTurnStart,this.onGameFightTurnStart);
         this.sysApi.addHook(BuffUpdate,this.onBuffUpdate);
         this.sysApi.addHook(BuffRemove,this.onBuffRemove);
         this.sysApi.addHook(BuffAdd,this.onBuffAdd);
         this.sysApi.addHook(UiLoaded,this.onUiLoaded);
         this._nPlayerId = targetId;
         this.makeItemBuffs(targetId);
         this.updateUi();
      }
      
      public function unload() : void {
      }
      
      public function set folded(fold:Boolean) : void {
         if(fold)
         {
            this.buffListCtr.visible = false;
            this.tx_background.visible = false;
         }
         else
         {
            this.buffListCtr.visible = true;
            this.tx_background.visible = true;
         }
      }
      
      private function makeItemBuffs(playerId:int) : void {
         var buff:Object = null;
         this._buffItems = new Dictionary();
         this._durationSort = new Array();
         var buffList:Object = this.fightApi.getBuffList(playerId);
         for each(buff in buffList)
         {
            this.internalAddBuff(buff);
         }
      }
      
      private function newBuffItem(buff:Object) : BuffItem {
         var buffItem:BuffItem = new BuffItem(buff.castingSpell.spell.id,buff.castingSpell.casterId,buff.parentBoostUid,(buff.effects.hasOwnProperty("delay")) && (buff.effects.delay > 0)?BuffItem.getEndDelayTurn(buff):-1,this.uiApi.me().getConstant("spell_size"),this.uiApi.me().getConstant("css_uri"),this.buffListCtr,0);
         this.uiApi.addComponentHook(buffItem.btn_buff,"onRelease");
         this.uiApi.addComponentHook(buffItem.btn_buff,"onRollOver");
         this.uiApi.addComponentHook(buffItem.btn_buff,"onRollOut");
         buffItem.addBuff(buff);
         return buffItem;
      }
      
      private function updateUi() : void {
         var tmpSorted:Array = null;
         var boosts:Array = null;
         var buffItem:BuffItem = null;
         var boost:BuffItem = null;
         var totalWidth:* = 0;
         var posX:* = 0;
         var posY:* = 0;
         var hasBuff:* = false;
         var cooldownPos:* = 0;
         var i:* = 0;
         if(this._expanded)
         {
            this.tx_background.width = 0;
            this.buffListCtr.width = 0;
            this.expandedCtr.x = this.anchorCtr.x;
            this.expandedCtr.y = this.anchorCtr.y;
            this.uiApi.showTooltip(this._durationSort,null,false,"effectsDuration",8,6,3,"effectsDuration",null,null,null,false,2);
         }
         else
         {
            tmpSorted = new Array();
            boosts = new Array();
            for each(buffItem in this._buffItems)
            {
               if(buffItem.parentBoostUid != 0)
               {
                  boosts.push(buffItem);
               }
               else
               {
                  tmpSorted.push(buffItem);
               }
            }
            tmpSorted.sort(sortCastingSpellGroup);
            for each(boost in boosts)
            {
               hasBuff = false;
               cooldownPos = 0;
               i = 0;
               while(i < tmpSorted.length)
               {
                  if(tmpSorted[i].maxCooldown < boost.cooldown)
                  {
                     cooldownPos = i;
                  }
                  if(tmpSorted[i].hasUid(boost.parentBoostUid))
                  {
                     tmpSorted.splice(i + 1,0,boost);
                     hasBuff = true;
                     break;
                  }
                  i++;
               }
               if(!hasBuff)
               {
                  tmpSorted.splice(cooldownPos,0,boost);
               }
            }
            totalWidth = tmpSorted.length * this.uiApi.me().getConstant("spell_size") + (tmpSorted.length - 1) * this.uiApi.me().getConstant("spell_offset_horizontal");
            if(totalWidth < 0)
            {
               totalWidth = 0;
            }
            posX = totalWidth;
            posY = 0;
            for each(buffItem in tmpSorted)
            {
               posX = posX - this.uiApi.me().getConstant("spell_size");
               buffItem.x = posX;
               buffItem.y = posY;
               posX = posX - this.uiApi.me().getConstant("spell_offset_horizontal");
            }
            this.tx_background.width = totalWidth + 2 * this.uiApi.me().getConstant("spell_offset_horizontal") + this.btn_decoRight.width;
            this.expandedCtr.width = 0;
            this.btn_decoRight.reset();
            this.refreshBuffTooltips();
         }
         this.buffsCtr.x = this.anchorCtr.x - this.tx_background.width + 6;
         this.buffsCtr.y = this.anchorCtr.y + 6;
         this.btn_decoRight.x = this.tx_background.width - 20;
      }
      
      private function updateBuff(buffId:uint) : void {
         var key:String = null;
         var currentBuff:BuffItem = null;
         var delayKey:String = null;
         var buff:Object = this.fightApi.getBuffById(buffId,this._nPlayerId);
         if(buff)
         {
            key = BuffItem.getKey(buff);
            currentBuff = this._buffItems[key];
            if(!currentBuff)
            {
               delayKey = BuffItem.getDelayKey(buff);
               currentBuff = this._buffItems[delayKey];
               if(!currentBuff)
               {
                  this.sysApi.log(16,"Trying to update a non-existing buff (" + key + ")");
                  return;
               }
               delete this._buffItems[delayKey];
               this._buffItems[key] = currentBuff;
               currentBuff.btn_buff.name = "buff_" + key;
            }
            else
            {
               currentBuff.update(buff);
               this.updateUi();
            }
         }
      }
      
      private function internalAddBuff(buff:Object) : void {
         var buffItem:BuffItem = null;
         var b:Object = null;
         var key:String = BuffItem.getKey(buff);
         if(this._buffItems.hasOwnProperty(key))
         {
            this._buffItems[key].addBuff(buff);
         }
         else
         {
            buffItem = this.newBuffItem(buff);
            this._buffItems[key] = buffItem;
         }
         var i:int = 0;
         while(i < this._durationSort.length)
         {
            b = this._durationSort[i];
            if(b.duration < buff.effects.duration)
            {
               break;
            }
            i++;
         }
         this._durationSort.splice(i,0,buff.effects);
      }
      
      private function addBuff(buffId:uint) : void {
         var buff:Object = this.fightApi.getBuffById(buffId,this._nPlayerId);
         this.internalAddBuff(buff);
         this.updateUi();
      }
      
      private function removeBuff(buff:Object) : void {
         var b:Object = null;
         this.removeBuffItem(buff,BuffItem.getKey(buff));
         this.removeBuffItem(buff,BuffItem.getDelayKey(buff));
         var i:int = 0;
         while(i < this._durationSort.length)
         {
            b = this._durationSort[i];
            if(b == buff)
            {
               this._durationSort.splice(i,1);
               break;
            }
            i++;
         }
         this.updateUi();
      }
      
      private function removeBuffItem(buff:Object, key:String) : void {
         var buffItem:BuffItem = this._buffItems[key];
         if(!buffItem)
         {
            return;
         }
         buffItem.removeBuff(buff);
         if(buffItem.buffs.length == 0)
         {
            delete this._buffItems[key];
         }
      }
      
      private function refreshBuffTooltips() : void {
         var key:String = null;
         var buffItem:BuffItem = null;
         var effects:Array = null;
         var buff:Object = null;
         var name:String = null;
         var ew:EffectsWrapper = null;
         if(this._rollOverTarget)
         {
            key = this._rollOverTarget.name.substr(5,this._rollOverTarget.name.length);
            buffItem = this._buffItems[key];
            if(buffItem)
            {
               effects = new Array();
               this._casterId = -1;
               for each(buff in buffItem.buffs)
               {
                  effects.push(buff.effects);
                  this._casterId = buff.source;
               }
               if(this.fightApi)
               {
                  name = this.fightApi.getFighterName(this._casterId);
                  ew = this.fightApi.createEffectsWrapper(buffItem.spell,effects,name);
                  if(this._casterId != -1)
                  {
                     this.sysApi.sendAction(new TimelineEntityOver(this._casterId,false));
                  }
                  this.uiApi.showTooltip(ew,this._rollOverTarget,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,10,null,null,null,null,false,5);
               }
            }
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_decoRight:
               this.folded = this.btn_decoRight.selected;
               break;
         }
      }
      
      public function get expanded() : Boolean {
         return this._expanded;
      }
      
      public function set expanded(val:Boolean) : void {
         if(val != this._expanded)
         {
            this._expanded = val;
            if(this._expanded)
            {
               this.buffListCtr.visible = false;
               this.tx_background.visible = false;
               this.updateUi();
            }
            else
            {
               this.buffListCtr.visible = true;
               this.tx_background.visible = true;
               this.uiApi.hideTooltip("effectsDuration");
               this.uiApi.unloadUi("tooltip_effectDuration");
               this.updateUi();
            }
         }
      }
      
      public function onUiLoaded(name:String) : void {
         var tooltipUi:* = undefined;
         if(name == "tooltip_effectsDuration")
         {
            tooltipUi = this.uiApi.getUi(name);
            tooltipUi.x = 0;
            tooltipUi.y = 0;
            this.expandedCtr.width = tooltipUi.width;
            if(tooltipUi.height > 500)
            {
               this.expandedCtr.height = 500;
            }
            else
            {
               this.expandedCtr.height = tooltipUi.height;
            }
            this.expandedCtr.addContent(tooltipUi);
            tooltipUi.x = -tooltipUi.width + 5;
            tooltipUi.y = -tooltipUi.height + 45;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var effectsList:Object = null;
         if(target.name.substr(0,4) == "buff")
         {
            this._rollOverTarget = target;
            this.refreshBuffTooltips();
         }
         else if(target == this.btn_decoRight)
         {
            effectsList = this.fightApi.getAllBuffEffects(this._nPlayerId);
            if((!(effectsList == null)) && (effectsList.categories.length > 0))
            {
               this.uiApi.showTooltip(effectsList,target,false,"standard",this.sysApi.getEnum("com.ankamagames.berilia.types.LocationEnum").POINT_BOTTOMRIGHT);
            }
         }
         
      }
      
      public function onRollOut(target:Object) : void {
         if(this._casterId != -1)
         {
            if(this.sysApi)
            {
               this.sysApi.sendAction(new TimelineEntityOut(this._casterId));
            }
         }
         this._rollOverTarget = null;
         if(this.uiApi)
         {
            this.uiApi.hideTooltip();
         }
      }
      
      public function onBuffUpdate(buffID:uint, targetId:int) : void {
         if(targetId == this._nPlayerId)
         {
            this.updateBuff(buffID);
         }
      }
      
      public function onBuffAdd(buffID:uint, targetId:int) : void {
         if(targetId == this._nPlayerId)
         {
            this.addBuff(buffID);
         }
      }
      
      public function onBuffRemove(buff:Object, targetId:int, reason:String) : void {
         if(targetId == this._nPlayerId)
         {
            this.removeBuff(buff);
         }
      }
      
      public function onGameFightTurnStart(id:int, waitTime:int, turnPicture:Object) : void {
         var buffItem:BuffItem = null;
         if(id == this.playerApi.id())
         {
            this._lastWasPlayer = true;
         }
         else if(this._lastWasPlayer)
         {
            for each(buffItem in this._buffItems)
            {
               buffItem.updateCooldown();
            }
            this._lastWasPlayer = false;
         }
         
      }
   }
}
